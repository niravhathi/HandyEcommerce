//
//  ProductViewModel.swift
//  HeadyECommerce
//
//  Created by Nirav Hathi on 7/4/20.
//  Copyright © 2020 Nirav Hathi. All rights reserved.
//

import Foundation
import RealmSwift

class ProductViewModel {
    var productList: List<Products>?
    func getProductListBy(_ id: Int) {
        self.productList = DatabaseManager.shared.getProductByCategory(id)
    }
    func  getProductListSortedBy(_ tag: Int, id: Int = 0) {
        getProductListBy(id)
        if(tag == 0) {
            let productList = self.productList?.sorted(byKeyPath: "view_count", ascending: true)
            self.productList = productList?.toArray(ofType: Products.self)
        } else if(tag == 1) {
            let productList = self.productList?.sorted(byKeyPath: "order_count", ascending: true)
            self.productList = productList?.toArray(ofType: Products.self)
        } else if(tag == 2) {
            let productList = self.productList?.sorted(byKeyPath: "shares", ascending: true)
            self.productList = productList?.toArray(ofType: Products.self)
        }
        
    }
    func getProductsCount() -> Int {
        return productList?.count ?? 0
    }
}
extension Results {
    func toArray<T>(ofType: T.Type) -> List<T> {
        var array = List<T>()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
