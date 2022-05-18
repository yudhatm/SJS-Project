# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SJS+ Employee' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SJS+ Employee
  pod 'Cosmos', '~> 23.0'
  pod 'DZNEmptyDataSet'
  pod 'GoogleMaps', '6.2.1'
  pod 'GooglePlaces', '6.2.1'
  pod 'JTAppleCalendar', '~> 7.1'
  pod 'MagicPie'
  pod 'PureLayout'
  pod 'Sevruk-PageControl'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['Sevruk-PageControl'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.0'
      end
    end
  end
end
