<p align="center">
    <img src="swift_social_kit_theme.png" width="1000" alt="SwiftSocialKit"/>
</p>

![Swift](https://img.shields.io/badge/Swift-6.1-orange) 
![iOS v13+](https://img.shields.io/badge/iOS-v13+-blue)
![License](https://img.shields.io/badge/License-MIT-green)

# SwiftSocialKit

**SwiftSocialKit** is a Swift Package that enables simple sharing of media content (photos, videos) to Instagram and TikTok, as well as direct saving to the device. It's so simple that it's literally just one function such as `postPhotoAsStory()` or `postVideoAsTikTok()`. SwiftSocialKit is currnetly used in the app [One Hundred Questions](https://100questions.club).

## Features

- Share images and videos to Instagram Stories  
- Share videos to TikTok and Instagram Reels  
- Save media directly to the device  
- Built natively in Swift  

## Installation

### Swift Package Manager

Use Swift Package Manager to add the package to your project:
```text
https://github.com/nicolaischneider/SwiftSocialKit.git
```

### CocoaPods

Add the following line to your `Podfile`:
```ruby
pod 'SwiftSocialKit'
```

Then run `pod install` and open your `.xcworkspace`.

If you only need specific components, you can install them individually:

```ruby
# For saving content to device only
pod 'SaveToDeviceKit'

# For Instagram sharing functionality
pod 'InstagramShareKit'

# For TikTok sharing functionality
pod 'TikTokShareKit'
```

## Setup

* **SaveToDeviceKit**: Find the Setup [here](Sources/SaveToDeviceKit/SETUP.md)
* **InstagramShareKit**: Find the Setup [here](Sources/InstagramShareKit/SETUP.md)
* **TikTokShareKit**: Find the Setup [here](Sources/TikTokShareKit/SETUP.md)

## Usage

All you need is access to your image/video and pass it on to the respective instance which will take care of the rest.

```swift
import InstagramShareKit
import SaveToDeviceKit
import TikTokShareKit

// Instagram
let instagramKit = InstagramShareKit(facebookID: "your-facebook-app-id")
let instagramState1 = instagramKit.postPhotoAsStory(yourUIImage)
let instagramState2 = instagramKit.postVideoAsStory(yourVideoURL)
let instagramState3 = instagramKit.postVideoAsReel(yourVideoURL)

// Save to device
let saveKit = SaveToDeviceKit()
let saveImageState = await saveKit.saveImage(photo: yourUIImage)
let saveVideoState = await saveKit.saveVideo(video: yourVideoURL)

// TikTok
let tiktokKit = TikTokShareKit()
let tiktokState = await tiktokKit.postVideoAsTikTok(video: yourVideoURL, redriectURI: "your-redirect-uri")
```

## Planned Features

- Support for Snapchat  
- Ability to add stickers to Instagram stories and reels  

## Third-Party Licenses

This app uses the following third party swift packages:
* [TikTokOpenSDK for iOS](https://chatgpt.com/c/681152ed-4d04-800d-acc0-4abcded16769): the licence can be found [here](ThirdPartyLicenses/TikTokOpenSDKLicense.md)
