Pod::Spec.new do |s|
  s.name = "MapboxDirections"
  s.version = "1.1.4"
  s.summary = "Mapbox Directions API wrapper for Swift and Objective-C."
  s.description = <<-DESC
  MapboxDirections.swift makes it easy to connect your iOS, macOS, tvOS, or watchOS application to the Mapbox Directions API. Quickly get driving, cycling, or walking directions, whether the trip is nonstop or it has multiple stopping points, all using a simple interface reminiscent of MapKit’s `MKDirections` API. The Mapbox Directions API is powered by the OSRM routing engine and open data from the OpenStreetMap project.
                   DESC
  s.homepage = "https://swcode.io"
  s.license = { :type => "ISC", :file => "LICENSE.md" }
  s.author = { "SWCode" => "info@swcode.io" }

  s.swift_version = "5"
  s.ios.deployment_target = "12.1"

  s.source = { :git => "https://github.com/sw-code/flitsmeister-navigation-ios.git", :tag => "#{s.version.to_s}" }
  s.source_files  = ["MapboxDirections/**/*.{h,m,swift}"]

  s.requires_arc = true
  s.module_name = "MapboxDirections"

  s.dependency "Polyline", "~> 5.1.0"
end
