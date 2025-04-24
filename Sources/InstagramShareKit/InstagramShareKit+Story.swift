import Foundation
import UIKit

extension InstagramShareKit {
    
    @MainActor
    public func postPhotoAsStory(_ photo: UIImage) -> ShareState {
        
        // Log start of posting process
        LogManager.instagramShareKit.addLog("Starting Instagram Story post process", level: .info)
        
        guard let urlScheme = URL(string: "instagram-stories://share?source_application=\(self.facebookID)") else {
            LogManager.instagramShareKit.addLog("Instagram Story: URL Scheme couldn't be verified", level: .error)
            return .failedToPost
        }
        
        guard UIApplication.shared.canOpenURL(urlScheme) else {
            LogManager.instagramShareKit.addLog("Instagram Story: URL couldn't be opened", input: urlScheme.absoluteString, level: .error)
            return .instagramNotInstalled
        }

        guard let imageData: Data = photo.pngData() else {
            LogManager.instagramShareKit.addLog("Instagram Story: Image Data couldn't be loaded", level: .error)
            return .failedToPost
        }
        
        LogManager.instagramShareKit.addLog("Instagram Story: Image data successfully prepared", input: "\(imageData.count) bytes", level: .debug)
            
        let items = [["com.instagram.sharedSticker.backgroundImage": imageData]]
        let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
        UIPasteboard.general.setItems(items, options: pasteboardOptions)
        
        LogManager.instagramShareKit.addLog("Instagram Story: Opening Instagram with URL", input: urlScheme.absoluteString, level: .info)
        UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
        
        LogManager.instagramShareKit.addLog("Instagram Story post process completed successfully", level: .info)
        return .postedWithSuccess
    }
    
    @MainActor
    public func postVideoAsStory(_ video: URL) -> ShareState {
        
        LogManager.instagramShareKit.addLog("Posting Instagram Story Video.")
                
        // Use the video-specific URL scheme for Instagram Stories
        guard let urlScheme = URL(string: "instagram-stories://share?source_application=\(self.facebookID)") else {
            LogManager.instagramShareKit.addLog("Instagram Story: URL Scheme couldn't be verified.")
            return .failedToPost
        }
        
        guard UIApplication.shared.canOpenURL(urlScheme) else {
            LogManager.instagramShareKit.addLog("Instagram Story: URL couldn't be opened. \(urlScheme)")
            return .instagramNotInstalled
        }
        
        // Get the video data from the URL
        do {
            let videoData = try Data(contentsOf: video)
            
            // Create pasteboard items with the video data
            let items = [["com.instagram.sharedSticker.backgroundVideo": videoData]]
            let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
            
            // Set the data on the pasteboard
            UIPasteboard.general.setItems(items, options: pasteboardOptions)
            
            LogManager.instagramShareKit.addLog("Posting Instagram Story Video with URL \(urlScheme.absoluteString)")
            
            // Open Instagram
            UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
            
            return .postedWithSuccess
        } catch {
            LogManager.instagramShareKit.addLog("Instagram Story: Failed to read video data: \(error.localizedDescription)")
            return .failedToPost
        }
    }
}
