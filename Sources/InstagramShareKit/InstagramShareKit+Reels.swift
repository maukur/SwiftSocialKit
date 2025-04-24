import Foundation
import UIKit

extension InstagramShareKit {
    
    @MainActor
    public func postVideoAsReel(_ video: URL) -> ShareState {
        
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
