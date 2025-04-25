# TikTokShareKit Setup

## Requirements:

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

## Integration:

### App Delegate

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

### If using SceneDelegate, also add the following

```swift
import TikTokOpenSDKCore

func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let url = URLContexts.first?.url {
        _ = TikTokURLHandler.handleOpenURL(url)
    }
}
```
