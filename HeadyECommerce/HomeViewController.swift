//
//  HomeViewController.swift
//  HeadyECommerce
//
//  Created by Nirav Hathi on 7/3/20.
//  Copyright © 2020 Nirav Hathi. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift
class HomeViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var homeViewModel: HomeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        homeViewModel.fetchData { (success) in
            if(success) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)  {
                     self.categoryCollectionView.reloadData()
                }
            } else {
                
            }
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if let filePath = Bundle.main.path(forResource: "data", ofType: "json"), let data = NSData(contentsOfFile: filePath) {
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
//              //  print(json)
//                let dataRoot: DataRoot = DataRoot.with(json: JSON(json))
//              //  print(dataRoot.categories[0].name)
//
//                 let realm = try! Realm()
//
//
//                try! realm.write {
//                    realm.create(DataRoot.self, value: dataRoot, update: .
//                    all)
//                    //realm.add(dataRoot)
//                //     realm.create(Categories.self, value: dataRoot.categories, update: .modified)
//                 //   realm.create(Rankings.self, value: dataRoot.rankings, update: .modified)
//                 }
//                 let results = realm.objects(Categories.self)
//                 print(results[0].products[0].name)
//                print(dataRoot.categories[0].products[0].name)
//
//
////                do {
////                  try realm.write {
////
////                    print(dataRoot.categories[0].name)
////                    print(realm.configuration.fileURL)
////
////                    }
////                } catch let error as NSError {
////                    print("Erros \(error.localizedDescription)")
////                }
//
//
//
//
//            }
//            catch {
//                //Handle error
//            }
//        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProductViewController" {
            let productViewController = segue.destination as! ProductViewController
            productViewController.categoryId = sender as? Int
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.getCategoriesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let iCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        iCell.bind(category: homeViewModel.dataRoot?.categories[indexPath.row])
        return iCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: UIScreen.main.bounds.width/2 - 10, height: 250)
        return  size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowProductViewController", sender: homeViewModel.dataRoot?.categories[indexPath.row].id ?? 0)
    }
    
}
