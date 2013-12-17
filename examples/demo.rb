#!/usr/bin/env ruby

require 'limitless_led'

# If you don't have a LimitlessLED handy you can start the development
# server by running bin/server, it logs to stdout
bridge = LimitlessLed::Bridge.new(host: 'localhost', port: 8899)

# Send in hex like this:
bridge.color "#ff0000"

# You can send a triple
bridge.color "#f00"

# Send data straight to the bridge:
bridge.send_packet "\x40\x00\x55"

# Send a lot of data to the bridge very quickly:
10.times do
  (0..255).each do |int|
    bridge.send_packet "\x40#{ int.chr }\x55"
    sleep 0.005
  end
end


# Again if you don't have the LimitlessLED, you can create an instance
# of the development server
server = LimitlessLed::Server.new(host: 'localhost', port: 8899)

# Then you can see what the server does when it receives messages
server.receive_data("\x40\x00\xff")
