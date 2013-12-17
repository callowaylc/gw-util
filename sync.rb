#!/usr/bin/env ruby
# Author:      Christian Calloway callowaylc@gmail
# Description: Responsible for syncing 


### REQUIRES

require 'mysql2'
require 'csv'

### CONSTANTS 

DIR_APPLICATIONS = '/var/www'


### MAIN

# iterate through directories 
Pathname.glob(DIR_APPLICATIONS + '/*/').map(&:basename).each do | directory | 
	puts directory
	exit
end