# LimitlessLed

[![Build Status](https://travis-ci.org/jpsilvashy/limitless-led.png?branch=master)](https://travis-ci.org/jpsilvashy/limitless-led)

## Installation

Add this line to your application's Gemfile:

    gem 'limitless-led'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install limitless-led

## Usage

``` ruby
require 'limitless_led'

# If you don't have a LimitlessLED handy you can start the development
# server by running bin/server, it logs to stdout
bridge = LimitlessLed::Bridge.new(host: 'localhost', port: 8899)

# Send in hex like this:
bridge.color "#ff0000"

# You can send a triple
bridge.color "#f00"

# Again if you don't have the LimitlessLED, you can create an instance
# of the development server, we run it in an eventmachine reactor loop
# in bin/server
server = LimitlessLed::Server.new(host: 'localhost', port: 8899)

# Then you can see what the server does when it receives messages
server.receive_data("\x40\x00\xff")
```

## Contributing

1. Fork it ( http://github.com/jpsilvashy/limitless-led/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
