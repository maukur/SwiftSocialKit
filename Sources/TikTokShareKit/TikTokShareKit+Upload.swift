import Foundation
import UIKit
import TikTokOpenShareSDK

extension TikTokShareKit {
    
    func postVideoAsTikTok(video: URL, redriectURI: String) async -> TikTokShareState {
        
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
