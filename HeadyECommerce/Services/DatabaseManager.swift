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
    let realm = try! Realm()
    private init(){}
    func storeData<T: Object>(_ data: Object, type : T.Type) {
        print(realm.configuration.fileURL!)
        print(data)
        try! realm.write {
            realm.create(type, value: data, update: .all)
        }
    }
    func getAllData(completion: @escaping (DataRoot) -> Void) {
        var results: Results<DataRoot>?
        var dataRoot: DataRoot?
        let operationQueue = OperationQueue()
        let blockOperation = BlockOperation {
            DispatchQueue.main.async {
                dataRoot = DataRoot()
                results = self.realm.objects(DataRoot.self)
                if(results?.count ?? 0 > 0) {
                    dataRoot?.categories = results?[0].categories ??  List<Categories>()
                    dataRoot?.rankings = results?[0].rankings ?? List<Rankings>()
                    dataRoot?.id = 0
                    completion(dataRoot ?? DataRoot())
                }
            }
        }
        let blockOperation1 = BlockOperation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                print(results?[0].categories[0].name ?? "")
            }
        }
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperation(blockOperation)
        blockOperation1.addDependency(blockOperation)
        operationQueue.addOperation(blockOperation1)
    }
    
    func getAllData() -> DataRoot {
        var realm: Realm?
        var results: DataRoot?
        var dataRoot: DataRoot?
        dataRoot = DataRoot()
        realm = try! Realm()
        results = realm?.object(ofType: DataRoot.self, forPrimaryKey: 0)
        if(results != nil) {
            dataRoot?.categories = results?.categories ??  List<Categories>()
            if(dataRoot?.categories.count == 0) {
                dataRoot?.categories =  List<Categories>()
                dataRoot?.categories = realm?.objects(Categories.self).toArray(ofType: Categories.self) ?? List<Categories>()
            }
            if(dataRoot?.rankings.count == 0) {
                dataRoot?.rankings = List<Rankings>()
                  dataRoot?.rankings = realm?.objects(Rankings.self).toArray(ofType: Rankings.self) ?? List<Rankings>()
            }
            dataRoot?.id = 0
        }
        return dataRoot ?? DataRoot()
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
extension Results {
    func toArray<T>(ofType: T.Type) -> List<T> {
        let array = List<T>()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
