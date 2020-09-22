import UIKit

class Character {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: Origin
    var image: String?
    
    init(jsonDict: [String: Any]) {
        self.id = jsonDict["id"] as? Int ?? -1
        self.name = jsonDict["name"] as? String
        self.status = jsonDict["status"] as? String ?? ""
        self.species = jsonDict["species"] as? String ?? ""
        self.type = jsonDict["type"] as? String ?? ""
        self.gender = jsonDict["gender"] as? String ?? ""
        self.origin = Origin(jsonDict: jsonDict["origin"] as?  [String: Any] ?? [String: Any]())
        self.image = jsonDict["image"] as? String ?? ""
    }
}
