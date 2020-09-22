import UIKit

class ImageService {
    var dataTask: URLSessionDataTask? = nil
    
    func asyncDownloadImage(_ url: URL?, completion: @escaping (_ image: UIImage?, _ urlResultFrom: String?) -> ()) {
        if let safeUrl = url {
            self.dataTask = URLSession.shared.dataTask(with: safeUrl) { data, url, error in
                self.sendDataBack(data: data, url: url?.url?.absoluteString ?? "", completion: completion)
            }
            self.dataTask?.resume()
        } else {
            DispatchQueue.main.async {
                completion(nil, nil)
            }
        }
    }
    
    private func sendDataBack(data: Data?, url: String, completion: @escaping (_ image: UIImage?, _ urlResultFrom: String) -> ()) {
        var downloadedImage: UIImage?
        if let data = data {
            downloadedImage = UIImage(data: data)
        }
        
        DispatchQueue.main.async {
            completion(downloadedImage, url)
        }
    }
}
