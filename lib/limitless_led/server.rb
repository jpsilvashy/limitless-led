require 'eventmachine'

require 'date'
require 'rainbow'
require 'color'

module LimitlessLed
  class Server < EM::Connection

    def initialize(host: 'localhost', port: 8899)
      @bridge = LimitlessLed::Bridge.new(host: host, port: port)
    end

    def receive_data(command)
      @bridge.run command
    end

  end
end
