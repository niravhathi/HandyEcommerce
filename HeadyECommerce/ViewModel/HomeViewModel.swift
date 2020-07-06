//
//  HomeViewModel.swift
//  HeadyECommerce
//
//  Created by Nirav Hathi on 7/4/20.
//  Copyright © 2020 Nirav Hathi. All rights reserved.
//

import Foundation
import RealmSwift
class HomeViewModel {
    var dataRoot: DataRoot?
    let operationQueue = OperationQueue()
    lazy var endPoint: String = {
        return "\(Constants.baseURL)\(Constants.endPoint)"
    }()
    
    func fetchData(completion: @escaping (Bool) -> Void) {
        if NetworkManager.shared.isReachableNetwork() {
            let productAPIManager = ClientAPIManager()
            productAPIManager.getDataWith(for: endPoint) { (result) in
                switch result{
                case .Success(let data):
                    let blockOperation = BlockOperation {
                        DataRoot.with(json: data) { (dataRoot) in
                            self.dataRoot = dataRoot
                        }
                    }
                    let blockOperation1 = BlockOperation {
                            DatabaseManager.shared.storeData(self.dataRoot ?? DataRoot())
                    }
                    let blockOperations2 =  BlockOperation {
                        return completion(true)
                    }
                    self.operationQueue.maxConcurrentOperationCount = 1
                    self.operationQueue.addOperation(blockOperation)
                    blockOperation1.addDependency(blockOperation)
                    self.operationQueue.addOperation(blockOperation1)
                    blockOperations2.addDependency(blockOperation1)
                    self.operationQueue.addOperation(blockOperations2)
                case .Error(let message):
                    print(message)
                   return completion(false)
                }
            }
        } else {
           
            let blockOperation = BlockOperation {
                DatabaseManager.shared.getAllData { (dataRoot) in
                     self.dataRoot = dataRoot
                }
            }
           
            let blockOperation1 = BlockOperation {
                if(self.dataRoot?.categories.count ?? 0 > 0) {
                    return completion(true)
                } else {
                    return completion(false)
                }
            }
            self.operationQueue.maxConcurrentOperationCount = 1
            self.operationQueue.addOperation(blockOperation)
            blockOperation1.addDependency(blockOperation)
            self.operationQueue.addOperation(blockOperation1)
        }
    }
    func getCategoriesCount() -> Int {
        return dataRoot?.categories.count ?? 0
    }
}
