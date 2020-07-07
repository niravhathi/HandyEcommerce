//
//  ProductDetailsViewController.swift
//  HeadyECommerce
//
//  Created by Nirav Hathi on 7/4/20.
//  Copyright © 2020 Nirav Hathi. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var variantCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var productDetailsViewModel: ProductDetailsViewModel = ProductDetailsViewModel()
    var productId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        productDetailsViewModel.getProductBy(productId ?? 0)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pageControl.numberOfPages = productDetailsViewModel.getVariantsCount()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProductDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetailsViewModel.getVariantsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let iCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VariantCollectionViewCell", for: indexPath) as! VariantCollectionViewCell
        iCell.bind(variant: productDetailsViewModel.product?.variants[indexPath.row])
        return iCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50)
        return  size
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
}

