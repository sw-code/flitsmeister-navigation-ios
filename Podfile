platform :ios, '12.1'
inhibit_all_warnings!
install! 'cocoapods', :share_schemes_for_development_pods => false

workspace 'MapboxNavigation'
project 'MapboxNavigation.xcodeproj'

source 'https://cdn.cocoapods.org/'

post_install do |pi|
  pi.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.1'
    end
  end
end

target 'Example-Swift' do
  use_frameworks!

  # Pods for Example-Swift

end

target 'MapboxCoreNavigation' do
  use_frameworks!

  # Pods for MapboxCoreNavigation

  target 'MapboxCoreNavigationTests' do
    # Pods for testing
  end

end

target 'MapboxDirections' do
  use_frameworks!

  # Pods for MapboxDirections

end

target 'MapboxGeocoder' do
  use_frameworks!

  # Pods for MapboxGeocoder

end

target 'MapboxNavigation' do
  use_frameworks!

  # Pods for MapboxNavigation

  target 'MapboxNavigationTests' do
    # Pods for testing
  end

end

target 'MapboxNavigationUI' do
  use_frameworks!

  # Pods for MapboxNavigationUI

end

target 'MapboxSpeech' do
  use_frameworks!

  # Pods for MapboxSpeech

end

target 'RouteTest' do
  use_frameworks!

  # Pods for RouteTest

end

target 'Turf' do
  use_frameworks!

  # Pods for Turf

end
