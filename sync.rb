#!/usr/bin/env ruby
# Author:      Christian Calloway callowaylc@gmail
# Description: Responsible for syncing applications against bare repo


### REQUIRES

require 'git'
require 'time'
require 'pathname'

### CONSTANTS 

DIR_APPLICATIONS = '/home/ubuntu/Develop'

### FUNCTIONS


### MAIN
puts "Syncing repos #{Time.now}"

# iterate through directories 
Pathname.glob(DIR_APPLICATIONS + '/*/').each do | directory | 

	# ensure that directory is git enabled
	begin
		git     = Git.open directory
		logtime = git.log.first.date 

	rescue Exception => e
		raise "#{directory} is not a git repo!"

	end

	# change to application directory
	Dir.chdir directory

	# attempt a commit; this will fail if nothing to do
	begin
		git.add
		git.commit_all "AUTOSYNC UPDATE"
		git.pull
		git.push
	rescue
	end

end if File.exist? '/tmp/production'
