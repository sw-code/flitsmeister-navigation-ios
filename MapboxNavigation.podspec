Pod::Spec.new do |s|
  s.name = "MapboxNavigation"
  s.version = "1.1.4"
  s.summary = "Complete turn-by-turn navigation interface for iOS."

  s.description  = <<-DESC
  The Mapbox Navigation SDK for iOS is a drop-in interface for turn-by-turn navigation along a route, complete with a well-designed map and easy-to-understand spoken directions. Routes are powered by Mapbox Directions.
                   DESC
  s.homepage = "https://swcode.io"
  s.license = { :type => "ISC", :file => "LICENSE.md" }
  s.author = { "SWCode" => "info@swcode.io" }

  s.swift_version = "5"
  s.ios.deployment_target = "12.1"

  s.source = { :git => "https://github.com/sw-code/flitsmeister-navigation-ios.git", :tag => "#{s.version.to_s}" }
  s.source_files = ["MapboxNavigation/**/*.{h,m,swift}", "MapboxCoreNavigation/{Date,Sequence,String}.swift"]
  s.resources = ["MapboxNavigation/Resources/*/*", "MapboxNavigation/Resources/*"]

  s.requires_arc = true
  s.module_name = "MapboxNavigation"

  s.dependency "MapboxCoreNavigation", "~> 1.1.3"
  s.dependency "MapboxDirections", "~> 1.1.3"
  s.dependency "MapboxGeocoder", "~> 1.1.3"
  s.dependency "MapboxSpeech", "~> 1.1.3"
  s.dependency "Solar", "~> 2.1"
  s.dependency "Turf", "~> 1.1.3"
end
