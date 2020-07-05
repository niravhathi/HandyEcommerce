//
//  CategoryCollectionViewCell.swift
//  HeadyECommerce
//
//  Created by Nirav Hathi on 7/3/20.
//  Copyright © 2020 Nirav Hathi. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var imageViewCategory: UIImageView!
    
    func bind(category: Categories?) {
        labelCategory.text = category?.name ?? ""
        //if Imageneeds to show
       // imageViewCategory.downloaded(from: "https://picsum.photos/200/300")
    }
}
