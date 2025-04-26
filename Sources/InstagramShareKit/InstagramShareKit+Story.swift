import Foundation
import UIKit

extension InstagramShareKit {
    
    /**
     * Posts a photo as an Instagram Story using the Instagram app's URL scheme.
     *
     * This function takes a UIImage and attempts to share it as a Story through the Instagram app.
     * It verifies the Instagram app is installed, converts the image to PNG data, and uses the pasteboard
     * to transfer the image data along with the app's Facebook ID to Instagram.
     *
     * - Parameter photo: The UIImage to be posted as an Instagram Story
     * - Returns: An InstagramShareState enum value indicating the result of the sharing operation:
     *   - .postedWithSuccess: The photo was successfully passed to Instagram
     *   - .failedToPost: Failed to create the URL scheme or convert the image to data
     *   - .instagramNotInstalled: Instagram app is not installed or URL scheme is invalid
     *
     * - Note: This requires the Instagram app to be installed on the device
     * - Note: The pasteboard items expire after 5 minutes
     * - Important: Facebook Developer App ID must be properly configured in the class
     *
     * @MainActor ensures this function runs on the main thread for UI operations
     */
    @MainActor
    public func postPhotoAsStory(_ photo: UIImage) -> InstagramShareState {
        
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
    
    /**
     * Posts a video as an Instagram Story using the Instagram app's URL scheme.
     *
     * This function takes a local video URL and attempts to share it as a Story through the Instagram app.
     * It verifies the Instagram app is installed, reads the video data from the provided URL, and uses
     * the pasteboard to transfer the video data along with the app's Facebook ID to Instagram.
     *
     * - Parameter video: The URL of the local video file to be posted as a Story
     * - Returns: An InstagramShareState enum value indicating the result of the sharing operation:
     *   - .postedWithSuccess: The video was successfully passed to Instagram
     *   - .failedToPost: Failed to create the URL scheme or read the video data
     *   - .instagramNotInstalled: Instagram app is not installed or URL scheme is invalid
     *
     * - Note: This requires the Instagram app to be installed on the device
     * - Note: The pasteboard items expire after 5 minutes
     * - Important: Facebook Developer App ID must be properly configured in the class
     *
     * @MainActor ensures this function runs on the main thread for UI operations
     */
    @MainActor
    public func postVideoAsStory(_ video: URL) -> InstagramShareState {
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
