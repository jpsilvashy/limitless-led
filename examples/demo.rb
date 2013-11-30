#!/usr/bin/env ruby

require 'limitless_led'

# You can start the proxy server bin/server
bridge = LimitlessLed::Bridge.new

# Change LED to red
bridge.color "#ff0000"


