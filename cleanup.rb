#!/usr/bin/env ruby
require 'date'

monthly = {}
daily = {}
now = Date.today
snapshots = `sudo zfs list -H -t snapshot`
snapshots.split("\n").reverse.each do |l| # keep oldest snapshot (daily or monthly)
  if l.match /^backup\/.*@20/
    name = l.split("\t").first
    date = Date.parse name.split("@").last
    device = name.split("@").first.sub(/^backup\//,'')
    daydiff = (now-date).to_i
    monthly[device] ||= []
    monthly[device][date.year] ||= []
    monthly[device][date.year][date.month] ||= []
    monthly[device][date.year][date.month] << name 
    daily[device] ||= []
    daily[device][date.year] ||= []
    daily[device][date.year][date.month] ||= []
    daily[device][date.year][date.month][date.day] ||= []
    daily[device][date.year][date.month][date.day] << name
    if daydiff > 2 # delete hourly snapshots
      puts `sudo zfs destroy -v "#{name}"` unless daily[device][date.year][date.month][date.day].size <= 1
      if daydiff > 31 # delete daily snapshots
        puts `sudo zfs destroy -v "#{name}"` unless monthly[device][date.year][date.month].size <= 1
      end
    end
  else
		puts "#{l} ignored."
	end
end
