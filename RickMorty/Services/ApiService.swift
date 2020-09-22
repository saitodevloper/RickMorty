import UIKit

class ApiService {
    static var instance = ApiService()
    private var url: URL?
    private init() {}
    
    func prepareGet(withUrl url: String) -> ApiService {
        self.url = URL(string: url)
        return self
    }
    
    func execute(completion: @escaping (_ result: Any?, _ next: String?) -> ()) {
        if let safeUrl = url {
            let dataTask = URLSession.shared.dataTask(with: safeUrl) { data, url, error in
                guard let safeData = data else {
                    completion(nil, nil)
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: safeData, options: .mutableContainers) as! [String: Any]
                    if json["results"] != nil {
                        let result = json["results"]
                        let info = json["info"] as! [String: Any]
                        let next = info["next"] as! String
                        DispatchQueue.main.async {
                            completion(result, next)
                        }
                    } else {
                        let result = json
                        DispatchQueue.main.async {
                            completion(result, nil)
                        }
                    }
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
            dataTask.resume()
        }
    }
}
