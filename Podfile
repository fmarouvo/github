source 'https://cdn.cocoapods.org/'

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '13.1'

target 'Github' do
	# Comment the next line if you don't want to use dynamic frameworks
	use_frameworks!

	# Pods for Github
	pod 'Alamofire'
	pod 'RxAlamofire'
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'Kingfisher'

	target 'GithubTests' do
		inherit! :search_paths
    pod 'RxBlocking', '6.5.0'
    pod 'RxTest', '6.5.0'
	end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.1'
      end
    end
  end

end
