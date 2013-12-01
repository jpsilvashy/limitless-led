#!/usr/bin/env ruby

require 'limitless_led'

# If you don't have a LimitlessLED handy you can start the development
# server by running bin/server, it logs to stdout
bridge = LimitlessLed::Bridge.new(host: 'localhost', port: 8899)

# Send in hex like this:
bridge.color "#ff0000"

# You can send a triple
bridge.color "#f00"

# Again if you don't have the LimitlessLED, you can create an instance
# of the development server
server = LimitlessLed::Server.new(host: 'localhost', port: 8899)

# Then you can see what the server does when it receives messages
server.receive_data("\x40\x00\xff")



