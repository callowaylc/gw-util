#!/usr/bin/env ruby

require 'eventmachine'
require 'socket'

module Server
    def receive_data(data)
        `sudo service varnish restart` if data =~ /varnish/
    end
end

EM.run { EM.start_server IPSocket.getaddress(Socket.gethostname), 8383, Server }
