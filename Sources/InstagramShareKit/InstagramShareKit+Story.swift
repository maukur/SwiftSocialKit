import Foundation
import UIKit

extension InstagramShareKit {
    
    @MainActor
    public func postInstagramStoryPhoto (photo: UIImage) -> ShareState {
        
        guard let urlScheme = URL(string: "instagram-stories://share?source_application=\(self.facebookID)") else {
            //Logger.ui.addLog("Instagram Story: URL Scheme couldn't be verified.")
            return .failedToPost
        }
        
        guard UIApplication.shared.canOpenURL(urlScheme) else {
           // Logger.ui.addLog("Instagram Story: URL couldn't be opened. \(urlScheme)")
            return .instagramNotInstalled
        }

        guard let imageData: Data = photo.pngData() else {
          //  Logger.ui.addLog("Instagram Story: Image Data couldn't be loaded.")
            return .failedToPost
        }
            
        let items = [["com.instagram.sharedSticker.backgroundImage": imageData]]
        let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
        
        UIPasteboard.general.setItems(items, options: pasteboardOptions)
        
      //  Logger.app.addLog("Posting Instagram Story with URL \(urlScheme.absoluteString)")
        
        UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
        
        return .postedWithSuccess
    }
    
}
