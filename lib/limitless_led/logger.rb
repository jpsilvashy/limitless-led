#!/usr/bin/ruby

module LimitlessLed
  module Logger

    # Logs timestamp and message
    #
    # Usage:
    #
    #   # Default
    #   log "something happend"
    #
    # Options:
    #
    # +message+::  any string for the message you want to log
    #
    def log(message)
      puts "#{DateTime.now.to_s} : #{message}"
    end

    # This receives and integer as the color value from 0-255, this value
    # maps directly to the dial on the limitless-led controller and app where
    # the color at 12 o'clock is 0, the colors are mapped clockwise around
    # the dial with 255 being almost the same color as 0, this is because the
    # color space we are using is HSL.
    #
    # Usage:
    #
    #   # Default
    #   log_color 0
    #
    #   # Different color
    #   log_color 120
    #
    #   # HSL hue is radial so 255 is the same as 0
    #   log_color 255
    #
    # Options:
    #
    # +color+::  color 0-255
    #
    def log_color(color)

      # Turn second byte int a value out of 360, this is because HSL color maps
      # the hue on a radial scale so the first and last values are the same color
      hue= color.to_f / 255.0 * 360.0

      # Return the color
      color = Color::HSL.new( hue, 100, 50).to_rgb

      # Get each channel and prepare for loggers output
      red   = color.r * 255
      green = color.g * 255
      blue  = color.b * 255

      # Log the color and the hex of the color
      log '████████ '.color(red, green, blue) + color.html

    end

  end
end
