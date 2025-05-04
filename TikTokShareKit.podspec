Pod::Spec.new do |s|
    s.name             = 'TikTokShareKit'
    s.version          = '1.1.0'
    s.summary          = 'A library for sharing content to TikTok'
    s.description      = <<-DESC
    TikTokShareKit provides a simplified interface for sharing videos and other content
    to TikTok from your iOS application.
                            DESC
    s.homepage         = 'https://github.com/nicolaischneider/SwiftSocialKit'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Nicolai Schneider' => 'nicolaischneiderdev@gmail.com' }
    s.source           = { :git => 'https://github.com/nicolaischneider/SwiftSocialKit.git', :tag => s.version.to_s }

    s.ios.deployment_target = '13.0'
    s.swift_version = '6.1'

    s.source_files = 'Sources/TikTokShareKit/**/*'
    s.dependency 'TikTokOpenSDKCore', '~> 2.5.0'
    s.dependency 'TikTokOpenShareSDK', '~> 2.5.0'
end