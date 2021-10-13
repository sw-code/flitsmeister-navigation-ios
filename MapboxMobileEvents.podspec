Pod::Spec.new do |s|
  s.name = 'MapboxMobileEvents'
  s.version = "0.5.0"
  s.summary = "Mapbox Mobile Events"

  s.description  = "Collects usage information to help Mapbox improve its products."
  s.homepage = "https://swcode.io"
  s.license = { :type => "ISC", :file => "LICENSE.md" }
  s.author = { "SWCode" => "info@swcode.io" }

  s.swift_version = '5'
  s.ios.deployment_target = "11.0"

  s.source = { :git => "https://github.com/sw-code/flitsmeister-navigation-ios.git", :tag => "v#{s.version.to_s}" }
  s.source_files = ["MapboxMobileEvents/**/*.{h,m}", "MapboxMobileEvents/Vendor/TrustKit/**/*.{h,m,c}"]
  s.resources = "MapboxMobileEvents/Resources/*"
  s.exclude_files = "MapboxMobileEvents/MMENamespacedDependencies.h"

  s.requires_arc = true
  s.module_name = 'MapboxMobileEvents'
  s.library = 'z'
end
