Pod::Spec.new do |s|
    s.name             = 'SwiftSocialKit'
    s.version          = '1.1.0'
    s.summary          = 'A collection of social sharing utilities for iOS'
    s.description      = <<-DESC
  SwiftSocialKit provides easy-to-use components for sharing content with social platforms
  and saving media to device. It includes modules for Instagram sharing, TikTok sharing, 
  and saving content to the user's device.
                         DESC
    s.homepage         = 'https://github.com/nicolaischneider/SwiftSocialKit'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Nicolai Schneider' => 'nicolaischneiderdev@gmail.com' }
    s.source           = { :git => 'https://github.com/nicolaischneider/SwiftSocialKit.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '13.0'
    s.swift_version = '6.1'
    
    s.subspec 'SaveToDeviceKit' do |ss|
      ss.source_files = 'Sources/SaveToDeviceKit/**/*'
    end
    
    s.subspec 'InstagramShareKit' do |ss|
      ss.source_files = 'Sources/InstagramShareKit/**/*'
    end
    
    s.subspec 'TikTokShareKit' do |ss|
      ss.source_files = 'Sources/TikTokShareKit/**/*'
      ss.dependency 'TikTokOpenSDKCore', '~> 2.5.0'
      ss.dependency 'TikTokOpenShareSDK', '~> 2.5.0'
    end
  end