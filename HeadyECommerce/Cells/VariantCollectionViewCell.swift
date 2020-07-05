//
//  VariantCollectionViewCell.swift
//  HeadyECommerce
//
//  Created by Nirav Hathi on 7/4/20.
//  Copyright © 2020 Nirav Hathi. All rights reserved.
//

import UIKit

class VariantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewBackGround: UIImageView!
    @IBOutlet weak var labelColor: UILabel!
    @IBOutlet weak var labelSize: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    func bind(variant: Variants?) {
        let colorString = variant?.color ?? "red"
        
        labelSize.text = "\(variant?.size ?? 0)"
        labelPrice.text = "\(variant?.price ?? 0)"
        labelColor.text = variant?.color
        guard let color = Color(rawValue: colorString.lowercased()) else { return }
        self.imageViewBackGround.backgroundColor = color.create
              
    }
}

enum Color: String {
    case red
    case blue
    case green
    case white
    case black
    case yellow
    case silver
    case golden
    
    var create: UIColor {
        switch self {
        case .red:
            return UIColor.red
        case .blue:
            return UIColor.blue
        case .green:
            return UIColor.green
        case .white:
            return UIColor.white
        case .black:
            return UIColor.black
        case .yellow:
            return UIColor.yellow
        case .silver:
            return UIColor.lightGray
        case .golden:
            return UIColor.yellow
        }
    }
}
