# SwiftSocialKit

**SwiftSocialKit** is a Swift package that enables simple sharing of media content (photos, videos) to Instagram and TikTok, as well as direct saving to the device. It is already successfully used in the app [One Hundred Questions](https://100questions.club).

## Features

- Share images and videos to Instagram Stories  
- Share videos to TikTok and Instagram Reels  
- Save media directly to the device  
- Built natively in Swift  

## Installation

Use Swift Package Manager to add the package to your project:
```text
https://github.com/your-username/SocialHubKit.git
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
