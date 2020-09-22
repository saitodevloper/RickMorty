import UIKit

class Origin {
    var name: String?
    var url: String?
    
    init(jsonDict: [String: Any]) {
        name = jsonDict["name"] as? String ?? ""
        url = jsonDict["url"] as? String ?? ""
    }
}
