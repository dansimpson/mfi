$:.push File.expand_path("../lib", __FILE__)

require "mfi"

spec = Gem::Specification.new do |s|
  s.name = "mfi"
  s.version = MFi::Version
  s.license = "MIT"
  s.date = "2013-11-02"
  s.summary = "gem for integrating with Ubiquiti mFi sensors and devices"
  s.email = "dan.simpson@gmail.com"
  s.homepage = "https://github.com/dansimpson/mfi"
  s.description = "gem for integrating with Ubiquiti mFi sensors and devices"
  s.has_rdoc = true
  
  s.authors = ["Dan Simpson"]
  s.add_dependency("net-ssh", ">= 2.0.0")
  s.add_dependency("json", ">= 1.8.1")

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

end
