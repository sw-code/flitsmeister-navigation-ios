Pod::Spec.new do |s|
  s.name = "MapboxCoreNavigation"
  s.version = "1.1.0"
  s.summary = "Core components for turn-by-turn navigation on iOS."
  s.description  = <<-DESC
  Mapbox Core Navigation provides the core spatial and timing logic for turn-by-turn navigation along a route. For a complete turn-by-turn navigation interface, use the Mapbox Navigation SDK for iOS (MapboxNavigation).
                   DESC
  s.homepage = "https://swcode.io"
  s.license = { :type => "ISC", :file => "LICENSE.md" }
  s.author = { "SWCode" => "info@swcode.io" }

  s.swift_version = "5"
  s.ios.deployment_target = "11.0"

  s.source = { :git => "https://github.com/sw-code/flitsmeister-navigation-ios.git", :tag => "v#{s.version.to_s}" }
  s.source_files = ["MapboxCoreNavigation/**/*.{h,m,swift}"]

  s.requires_arc = true
  s.module_name = "MapboxCoreNavigation"

  s.dependency "MapboxDirections", "#{s.version.to_s}"
  s.dependency "Turf", "#{s.version.to_s}"
end
