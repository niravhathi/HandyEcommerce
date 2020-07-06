//
//  DatabaseManager.swift
//  HeadyECommerce
//
//  Created by Nirav Hathi on 7/4/20.
//  Copyright © 2020 Nirav Hathi. All rights reserved.
//

import Foundation
import RealmSwift
class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init(){}
    func storeData(_ data: Object) {
        let realm = try! Realm()
             print(realm.configuration.fileURL)
        try! realm.write {
            realm.create(DataRoot.self, value: data, update: .all)
        }
    }
    func getAllData(completion: @escaping (DataRoot) -> Void) {
        var realm: Realm?
        var results: Results<DataRoot>?
        var dataRoot: DataRoot?
        let operationQueue = OperationQueue()
        let blockOperation = BlockOperation {
            DispatchQueue.main.async {
                dataRoot = DataRoot()
                realm = try! Realm()
                results = realm?.objects(DataRoot.self)
                if(results?.count ?? 0 > 0) {
                    dataRoot?.categories = results?[0].categories ??  List<Categories>()
                    dataRoot?.rankings = results?[0].rankings ?? List<Rankings>()
                    dataRoot?.id = 0
                   // print(results?[0].categories[0].name ?? "")
                    completion(dataRoot ?? DataRoot())
                }
            }
        }
        let blockOperation1 = BlockOperation {
            
        }
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperation(blockOperation)
        blockOperation1.addDependency(blockOperation)
        operationQueue.addOperation(blockOperation1)
    }
    func getProductByCategory(_ id: Int) -> List<Products> {
        let realm = try! Realm()
        let categories = realm.objects(Categories.self).filter("id == \(id)")
        if(categories.count > 0) {
            return categories[0].products
        }
        return List<Products>()
        
    }
    func getProduct(_ id: Int) -> Products {
        let realm = try! Realm()
        let product = realm.object(ofType: Products.self, forPrimaryKey: id) ?? Products()
        return product
        
    }
}
