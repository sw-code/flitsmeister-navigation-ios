Pod::Spec.new do |s|
  s.name = "MapboxGeocoder"
  s.version = "1.1.5"
  s.summary = "Mapbox Geocoding API for Swift and Objective-C."
  s.description  = <<-DESC
  MapboxGeocoder.swift makes it easy to connect your iOS, macOS, tvOS, or watchOS application to the Mapbox Geocoding API. MapboxGeocoder.swift exposes the power of the Carmen geocoder through a simple API similar to Core Location’s CLGeocoder.
                   DESC
  s.homepage = "https://swcode.io"
  s.license = { :type => "ISC", :file => "LICENSE.md" }
  s.author = { "SWCode" => "info@swcode.io" }

  s.swift_version = "5"
  s.ios.deployment_target = "12.1"
  s.ios.vendored_frameworks = ["Vendor/Mapbox.xcframework"]

  s.source        = { :git => "https://github.com/sw-code/flitsmeister-navigation-ios.git", :tag => "#{s.version.to_s}" }
  s.source_files  = ["MapboxGeocoder/**/*.{h,m,swift}"]

  s.requires_arc = true
  s.module_name = "MapboxGeocoder"
end
