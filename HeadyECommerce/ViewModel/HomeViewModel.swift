//
//  HomeViewModel.swift
//  HeadyECommerce
//
//  Created by Nirav Hathi on 7/4/20.
//  Copyright © 2020 Nirav Hathi. All rights reserved.
//

import Foundation
import RealmSwift
import KRProgressHUD
class HomeViewModel {
    var dataRoot: DataRoot?
    let operationQueue = OperationQueue()
    lazy var endPoint: String = {
        return "\(Constants.baseURL)\(Constants.endPoint)"
    }()
    
    func fetchData(completion: @escaping (Bool) -> Void) {
        if NetworkManager.shared.isReachableNetwork() {
            KRProgressHUD.show()
            let productAPIManager = ClientAPIManager()
            productAPIManager.getDataWith(for: endPoint) { (result) in
                switch result{
                case .Success(let data):
                    self.dataRoot = DataRoot.with(json: data)
                    DatabaseManager.shared.storeData(self.dataRoot ?? DataRoot(), type: DataRoot.self)
                    for rankObj in data["rankings"].arrayValue {
                        _  =  Rankings.with(json: rankObj)
                    }
                    KRProgressHUD.dismiss()
                    return completion(true)
                case .Error(let message):
                    print(message)
                    KRProgressHUD.dismiss()
                    return completion(false)
                }
            }
        } else {
            KRProgressHUD.show()
            self.dataRoot = DatabaseManager.shared.getAllData()
            if(self.dataRoot?.categories.count ?? 0 > 0) {
                KRProgressHUD.dismiss()
                return completion(true)
            } else {
                KRProgressHUD.dismiss()
                return completion(false)
            }
        }
    }
    func getCategoriesCount() -> Int {
        return dataRoot?.categories.count ?? 0
    }
}
