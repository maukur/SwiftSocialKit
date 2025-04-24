import Foundation
import UIKit

extension InstagramShareKit {
    
    @MainActor
    public func postInstagramStoryPhoto(photo: UIImage) -> ShareState {
        
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
        
        LogManager.instagramShareKit.addLog("Instagram Story: Copying data to pasteboard with 5 minute expiration", level: .debug)
        UIPasteboard.general.setItems(items, options: pasteboardOptions)
        
        LogManager.instagramShareKit.addLog("Instagram Story: Opening Instagram with URL", input: urlScheme.absoluteString, level: .info)
        UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
        
        LogManager.instagramShareKit.addLog("Instagram Story post process completed successfully", level: .info)
        return .postedWithSuccess
    }
    
}
