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
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
