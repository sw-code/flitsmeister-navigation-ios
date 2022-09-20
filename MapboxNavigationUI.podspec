Pod::Spec.new do |s|
  s.name = "MapboxNavigationUI"
  s.version = "1.1.5"
  s.summary = "Mapbox Navigation UI wrapper."
  s.description = <<-DESC
  MapboxNavigationUI makes it easy to open a navigation UI in your project.
                   DESC
  s.homepage = "https://swcode.io"
  s.license = { :type => "ISC", :file => "LICENSE.md" }
  s.author = { "SWCode" => "info@swcode.io" }

  s.swift_version = "5"
  s.ios.deployment_target = "12.1"

  s.source = { :git => "https://github.com/sw-code/flitsmeister-navigation-ios.git", :tag => "#{s.version.to_s}" }
  s.source_files = ["MapboxNavigationUI/**/*.{h,m,swift}"]

  s.requires_arc = true
  s.module_name = "MapboxNavigationUI"

  s.dependency "MapboxCoreNavigation"
  s.dependency "MapboxNavigation"
  s.dependency "MapboxDirections"
end
