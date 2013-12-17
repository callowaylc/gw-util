#!/usr/bin/env ruby
# Author:      Christian Calloway callowaylc@gmail
# Description: Responsible for syncing applications against bare repo


### REQUIRES

require 'git'
require 'date'

### CONSTANTS 

DIR_APPLICATIONS = '/var/www'

### FUNCTIONS


### MAIN


# iterate through directories 
Pathname.glob(DIR_APPLICATIONS + '/*/').map(&:basename).each do | directory | 

	# ensure that directory is git enabled
	begin
		git     = Git.open   directory
		logdate = Date.parse git.log.first.date 

	else
		raise "#{directory} is not a git repo!"

	end

	# change to application directory
	Dir.chdir directory


	# check if files have been updated since last run; only run
	# if last git time 
	file = nil

	Dir.glob("**/*").each do | path |

		# if file has been updated, then we need to flag that
		# an update/push must occur
		file = File.new path

		# break from block if file update time is greater than 
		# last log update time
		break if Date.parse(file.mtime) > logdate
	end 

	# lets check again if last file exceeds logdate; if the case we
	# need to fire off a push to master
	if Date.parse(file.mtime) > logdate
		git.commmit_all "Automatic REPO update #{file.mtime}"
		git.push(g.remote 'name')
	end

	


end