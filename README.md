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

### Saving Media to Device

Add the following key to your `Info.plist`:
```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to save media.</string>
```

### Instagram Integration

#### Requirements:

- `NSPhotoLibraryUsageDescription`
- `LSApplicationQueriesSchemes`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>instagram-stories</string>
    <string>instagram-reels</string>
</array>
```

- Register your app with [Meta for Developers](https://developers.facebook.com/) to obtain a Facebook App ID.

### TikTok Integration

#### Requirements:

- Register your app with [TikTok for Developers](https://developers.tiktok.com/) to get your **Client Key**.
- Add the following to your `Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>tiktoksharesdkl</string>
    <string>snssdk1180</string>
    <string>snssdk1233</string>
</array>

<key>TikTokClientKey</key>
<string>YOUR_TIKTOK_CLIENT_KEY</string>

<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>YOUR_TIKTOK_CLIENT_KEY</string>
        </array>
    </dict>
</array>
```

#### AppDelegate Integration:
```swift
import TikTokOpenSDKCore

func application(_ app: UIApplication,
                 open url: URL,
                 options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    return TikTokURLHandler.handleOpenURL(url)
}

func application(_ application: UIApplication,
                 continue userActivity: NSUserActivity,
                 restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
       let url = userActivity.webpageURL {
        return TikTokURLHandler.handleOpenURL(url)
    }
    return false
}
```

#### If using SceneDelegate:
```swift
import TikTokOpenSDKCore

func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let url = URLContexts.first?.url {
        _ = TikTokURLHandler.handleOpenURL(url)
    }
}
```

## Planned Features

- Support for Snapchat  
- Ability to add stickers to Instagram stories and reels  
