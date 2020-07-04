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
    lazy var endPoint: String = {
        return "\(Constants.baseURL)\(Constants.endPoint)"
    }()
    
    func fetchData(completion: @escaping (Result) -> Void) {
        let productAPIManager = ClientAPIManager()
        productAPIManager.getDataWith(for: endPoint) { (result) in
            switch result{
            case .Success(let data):
                self.dataRoot = DataRoot.with(json: data)
                let realm = try! Realm()
                try! realm.write {
                    realm.create(DataRoot.self, value: self.dataRoot ?? DataRoot(), update: .
                        all)
                }
                break
            case .Error(let message):
                print(message)
                break
                
            }
        }
    }
}
