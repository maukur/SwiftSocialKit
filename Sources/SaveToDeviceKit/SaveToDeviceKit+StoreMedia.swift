import Foundation
import UIKit

extension SaveToDeviceKit {
    
    public func saveImage(photo: UIImage) async -> SaveState {
        LogManager.swiftSocialKit.addLog("Starting image save process", level: .info)
        
        // try to store the image
        do {
            LogManager.swiftSocialKit.addLog("Attempting to save image to photos", level: .debug)
            try await photo.saveImageToPhotos()
            LogManager.swiftSocialKit.addLog("Image saved successfully", level: .info)
            return .savedSuccessfully
        } catch {
            if let error = error as? UIImage.SavePhotoError {
                switch error {
                case .notAuthorized:
                    LogManager.swiftSocialKit.addLog("Failed to save image: not authorized", level: .error)
                    return .appNotAuthorizedToPhotos
                case .unknownError:
                    LogManager.swiftSocialKit.addLog("Failed to save image: unknown error", level: .error)
                    return .failedToSave
                }
            
            // error couldn't be identified, display something went wrong error
            } else {
                LogManager.swiftSocialKit.addLog("Failed to save image: unidentified error", input: error.localizedDescription, level: .error)
                return .failedToSave
            }
        }
    }
    
    public func saveVideo(video: URL) async -> SaveState {
        LogManager.swiftSocialKit.addLog("Starting video save process", input: video.lastPathComponent, level: .info)
        
        // Try to store the video
        do {
            LogManager.swiftSocialKit.addLog("Attempting to save video to photos", level: .debug)
            try await video.saveVideoToPhotos()
            LogManager.swiftSocialKit.addLog("Video saved successfully", level: .info)
            return .savedSuccessfully
        } catch {
            if let error = error as? URL.SaveVideoError {
                switch error {
                case .notAuthorized:
                    LogManager.swiftSocialKit.addLog("Failed to save video: not authorized", level: .error)
                    return .appNotAuthorizedToPhotos
                case .unknownError:
                    LogManager.swiftSocialKit.addLog("Failed to save video: unknown error", level: .error)
                    return .failedToSave
                }
            
            // Error couldn't be identified, display something went wrong error
            } else {
                LogManager.swiftSocialKit.addLog("Failed to save video: unidentified error", input: error.localizedDescription, level: .error)
                return .failedToSave
            }
        }
    }
}
