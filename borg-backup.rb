#!/usr/bin/env ruby

pwd = File.read(".pwd")
root = "/media/nfs/mirror/"
Dir[File.join(root,"*")].each do |dir|
  unless Dir[File.join(dir,"*")].empty?
    p dir
    date = `date +%Y-%m-%dT%H:%M:%S`.chomp
    system({"BORG_PASSPHRASE" => pwd}, "borg create -v --stats --compression zlib /media/nfs/backup::#{File.basename(dir)}-#{date} #{dir}" )
  end
end
