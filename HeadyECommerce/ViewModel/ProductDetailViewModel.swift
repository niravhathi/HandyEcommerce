//
//  ProductDetailViewModel.swift
//  HeadyECommerce
//
//  Created by Nirav Hathi on 7/4/20.
//  Copyright © 2020 Nirav Hathi. All rights reserved.
//

import Foundation
import RealmSwift

class ProductDetailsViewModel {
    var product: Products?
    func getProductBy(_ id: Int) {
            self.product = DatabaseManager.shared.getProduct(id)
    }
    func getVariantsCount() -> Int {
        return product?.variants.count ?? 0
    }
}
