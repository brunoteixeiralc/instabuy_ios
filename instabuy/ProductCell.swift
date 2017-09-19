//
//  ParkCell.swift
//  collectionsviews
//
//  Created by Bruno Corrêa on 23/08/17.
//  Copyright © 2017 Bruno Corrêa. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    
    @IBOutlet weak var productImageView: UIImageView!
    
    override func prepareForReuse() {
        productImageView.image = nil
    }
    
    var product: Product?{
        didSet {
            if product != nil{
                productImageView.image = UIImage(named: "logo")
            }
        }
    }
    
}
