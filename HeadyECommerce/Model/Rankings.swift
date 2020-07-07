import Foundation
import SwiftyJSON
import RealmSwift

class Rankings: Object {
    @objc dynamic var ranking = ""
    static func with(json: JSON) {
        let rankings = Rankings()
        if json["ranking"].exists() {
            rankings.ranking = json["ranking"].string ?? ""
        }
        if(rankings.ranking == "Most Viewed Products") {
            for obj in json["products"].arrayValue {
                let realm = try! Realm()
                let product =  realm.object(ofType: Products.self, forPrimaryKey: obj["id"].intValue)
                try! realm.write {
                    if obj["view_count"].exists() {
                        product?.view_count = obj["view_count"].intValue
                    }
                }
            }
            
        }
        if(rankings.ranking == "Most OrdeRed Products") {
            for obj in json["products"].arrayValue {
                let realm = try! Realm()
                let product =  realm.object(ofType: Products.self, forPrimaryKey: obj["id"].intValue)
                try! realm.write {
                    if obj["order_count"].exists() {
                        product?.order_count = obj["order_count"].intValue
                    }
                }
            }
            
        }
        if(rankings.ranking == "Most ShaRed Products") {
            for obj in json["products"].arrayValue {
                let realm = try! Realm()
                let product =  realm.object(ofType: Products.self, forPrimaryKey: obj["id"].intValue)
                try! realm.write {
                    if obj["shares"].exists() {
                        product?.shares = obj["shares"].intValue
                    }
                }
            }
            
        }
    }
    
}

