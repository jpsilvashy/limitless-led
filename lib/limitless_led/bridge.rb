#!/usr/bin/ruby

require 'socket'

module LimitlessLed
  class Bridge
    include LimitlessLed::Logger
    attr_accessor :host, :port

    def initialize(host: 'localhost', port: 8899)
      @host = host
      @port = port
    end

    VALID_COMMANDS = (65..77).to_a

    def socket
      @socket ||= begin
        UDPSocket.new.tap do |socket|
          socket.connect host, port
        end
      end
    end

    # Sends the actual bytes to the real bridge/led over the UDP socket method.
    #
    # Usage:
    #
    #   # Default
    #   send_packet "\x40\xff\x55"
    #
    # Options:
    #
    # +packet+::  the bytes to send to the device
    #
    def send_packet(packet)
      socket.send packet, 0
    end

    # This sets the color of the LED with a hex value for the color the packets
    # are sent to the socket for the command
    #
    # Usage:
    #
    #   # Default
    #   color '#ff0000'
    #
    # Options:
    #
    # +color+::  The color in the hex format rrggbb or rgb
    #
    def color(color)

      # receive color as string like #ff0000 or a triplet
      color = Color::RGB.from_html(color).to_hsl

      # Transform color into value out of 255
      hue = color.hue  / 360.0 * 255.0

      # send command
      send_packet "\x40#{ hue.to_i.chr }\x55"
    end

  end
end
