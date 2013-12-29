#!/usr/bin/env ruby
# Author:      Christian Calloway callowaylc@gmail
# Description: Responsible for shutting down instance if not
#              a production release


### REQUIRES

### CONSTANTS 

### FUNCTIONS

### MAIN

`shutdown -h now` if ENV['PRODUCTION'] != '1'