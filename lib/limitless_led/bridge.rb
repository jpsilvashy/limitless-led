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

    # this sends the actual bytes to the real bridge/led over the UDP socket method
    def send_packet(packet)
      socket.send packet, 0
    end

    # This method dispatches the raw command in bytes to the proper method used
    # to run commands for the led the first byte in the command code tells the
    # real led which command to expect, most commands are 3-4 bytes long total
    # and always end with 0x55
    def run(input)
      command = input.bytes

      case command.first
      when 64
        color command[1]
      when 65..77
          raise 'command not implemented'
      else
          log "invalid command received: #{command.first}: #{command}"
      end

    end

    private

    # this receives and integer as the color value from 0-255, this value
    # maps directly to the dial on the limitless-led controller and app where
    # the color at 12 o'clock is 0, the colors are mapped clockwise around
    # the dial with 255 being almost the same color as 0, this is because the
    # color space we are using is HSL.
    def color(color)

      # Turn second byte int a value out of 360, this is because HSL color maps
      # the hue on a radial scale so the first and last values are the same color
      color = color.to_f / 255.0 * 360.0

      # Rotate 90 degrees and flip to match dial ui on device
      hue = color - 90

      # Return the color
      color = Color::HSL.new( hue, 90, 50)

      # log the color that the device would be set to
      # TODO: this should only happen with the bridge is initialized with the verbose parameter as true
      log_color color

    end

  end
end
