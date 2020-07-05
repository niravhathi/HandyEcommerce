//
//  ProductListCell.swift
//  HeadyECommerce
//
//  Created by Nirav Hathi on 7/4/20.
//  Copyright © 2020 Nirav Hathi. All rights reserved.
//

import UIKit

class ProductListCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblDateAdded: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(product : Products?) {
        lblName.text = product?.name ?? ""
        lblPrice.text = "\(product?.variants[0].price ?? 0)"
        lblDateAdded.text = product?.date_added ?? ""
    }
    
}
