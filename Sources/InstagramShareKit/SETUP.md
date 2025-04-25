# InstagramShareKit Setup

1. Register your app with [Meta for Developers](https://developers.facebook.com/) to obtain a Facebook App ID.

2. Update `info.plist` file:
- `NSPhotoLibraryUsageDescription`
- `LSApplicationQueriesSchemes`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>instagram-stories</string>
    <string>instagram-reels</string>
</array>
```

3. Initialize `InstagramShareKit` instance with *Facebook App ID*:

```swift
let instagramKit = InstagramShareKit(facebookID: <your_id>)
```
