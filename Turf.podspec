Pod::Spec.new do |s|
  s.name = "Turf"
  s.version = "1.1.5"
  s.summary = "Simple spatial analysis."
  s.description = "A spatial analysis library written in Swift for native iOS, macOS, tvOS, watchOS, and Linux applications, ported from Turf.js."
  s.homepage = "https://swcode.io"
  s.license = { :type => "ISC", :file => "LICENSE.md" }
  s.author = { "SWCode" => "info@swcode.io" }

  s.swift_version = "5"
  s.platform = :ios, "12.1"
  s.platform = :ios
  s.ios.deployment_target = "12.1"

  s.source = { :git => "https://github.com/sw-code/flitsmeister-navigation-ios.git", :tag => "#{s.version.to_s}" }
  s.source_files = ["Turf/**/*.{swift,h}"]
  s.public_header_files = 'Turf/*.h'

  s.requires_arc = true
  s.module_name = "Turf"

  s.frameworks = "CoreLocation"
end
