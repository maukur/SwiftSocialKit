import Foundation
import UIKit
import TikTokOpenShareSDK

extension TikTokShareKit {
    
    /**
     * Posts a video to TikTok using the TikTok SDK.
     *
     * This asynchronous function saves the provided video to the photo library first,
     * then uses the obtained local identifier to share the video to TikTok.
     * It requires the TikTok app to be installed and properly configured.
     *
     * - Parameters:
     *   - video: The URL of the local video file to be posted to TikTok
     *   - redriectURI: The URI to redirect to after the TikTok sharing process
     * - Returns: A TikTokShareState enum value indicating the result of the sharing operation:
     *   - postedWithSuccess: The video was successfully posted to TikTok
     *   - failedToPost: Failed to save the video or share it to TikTok
     *
     * - Note: This operation first saves the video to the photo library, requiring photo library permissions
     * - Note: This function calls an internal shareVideoToTikTok method for the actual sharing process
     * - Important: Requires the TikTok app to be installed and configured with the appropriate permissions
     *
     * @MainActor ensures this function runs on the main thread for UI operations
     */
    @MainActor
    public func postVideoAsTikTok(video: URL, redriectURI: String) async -> TikTokShareState {
        
        // Retrieve video, save to photos and get local identifier
        guard let videoIdentifier = try? await video.saveVideoToPhotos() else {
            LogManager.tikTokShareKit.addLog("TikTok: Video URL couldn't be loaded.")
            return .failedToPost
        }

        // Post video to Tiktok
        guard let _ = try? await shareVideoToTikTok(
            localIdentifier: videoIdentifier,
            redriectURI: redriectURI)
        else {
            return .failedToPost
        }
        
        LogManager.tikTokShareKit.addLog("TikTok: Video wa posted successfully.")
        
        return .postedWithSuccess
    }
    
    @MainActor
    private func shareVideoToTikTok(localIdentifier: String, redriectURI: String) async throws -> TikTokShareResponse {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                let shareRequest = TikTokShareRequest(
                    localIdentifiers: [localIdentifier],
                    mediaType: .video,
                    redirectURI: redriectURI
                )
                shareRequest.shareFormat = .normal
                LogManager.tikTokShareKit.addLog("Sending share request with localIdentifier: \(localIdentifier)")
                shareRequest.send { response in
                    LogManager.tikTokShareKit.addLog("Full TikTok Response: \(String(describing: response))")
                    if let shareResponse = response as? TikTokShareResponse {
                        LogManager.tikTokShareKit.addLog("Error Code: \(shareResponse.errorCode.rawValue)")
                        LogManager.tikTokShareKit.addLog("Error Description: \(shareResponse.errorDescription ?? "None")")
                        if shareResponse.errorCode == .noError {
                            Task { @MainActor in
                                continuation.resume(returning: shareResponse)
                            }
                        } else {
                            LogManager.tikTokShareKit.addLog("Tiktok posting failed with errorCode: \(shareResponse.errorCode)")
                            continuation.resume(throwing: NSError(
                                domain: "TikTok",
                                code: Int(shareResponse.errorCode.rawValue),
                                userInfo: [NSLocalizedDescriptionKey: shareResponse.errorDescription ?? "Unknown error"]
                            ))
                        }
                    } else {
                        LogManager.tikTokShareKit.addLog("Tiktok posting failed")
                        continuation.resume(throwing: NSError(
                            domain: "TikTok",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "Invalid response"]
                        ))
                    }
                }
            }
        }
    }
}
