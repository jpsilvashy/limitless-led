#!/usr/bin/env ruby

require 'limitless_led'

# You can start the proxy server bin/server
bridge = LimitlessLed::Bridge.new

(0..255).each do |int|
  bridge.send_packet "\x40#{ int.to_s(16).hex.chr }\x55"
  sleep 0.025
end
