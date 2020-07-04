import Foundation
import SwiftyJSON
import RealmSwift

class Categories: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    var products = List<Products>()
    var child_categories = List<Child_categories>()
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    static func with(json: JSON) -> List<Categories> {
        let categories = List<Categories>()
        for obj in json.arrayValue {
            let category =  Categories()
            if obj["products"].exists() {
                let products = Products.with(json: obj["products"])
                category.products = products
            }
            if obj["name"].exists() {
                category.name = obj["name"].string ?? ""
            }
            if obj["id"].exists() {
                category.id = obj["id"].intValue
            }
            categories.append(category)
            
        }
        return categories
    }
}

