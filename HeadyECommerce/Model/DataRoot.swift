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
        let dataRoot = DataRoot()
        let blockOperation = BlockOperation {
            if json["id"].exists() {
                dataRoot.id = json["id"].intValue
            } else {
                dataRoot.id = 0
            }
            if json["categories"].exists() {
                let categories = Categories.with(json: json["categories"])
                dataRoot.categories = categories
            }
        }
        let blockOperations2 = BlockOperation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if json["rankings"].exists() {
                    let rankings = Rankings.with(json: json["rankings"])
                    dataRoot.rankings = rankings
                }
            }
        }
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperation(blockOperation)
        blockOperations2.addDependency(blockOperation)
        operationQueue.addOperation(blockOperations2)
        return dataRoot
    }
}

