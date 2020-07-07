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
    @IBOutlet weak var noDataAvailabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var homeViewModel: HomeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        homeViewModel.fetchData { (success) in
            if(success) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)  {
                    if(self.homeViewModel.getCategoriesCount() > 0) {
                        self.noDataAvailabel.isHidden = true
                        self.categoryCollectionView.isHidden = false
                        self.categoryCollectionView.reloadData()
                        
                    } else {
                        self.categoryCollectionView.isHidden = true
                        self.noDataAvailabel.isHidden = false
                    }
                    
                }
            } else {
                self.categoryCollectionView.isHidden = true
                self.noDataAvailabel.isHidden = false
            }
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
