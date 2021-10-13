Pod::Spec.new do |s|
  s.name = "MapboxSpeech"
  s.version = "1.1.0"
  s.summary = "A speech synthesizer built on AWS Polly for Swift and Objective-C."
  s.description  = <<-DESC
   MapboxSpeech makes it easy to connect your iOS, macOS, tvOS, or watchOS application to the Mapbox Speech API. Quickly get audio files from a text string.
                   DESC
  s.homepage = "https://swcode.io"
  s.license = { :type => "ISC", :file => "LICENSE.md" }
  s.author = { "SWCode" => "info@swcode.io" }

  s.swift_version = "5"
  s.ios.deployment_target = "11.0"

  s.source = { :git => "https://github.com/sw-code/flitsmeister-navigation-ios.git", :tag => "v#{s.version.to_s}" }
  s.source_files = ["MapboxSpeech/**/*.{h,m,swift}"]

  s.requires_arc = true
  s.module_name = "MapboxSpeech"
end
