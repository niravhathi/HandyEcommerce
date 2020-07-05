//
//  ProductViewController.swift
//  HeadyECommerce
//
//  Created by Nirav Hathi on 7/4/20.
//  Copyright © 2020 Nirav Hathi. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var buttonShared: UIButton!
    @IBOutlet weak var buttonOrdered: UIButton!
    @IBOutlet var tableHeaderView: UIView!
    @IBOutlet weak var buttonViewed: UIButton!
    var productViewModel = ProductViewModel()
    @IBOutlet weak var tableViewProducts: UITableView!
    var categoryId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
         tableViewProducts.register(UINib(nibName: "ProductListCell", bundle: nil), forCellReuseIdentifier: "ProductListCell")
        productViewModel.getProductListBy(categoryId ?? 0)
        tableViewProducts.tableFooterView = UIView(frame: CGRect.zero)
        tableViewProducts.tableHeaderView = tableHeaderView
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableViewProducts.reloadData()
    }
    
    
    @IBAction func buttonSortedClicked(_ sender: UIButton) {
        self.productViewModel.getProductListSortedBy(sender.tag, id: self.categoryId ?? 0)
        self.tableViewProducts.reloadData()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProductDetails" {
            let productDetailViewController = segue.destination as? ProductDetailsViewController
            productDetailViewController?.productId = sender as? Int
        }
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
extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModel.getProductsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iCell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        iCell.selectionStyle = .none
        iCell.bind(product: productViewModel.productList?[indexPath.row])
        return iCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowProductDetails", sender: productViewModel.productList?[indexPath.row].id)
    }
}
