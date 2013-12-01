# LimitlessLed

[![Build Status](https://travis-ci.org/jpsilvashy/limitless-led.png?branch=master)](https://travis-ci.org/jpsilvashy/limitless-led)

A Ruby gem for controlling the [LimitlessLED v3.0 RGBW color-changing light bulbs](http://www.limitlessled.com/), based on the official [LimitlessLED API documentation](http://www.limitlessled.com/dev/).

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'limitless-led'
```

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

# Send data straight to the bridge:
bridge.send_packet "\x40\x00\x55"

# Send a lot of data to the bridge very quickly:
10.times do
  (0..255).each do |int|
    bridge.send_packet "\x40#{ int.chr }\x55"
    sleep 0.005
  end
end


# Again if you don't have the LimitlessLED, you can create an instance
# of the development server
server = LimitlessLed::Server.new(host: 'localhost', port: 8899)

# Then you can see what the server does when it receives messages
server.receive_data("\x40\x00\xff")
```

_View more demos in the [/examples](https://github.com/jpsilvashy/limitless-led/tree/master/examples) directory_

If you are using the development server you should see this output:

![Output](https://www.evernote.com/shard/s5/sh/df5047a2-faa4-4985-98a7-63d86d8a131d/e45fb64438bc946c37c13d88c2dd412d/deep/0/output.jpg)

**As a note,** since we are transforming the colors from RGB to HSL and then back for representing the color in the console (which additionally is more limiting than the true color space offered by the LED) some of the hex values may not exactly match, especially near the dark limit. Since we are controlling the the brightness of the LED separately, and do not have access to the saturation some colors maybe be harder to reproduce than others, especially dark colors.

## Contributors

- [Nate Clark](https://github.com/heythisisnate)
- [Curtis Gagliardi](https://github.com/cgag)

*_This originally was a fork of [hired/limitless-led](https://github.com/hired/limitless-led) but quickly grew larger in scope so I decided to move it to a new repo._

## Contributing
1. Fork it ( http://github.com/jpsilvashy/limitless-led/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

