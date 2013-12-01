#!/usr/bin/env ruby

# This example takes a photo and approximates the most dominant color in the image and changes
# the LED to match. Our example is using a remote image from a webcam, but you can put any
# image source uri.

# Install miro gem first
# https://github.com/jonbuda/miro
require 'miro'
require 'limitless_led'

# Source of image
colors = Miro::DominantColors.new('http://cdn.abclocal.go.com/three/kgo/webcam/tahoecam.jpg')

# Connect to bridge
bridge = LimitlessLed::Bridge.new(host: 'localhost', port: 8899)

# Send send most dominant color from image to the LED
bridge.color colors.to_hex[0]
