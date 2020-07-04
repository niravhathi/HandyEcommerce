import Foundation
import SwiftyJSON
import RealmSwift

class Rankings: Object {
    @objc dynamic var ranking = ""
    var products = List<Products>()
    @objc dynamic var id = 0
    override class func primaryKey() -> String {
        return "id"
    }
    static func with(json: JSON) -> List<Rankings> {
        let rankings = List<Rankings>()
        var counter:Int = 0;
        for obj in json.arrayValue {
            let ranking =  Rankings()
            if obj["ranking"].exists() {
                ranking.ranking = obj["ranking"].string ?? ""
            }
            if json["id"].exists() {
                ranking.id = obj["id"].intValue
            } else {
                counter += 1
                ranking.id = counter
            }
            if obj["products"].exists() {
                if(ranking.ranking.contains("Viewed")) {
                    let products = Products.withRankingViewCount(json: obj["products"])
                    ranking.products = products
                }
               
            }
            if obj["products"].exists() {
                if(ranking.ranking.contains("OrdeRed")) {
                    let products = Products.withRankingOrderCount(json: obj["products"])
                    ranking.products = products
                }
               
            }
            if obj["products"].exists() {
                if(ranking.ranking.contains("ShaRed")) {
                    let products = Products.withRankingShares(json: obj["products"])
                    ranking.products = products
                }
               
            }
            
            rankings.append(ranking)
        }
        
        return rankings
    }
    
}

