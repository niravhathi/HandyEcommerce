import Foundation
import SwiftyJSON
import RealmSwift

class Products: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var date_added = ""
    var variants = List<Variants>()
    @objc dynamic var tax: Tax?
    @objc dynamic var view_count = 0
    @objc dynamic var order_count = 0
    @objc dynamic var shares = 0
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    static func with(json: JSON) -> List<Products> {
        let products = List<Products>()
        for obj in json.arrayValue {
            let product = Products()
            if obj["id"].exists() {
                product.id = obj["id"].intValue
            }
            if obj["name"].exists() {
                product.name = obj["name"].string ?? ""
            }
            if obj["date_added"].exists() {
                product.date_added = obj["date_added"].string ?? ""
            }
            if obj["tax"].exists() {
                let tax = Tax.with(json: obj["tax"])
                product.tax = tax
            }
            if obj["variants"].exists() {
                let variants = Variants.with(json: obj["variants"])
                product.variants = variants
            }
            //            if obj["view_count"].exists() {
            //                product.view_count = obj["view_count"].intValue
            //            }
            //            if obj["order_count"].exists() {
            //                product.order_count = obj["order_count"].intValue
            //            }
            //            if obj["shares"].exists() {
            //                product.shares = obj["shares"].intValue
            //            }
            products.append(product)
        }
        
        return products
    }
    
    static func withRankingViewCount(json: JSON) -> List<Products> {
        let products = List<Products>()
        for obj in json.arrayValue {
            let realm = try! Realm()
            
            let product =  realm.object(ofType: Products.self, forPrimaryKey: obj["id"].intValue)
            try! realm.write {
                if obj["view_count"].exists() {
                    product?.view_count = obj["view_count"].intValue
                }
            }
            products.append(product ?? Products())
        }
        
        return products
    }
    static func withRankingShares(json: JSON) -> List<Products> {
            let products = List<Products>()
            for obj in json.arrayValue {
                let realm = try! Realm()
                
                let product =  realm.object(ofType: Products.self, forPrimaryKey: obj["id"].intValue)
                try! realm.write {
                    if obj["shares"].exists() {
                        product?.shares = obj["shares"].intValue
                    }
                }
                products.append(product ?? Products())
            }
            
            return products
        }
    static func withRankingOrderCount(json: JSON) -> List<Products> {
            let products = List<Products>()
            for obj in json.arrayValue {
                let realm = try! Realm()
                
                let product =  realm.object(ofType: Products.self, forPrimaryKey: obj["id"].intValue)
                try! realm.write {
                    if obj["order_count"].exists() {
                        product?.order_count = obj["order_count"].intValue
                    }
                 }
                products.append(product ?? Products())
            }
            
            return products
        }
}

