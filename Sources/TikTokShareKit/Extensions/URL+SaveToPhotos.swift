import Foundation
import Photos

extension URL {
    
    func saveVideoToPhotos() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            PHPhotoLibrary.requestAuthorization { status in
                guard status == .authorized else {
                    continuation.resume(throwing: NSError(
                        domain: "Photos",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "No Photos access"]))
                    return
                }

                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: self)
                }) { success, error in
                    if success {
                        let fetchOptions = PHFetchOptions()
                        fetchOptions.sortDescriptors = [NSSortDescriptor(
                            key: "creationDate",
                            ascending: false)]
                        if let asset = PHAsset.fetchAssets(with: .video, options: fetchOptions).firstObject {
                            continuation.resume(returning: asset.localIdentifier)
                        } else {
                            continuation.resume(throwing: NSError(
                                domain: "Photos",
                                code: -2,
                                userInfo: [NSLocalizedDescriptionKey: "No asset found"]))
                        }
                    } else {
                        continuation.resume(throwing: error ?? NSError(
                            domain: "Photos",
                            code: -3,
                            userInfo: [NSLocalizedDescriptionKey: "Unknown error"]))
                    }
                }
            }
        }
    }
}
