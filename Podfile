# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

inhibit_all_warnings!


target 'sharex' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for sharex
pod 'Firebase/Auth'	
pod 'Firebase/Firestore'
pod 'Firebase/Functions'
pod 'Firebase/Storage'
pod 'Firebase/DynamicLinks'




  target 'sharexTests' do
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