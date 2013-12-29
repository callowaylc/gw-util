#!/usr/bin/env ruby
# Author:      Christian Calloway callowaylc@gmail
# Description: Responsible for syncing applications against bare repo


### REQUIRES

require 'git'
require 'time'
require 'pathname'

### CONSTANTS 

DIR_APPLICATIONS = '/var/www'

### FUNCTIONS


### MAIN


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
		git.commit_all "AUTOSYNC UPDATE"
		git.push
	rescue
	end

	begin
		# attempt to do a pull in case anything has been commited 
		git.pull
	rescue
	end

end