# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SJS+ Employee' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SJS+ Employee
  pod 'Alamofire'
  pod 'Cosmos', '~> 23.0'
  pod 'DropDown'
  pod 'DZNEmptyDataSet'
  pod 'FirebaseAuth'
  pod 'GoogleMaps', '6.2.1'
  pod 'GooglePlaces', '6.2.1'
  pod 'IGListKit', '~> 4.0'
  pod 'IQKeyboardManagerSwift'
  pod 'JTAppleCalendar', '~> 7.1'
  pod 'Kingfisher', '~> 7.0'
  pod 'LTHRadioButton'
  pod 'netfox'
  pod 'PureLayout'
  pod 'ProgressHUD'
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'Sevruk-PageControl'
  pod 'SwiftyJSON'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['Sevruk-PageControl'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.0'
      end
    end
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
