# SwiftSocialKit

**SwiftSocialKit** is a Swift package that enables simple of sharing media content (photos, videos) to Instagram and TikTok, as well as direct storage to the device. The package is already successfully being used in the app [One Hundred Questions](https://100questions.club).

## Features

- Share images and videos to Instagram Stories
- Share Videos to TikTok and Instagram Reels
- Save Media directly to the device
- Built with native Swift

## Setup

### Saving to Device

needs 
- Privacy - Photo Library Usage Description
- Queried URL Schemes: instagram-reels, instagram-stories

### Instagram

needs 
- Privacy - Photo Library Usage Description
- Queried URL Schemes: instagram-reels
- registration of app to meta for developer to get facebookID

### TikTok

needs
- registration of app to tiktok for developer to get clientID
- Queried URL Schemes: tiktoksharesdkl, snssdk1180, snssdk1233
- TikTokClientKey: client key
- URL types > URL Schemes > client key

add to app delegate
```swift
import TikTokOpenSDKCore

// Tiktok Handling
func application(_ app: UIApplication,
                 open url: URL,
                 options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    if TikTokURLHandler.handleOpenURL(url) {
        return true
    }
    return false
}
    
// Tiktok Handling
func application(_ application: UIApplication,
                 continue userActivity: NSUserActivity,
                 restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
        if TikTokURLHandler.handleOpenURL(userActivity.webpageURL) {
            return true
        }
    }
    return false
}
```

if scene delegate exists:
```swift
import TikTokOpenSDKCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    func scene(_ scene: UIScene, 
               openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if TikTokURLHandler.handleOpenURL(URLContexts.first?.url) {
            return
        }
    }

}
```

## Planned

- Support for Snapchat

## Installation

Add the package via Swift Package Manager:
```swift
https://github.com/your-username/SocialHubKit.git
```
