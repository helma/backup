#!/usr/bin/env ruby
require 'json'
require 'yaml'
require 'date'

hosts = `borg list /mnt/sda1/backup`.split("\n").collect do |l|
  name,date = l.chomp.split(/\s+/,2)
  name.sub(/-2.*/,'')+"-20"
end
hosts.uniq.each do |host|
  `borg prune -v --keep-within=2d --keep-daily=7 --keep-weekly=4 --keep-monthly=-1 --prefix #{host} /mnt/sda1/backup`
end
