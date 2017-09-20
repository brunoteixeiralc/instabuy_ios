//
//  ViewController.swift
//  instabuy
//
//  Created by Bruno Lemgruber on 19/09/17.
//  Copyright © 2017 Bruno Lemgruber. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UICollectionViewController {
    
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showDialog()
        
        downloadProducts(subcategory_id: "57eec92f072d415b67c24175") { (ps) in
            self.products = ps
            self.collectionView?.reloadData()
        }
        
        let width = collectionView!.frame.width/2
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
}

extension ViewController{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let product = products[indexPath.row]
        cell.product = product
        
        return cell
    }
}

extension ViewController{
    
    func showDialog(){
        let alert = UIAlertController(title: nil, message: "Carregando...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func dismissDialog(){
        dismiss(animated: false, completion: nil)
    }
    
    func downloadProducts(subcategory_id: String, completion: @escaping ([Product]) -> Void) {
        Alamofire.request(InstaRouter.products(subcategory_id))
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    print("Error while fetching products: \(String(describing: response.result.error))")
                    completion([Product]())
                    return
                }
                
                guard let responseJSON = response.result.value as? [String: Any],
                    let results = responseJSON["data"] as? [[String: Any]] else{
                    print("Invalid product information received from the service")
                    completion([Product]())
                    return
                }
                
                var products = [Product]()
                for item in results{
                    let brand = item["brand"] as! String
                    let id = item["id"] as! String
                    let name = item["name"] as! String
                    let thumb = item["thumb"] as! String
                    let pc = item["pc"] as? [[String:Any]]
                    let price = pc?.first!["valid_price"] as! Double

                    let p = Product(id: id, name: name, brand: brand, thumb: thumb, price: price)
                    products.append(p)
                }
                
                completion(products)
                
                self.dismissDialog()
        }
    }
}
