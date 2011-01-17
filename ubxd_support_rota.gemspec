lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "ubxd_support_rota/version"

Gem::Specification.new do |s|
  s.name        = "ubxd_support_rota"
  s.version     = UBXDSupportRota::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tom ten Thij"]
  s.email       = ["ruby@tomtenthij.nl"]
  s.homepage    = "http://github.com/unboxed/ubxd_support_rota"
  s.summary     = "An easy way to generate the support rota for Unboxed Consulting in wiki markup"
  s.description = "An easy way to generate the support rota for Unboxed Consulting in wiki markup"

  s.files        = Dir.glob("{bin,lib,spec}/**/*")
  s.executables  = ['ubxd_support_rota']
  s.require_path = 'lib'
end
