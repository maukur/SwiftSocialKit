import Foundation
import UIKit

extension SaveToDeviceKit {
    
    /**
     * Saves a UIImage to the device's photo library.
     *
     * This asynchronous function attempts to save the provided image to the device's photo library
     * using the UIImage extension method saveImageToPhotos(). It handles authorization errors
     * and other potential failures during the save process.
     *
     * - Parameter photo: The UIImage to be saved to the photo library
     * - Returns: A SaveState enum value indicating the result of the save operation:
     *   - .savedSuccessfully: The image was successfully saved to the photo library
     *   - .appNotAuthorizedToPhotos: The app doesn't have permission to access the photo library
     *   - .failedToSave: The save operation failed due to an unknown error
     *
     * - Note: This operation requires photo library permissions to be granted by the user
     * - Important: The app's Info.plist must include the appropriate photo library usage description
     */
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
    
    /**
     * Saves a video file to the device's photo library.
     *
     * This asynchronous function attempts to save the video at the provided URL to the device's
     * photo library using the URL extension method saveVideoToPhotos(). It handles authorization
     * errors and other potential failures during the save process.
     *
     * - Parameter video: The URL of the local video file to be saved to the photo library
     * - Returns: A SaveState enum value indicating the result of the save operation:
     *   - .savedSuccessfully: The video was successfully saved to the photo library
     *   - .appNotAuthorizedToPhotos: The app doesn't have permission to access the photo library
     *   - .failedToSave: The save operation failed due to an unknown error
     *
     * - Note: This operation requires photo library permissions to be granted by the user
     * - Important: The app's Info.plist must include the appropriate photo library usage description
     */
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
