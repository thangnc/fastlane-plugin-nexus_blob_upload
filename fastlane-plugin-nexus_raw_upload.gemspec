lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/nexus_raw_upload/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-nexus_raw_upload'
  spec.version       = Fastlane::NexusRawUpload::VERSION
  spec.author        = 'Thang Nguyen'
  spec.email         = 'thang.nguyencao@gmail.com'

  spec.summary       = 'Actions related to Nexus blob upload'
  spec.homepage      = "https://github.com/thangnc/fastlane-plugin-nexus_raw_upload"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  # spec.add_dependency 'your-dependency', '~> 1.0.0'

  spec.add_development_dependency('bundler')
  spec.add_development_dependency('fastlane', '>= 2.206.2')
  spec.add_development_dependency('pry')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rspec_junit_formatter')
  spec.add_development_dependency('rubocop', '1.30.1')
  spec.add_development_dependency('rubocop-performance')
  spec.add_development_dependency('rubocop-require_tools')
  spec.add_development_dependency('simplecov')
end
