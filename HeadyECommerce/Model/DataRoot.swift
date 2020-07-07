import Foundation
import SwiftyJSON
import RealmSwift

class DataRoot: Object {
    var categories = List<Categories>()
    var rankings = List<Rankings>()
    @objc dynamic var id = 0
    static let operationQueue = OperationQueue()
    
    override class func primaryKey() -> String {
        return "id"
    }
    static func with(json: JSON) -> DataRoot {
        print(json)
        let dataRoot = DataRoot()
        if json["id"].exists() {
            dataRoot.id = json["id"].intValue
        } else {
            dataRoot.id = 0
        }
        if json["categories"].exists() {
            let categories = Categories.with(json: json["categories"])
            dataRoot.categories = categories
        }
        return dataRoot
    }
}

