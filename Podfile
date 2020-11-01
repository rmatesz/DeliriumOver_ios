use_modular_headers!
use_frameworks!

source 'https://cdn.cocoapods.org/'

target "DeliriumOver" do
    pod 'RxSwift',  '~> 5.0'
    pod 'RxCocoa',  '~> 5.0'
    pod 'KxMenu'
    pod 'Firebase/Core'
    pod 'Firebase/Auth'
    pod 'Firebase/Database'
    pod 'Firebase/Crashlytics'
    pod 'Firebase/Analytics'
    pod 'Swinject', '~> 2.6.0'
    pod 'SwinjectStoryboard'
    pod 'Charts'
    pod 'SwiftLint'
    pod 'MaterialTapTargetPrompt-iOS'
end

target 'DeliriumOverTests' do
	pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
    pod 'RxSwift',  '~> 5.0'
    pod 'RxBlocking',  '~> 5.0'
    pod 'RxTest',  '~> 5.0'
    pod 'RxCocoa',  '~> 5.0'
    pod 'Cuckoo'
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
      end
    end
  end
end
