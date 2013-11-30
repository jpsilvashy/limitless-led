#!/usr/bin/ruby

require 'eventmachine'

require 'date'
require 'rainbow'
require 'color'

module LimitlessLed
  class Server < EM::Connection
    include LimitlessLed::Logger

    def initialize(host: 'localhost', port: 8899)
      @bridge = LimitlessLed::Bridge.new(host: host, port: port)
    end

    # This method dispatches the raw command in bytes to the proper method used
    # to run commands for the led the first byte in the command code tells the
    # real led which command to expect, most commands are 3-4 bytes long total
    # and always end with 0x55
    def receive_data(input)
      command = input.bytes

      case command.first
      when 64
        log_color command[1]
      when 65..77
        raise 'command not implemented'
      else
        log "invalid command received: #{command.first}: #{command}"
      end

    end

  end
end
