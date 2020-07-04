import Foundation
import SwiftyJSON
import RealmSwift

class Variants: Object {
    @objc dynamic var id = 0
    @objc dynamic var color = ""
    @objc dynamic var size = 0
    @objc dynamic var price = 0.0
    override class func primaryKey() -> String {
        return "id"
    }
    
    static func with(json: JSON) -> List<Variants> {
        let variants = List<Variants>()
        
        for obj in json.arrayValue {

            let variant =  Variants()
            if obj["id"].exists() {
                variant.id = obj["id"].intValue
            }
            if obj["color"].exists() {
                variant.color = obj["color"].string ?? ""
            }
            if obj["size"].exists() {
                variant.size = obj["size"].intValue
            }
            if obj["price"].exists() {
                variant.price = obj["price"].doubleValue
            }
            variants.append(variant)
        }
        
        return variants
    }
}

