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
    
    public func saveVideo(video: URL) async -> SaveState {
        // Try to store the video
        do {
            try await video.saveVideoToPhotos()
            return .savedSuccessfully
        } catch {
            if let error = error as? URL.SaveVideoError {
                switch error {
                case .notAuthorized:
                    return .appNotAuthorizedToPhotos
                case .unknownError:
                    return .failedToSave
                }
            
            // Error couldn't be identified, display something went wrong error
            } else {
                return .failedToSave
            }
        }
    }
}
