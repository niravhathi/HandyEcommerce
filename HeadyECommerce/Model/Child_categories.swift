import Foundation
import SwiftyJSON
import RealmSwift

class Child_categories: Object {
    dynamic var value = 0
    static func with(json: JSON) -> Tax? {
        let tax = Tax()
        if json["name"].exists() {
            tax.name = json["name"].string ?? ""
        }
        if json["value"].exists() {
            tax.value = json["value"].doubleValue
        }
        return tax
    }
}

