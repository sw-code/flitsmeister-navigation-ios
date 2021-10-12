Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "MapboxNavigationUI.swift"
  s.version      = "0.23.0"
  s.summary      = "Mapbox Navigation UI wrapper."

  s.description  = <<-DESC
  MapboxNavigationUI makes it easy to open a navigation UI in your project.
                   DESC

  s.homepage     = "https://www.swcode.io/"
  s.documentation_url = "https://github.com/sw-code/flitsmeister-navigation-ios"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.license      = { :type => "ISC", :file => "LICENSE.md" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "SWCode" => "developers@swcode.io" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  #  When using multiple platforms
  s.ios.deployment_target = "11.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/sw-code/flitsmeister-navigation-ios.git", :tag => "v#{s.version.to_s}" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  = ["MapboxNavigationUI", "MapboxNavigationUI/*/*"]

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.requires_arc = true
  s.module_name = "MapboxNavigationUI"
  s.swift_version = "4.0"

  s.dependency "MapboxCoreNavigation", "#{s.version.to_s}"
  s.dependency "MapboxNavigation", "#{s.version.to_s}"
  s.dependency "MapboxDirections", "#{s.version.to_s}"

end
