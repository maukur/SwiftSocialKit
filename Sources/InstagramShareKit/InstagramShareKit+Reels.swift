import Foundation
import UIKit

extension InstagramShareKit {
    
    /**
     * Posts a video as an Instagram Reel using the Instagram app's URL scheme.
     *
     * This function takes a local video URL and attempts to share it as a Reel through the Instagram app.
     * It converts the video to a Data object, verifies the Instagram app is installed, and uses the pasteboard
     * to transfer the video data along with the app's Facebook ID to Instagram.
     *
     * - Parameter video: The URL of the local video file to be posted as a Reel
     * - Returns: An InstagramShareState enum value indicating the result of the sharing operation:
     *   - .postedWithSuccess: The video was successfully passed to Instagram
     *   - .failedToPost: Failed to convert the video to a Data object
     *   - .instagramNotInstalled: Instagram app is not installed or URL scheme is invalid
     *
     * - Note: This requires the Instagram app to be installed on the device
     * - Note: The pasteboard items expire after 5 minutes
     * - Important: Facebook Developer App ID must be properly configured in the class
     *
     * @MainActor ensures this function runs on the main thread for UI operations
     */
    @MainActor
    public func postVideoAsReel(_ video: URL) -> InstagramShareState {
        
        LogManager.instagramShareKit.addLog("Starting to post video as reel", level: .default)
        
        guard let backgroundVideoData = try? Data.init(contentsOf: video) as Data else {
            LogManager.instagramShareKit.addLog("Failed to convert video to Data object", level: .default)
            return .failedToPost
        }
        
        LogManager.instagramShareKit.addLog("Successfully loaded video data with size: \(backgroundVideoData.count) bytes", level: .default)
        
        guard let urlScheme = URL(string: "instagram-reels://share"), UIApplication.shared.canOpenURL(urlScheme) else {
            LogManager.instagramShareKit.addLog("Instagram app not installed or URL scheme invalid", level: .default)
            return .instagramNotInstalled
        }
        
        LogManager.instagramShareKit.addLog("Instagram app is installed and URL scheme is valid", level: .default)
        
        let pasteboard = UIPasteboard.general
        
        // Add background video and appID to pasteboard items
        let pasteboardItems: [[String: Any]] = [
            ["com.instagram.sharedSticker.backgroundVideo": backgroundVideoData],
            ["com.instagram.sharedSticker.appID": self.facebookID]
        ]
        
        LogManager.instagramShareKit.addLog("Created pasteboard items with Facebook ID: \(self.facebookID)", level: .default)
        
        let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)] // 5 minutes
        pasteboard.setItems(pasteboardItems, options: pasteboardOptions)
        UIApplication.shared.open(urlScheme)
        
        LogManager.instagramShareKit.addLog("Successfully completed video sharing process", level: .default)
        return .postedWithSuccess
    }
}
