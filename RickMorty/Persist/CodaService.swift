import UIKit
import CoreData

class CodaService: NSObject {
    static func save(character: Character) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.insertNewObject(forEntityName: "Characters", into: managedContext)
        userEntity.setValue(character.id, forKey: "id")
        userEntity.setValue(character.name, forKey: "name")
        userEntity.setValue(character.gender, forKey: "gender")
        userEntity.setValue(character.origin.name, forKey: "origin")
        userEntity.setValue(character.status, forKey: "status")
        userEntity.setValue(character.image, forKey: "image")
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
    }
    
    static func retrive() -> [Character] {
        do {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
            var array = [Character]()
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Characters")
            let records = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for record in records {
                let char = Character(jsonDict: [String : Any]())
                char.id = record.value(forKey: "id") as? Int
                char.name = record.value(forKey: "name") as? String
                char.gender = record.value(forKey: "gender") as? String
                char.origin.name = record.value(forKey: "origin") as? String
                char.status = record.value(forKey: "status") as? String
                char.image = record.value(forKey: "image") as? String
                array.append(char)
            }
            return array
        } catch {
            print(error)
            return []
        }
    }
}
