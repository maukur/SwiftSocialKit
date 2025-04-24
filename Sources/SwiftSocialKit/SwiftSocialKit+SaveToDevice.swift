import Foundation
import UIKit

extension SwiftSocialKit {
    
    public func saveImage(photo: UIImage) async -> SaveState {
        // try to store the image
        do {
            try await photo.saveImageToPhotos()
            return .savedSuccessfully
        } catch {
            if let error = error as? UIImage.SavePhotoError {
                switch error {
                case .notAuthorized:
                    return .appNotAuthorizedToPhotos
                case .unknownError:
                    return .failedToSave
                }
            
            // error couldn't be identified, display something went wrong error
            } else {
                return .failedToSave
            }
        }
    }
    
    /*
    private func saveVideo() async -> ShareState {
        // Check whether video has been stored once already
        if mediaHasBeenStoredAlready {
            Logger.ui.addLog("Instagram Story: Video can't be stored again, since it already has been stored once. Dismiss View")
            return .error(LanguageManager.string("story.review.notification.image.already.posted"))
        }
        
        guard let url = self.finalVideoURL else {
            Logger.ui.addLog("Instagram Story: Video couldn't be loaded.")
            return .error(LanguageManager.string("story.review.notification.errorGeneral"))
        }
        
        // Try to store the video
        do {
            try await url.saveVideoToPhotos()
            mediaHasBeenStoredAlready = true
            await view.switchQuitDoneButton(quitToDone: true)
            return .imageStoredSuccessfully
        } catch {
            if let error = error as? URL.SaveVideoError {
                switch error {
                case .notAuthorized:
                    return .error(LanguageManager.string("story.review.download.error.not.authorized"))
                case .unknownError:
                    return .error(LanguageManager.string("story.review.download.error.unknown"))
                }
            
            // Error couldn't be identified, display something went wrong error
            } else {
                return .error(LanguageManager.string("story.review.download.error.unknown"))
            }
        }
    }*/
}
