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

    def send_packet(packet)
      socket.send packet, 0
    end

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

    #
    def color(color)

      # Turn second byte
      color = color.to_f / 255.0 * 360.0

      # Rotate 90 degrees and flip to match dial ui on device
      hue = color - 90

      # Return the color
      color = Color::HSL.new( hue, 90, 50)

      log_color color

    end

  end
end
