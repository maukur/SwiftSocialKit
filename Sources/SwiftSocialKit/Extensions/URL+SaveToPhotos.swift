import Foundation
import Photos

extension URL {
    
    enum SaveVideoError: Error {
        case notAuthorized
        case unknownError
    }
    
    func saveVideoToPhotos() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            PHPhotoLibrary.requestAuthorization { status in
                guard status == .authorized else {
                    continuation.resume(throwing: SaveVideoError.notAuthorized)
                    return
                }
                
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: self)
                }) { success, error in
                    if success {
                        continuation.resume()
                    } else {
                        print("Error saving video: \(error?.localizedDescription ?? "unknown error")")
                        continuation.resume(throwing: SaveVideoError.unknownError)
                    }
                }
            }
        }
    }
}
