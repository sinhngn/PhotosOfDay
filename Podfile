source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'PhotoToday' do
   pod 'Alamofire', '~> 4.4'
   pod 'SDWebImage', '~> 4.0'
   pod 'MBProgressHUD', '~> 1.0.0'
   pod 'NYTPhotoViewer', '~> 1.1.0'
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
