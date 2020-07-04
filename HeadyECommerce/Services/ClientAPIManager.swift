//
//  ClientAPIManager.swift
//  HeadyECommerce
//
//  Created by Nirav Hathi on 7/3/20.
//  Copyright © 2020 Nirav Hathi. All rights reserved.
//

import UIKit
import SwiftyJSON
class ClientAPIManager: NSObject {

    func getDataWith(for URLEndPoint:String, completion: @escaping (Result) -> Void) {
        guard let url = URL(
                string:URLEndPoint
            ) else {
                return completion(.Error("Invalid URL"))
            }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard error == nil
                else {
                    return completion(.Error(error!.localizedDescription))
            }
            guard let data = data
                else {
                    return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    completion(.Success(JSON(json)))

                }
            } catch let error {

                return completion(.Error(error.localizedDescription))
            }
            }.resume()
    }



}
