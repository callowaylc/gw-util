#!/usr/bin/env ruby

require 'eventmachine'

module Server
    def receive_data(data)
        exec(data) if data =~ /varnish/
    end
end

EM.run { EM.start_server 'localhost', 8383, Server }
