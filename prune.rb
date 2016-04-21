#!/usr/bin/env ruby
require 'date'

pwd = File.read(File.join(File.dirname(__FILE__),".pwd"))

hosts = `export BORG_PASSPHRASE=#{pwd}; borg list /mnt/sda1/backup`.split("\n").collect do |l|
  name,date = l.chomp.split(/\s+/,2)
  name.sub(/-2.*/,'')+"-20"
end
hosts.uniq.each do |host|
  `export BORG_PASSPHRASE=#{pwd}; borg prune -v --keep-within=2d --keep-daily=7 --keep-weekly=4 --keep-monthly=-1 --prefix #{host} /mnt/sda1/backup >> /tmp/borg-prune.log 2>&1`
end
