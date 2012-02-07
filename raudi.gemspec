# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "raudi"

Gem::Specification.new do |s|
  s.name        = "raudi"
  s.version     = Raudi.version
  s.authors     = ["Sergey Pchelincev"]
  s.email       = ["jalkoby91@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Raudi is adapter for programming avr controller without pain}
  s.description = %q{Raudi is adapter for programming avr controller without pain}

  s.rubyforge_project = "raudi"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # maybe in future
  # s.add_dependency 'activesupport'
  s.add_development_dependency "rspec", '>= 2.5'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'fuubar'
  s.add_development_dependency 'ruby_gntp'
  s.add_development_dependency 'ruby-debug19'

end
