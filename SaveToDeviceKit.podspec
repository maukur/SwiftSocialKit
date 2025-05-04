Pod::Spec.new do |s|
    s.name             = 'SaveToDeviceKit'
    s.version          = '1.1.0'
    s.summary          = 'A simple utility for saving media to iOS devices'
    s.description      = <<-DESC
    SaveToDeviceKit provides an easy-to-use interface for saving images, videos and other media
    content to an iOS device's photo library or files app.
                            DESC
    s.homepage         = 'https://github.com/nicolaischneider/SwiftSocialKit'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Nicolai Schneider' => 'nicolaischneiderdev@gmail.com' }
    s.source           = { :git => 'https://github.com/nicolaischneider/SwiftSocialKit.git', :tag => s.version.to_s }

    s.ios.deployment_target = '13.0'
    s.swift_version = '6.1'

    s.source_files = 'Sources/SaveToDeviceKit/**/*'
end