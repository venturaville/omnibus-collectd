# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omnibus-collectd/version"

Gem::Specification.new do |s|
  s.name        = "omnibus-collectd"
  s.version     = OmnibusCollectd::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = "https://github.com/jdutton/omnibus-collectd.git"
  s.summary     = %q{Collectd software for use with Omnibus}
  s.description = %q{Collectd software build descriptions for use with Omnibus}

  s.rubyforge_project = "omnibus-collectd"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
