//
//  ParkCell.swift
//  collectionsviews
//
//  Created by Bruno Corrêa on 23/08/17.
//  Copyright © 2017 Bruno Corrêa. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class ProductCell: UICollectionViewCell {
    
    static let baseURLPath = "https://s3-us-west-2.amazonaws.com/"
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productSubLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func prepareForReuse() {
        productImageView.image = nil
    }
    
    var product: Product?{
        didSet {
            if product != nil{
                productLabel.text = product?.name
                productSubLabel.text = product?.brand
                productPrice.text = formatCurrency(value: product!.price)
                
                Alamofire.request(ProductCell.baseURLPath + "ib.image.medium/m-\(String(describing: product!.thumb))").response { response in
                    if let data = response.data {
                        let image = UIImage(data: data)
                        self.productImageView.image = image
                    } else {
                        print("Data is nil.")
                    }
                }
            }
        }
    }
}

extension ProductCell{
    
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
}
