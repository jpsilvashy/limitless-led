# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'limitless_led/version'

Gem::Specification.new do |spec|
  spec.name          = "limitless-led"
  spec.version       = LimitlessLed::VERSION
  spec.authors       = ["Joseph Silvashy"]
  spec.email         = ["jpsilvashy@gmail.com"]
  spec.summary       = %q{A Ruby gem for controlling the LimitlessLED v3.0 RGBW color-changing light bulbs.}
  spec.description   = %q{A Ruby gem for controlling the LimitlessLED v3.0 RGBW color-changing light bulbs, based on the official LimitlessLED API documentation.}
  spec.homepage      = "https://github.com/jpsilvashy/limitless-led"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "eventmachine"
  spec.add_dependency "color"
  spec.add_dependency "rainbow"

end
