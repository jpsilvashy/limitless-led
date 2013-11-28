require 'socket'

module LimitlessLed
  class Bridge

    VALID_COMMANDS = (65..77).to_a

    attr_reader :host, :port

    def initialize(host: 'localhost', port: 8899)
      @host = host
      @port = port
    end

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

        when 65
          raise "Not implemented"

        when 66
          raise "Not implemented"

        when 67
          raise "Not implemented"

        when 68
          raise "Not implemented"

        when 69
          raise "Not implemented"

        when 70
          raise "Not implemented"

        when 71
          raise "Not implemented"

        when 72
          raise "Not implemented"

        when 73
          raise "Not implemented"

        when 74
          raise "Not implemented"

        when 75
          raise "Not implemented"

        when 76
          raise "Not implemented"

        when 77
          raise "Not implemented"

        else
          log "invalid command recieved: #{command.first}: #{command}"
      end
    end

    private

    def color(color)

      # Turn second byte
      color = color.to_f / 255.0 * 360.0

      # Rotate 90 degrees and flip to match dial ui on device
      hue = color - 90

      # Return the color
      Color::HSL.new( hue, 90, 50).to_rgb

    end

  end
end
