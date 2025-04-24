import Photos
import UIKit

extension UIImage {
    
    enum SavePhotoError: Error {
        case notAuthorized
        case unknownError
    }
    
    func saveImageToPhotos() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            PHPhotoLibrary.requestAuthorization { status in
                guard status == .authorized else {
                    continuation.resume(throwing: SavePhotoError.notAuthorized)
                    return
                }
                
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: self)
                }) { success, error in
                    if success {
                        continuation.resume()
                    } else {
                        continuation.resume(throwing: SavePhotoError.unknownError)
                    }
                }
            }
        }
    }
}
