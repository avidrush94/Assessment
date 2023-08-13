# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Assessment' do
  
  use_frameworks!
  inhibit_all_warnings!

  # Pods for Assessment
  pod 'Alamofire'
  pod 'Kingfisher'
  pod 'IQKeyboardManager'

  target 'AssessmentTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
