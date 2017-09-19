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
    
    fileprivate var products: [Product]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadProducts(subcategory_id: "2323") { (p) in
            print(p)
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
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
      /*  if let park = parksDataSource.parkForItemAtIndexPath(indexPath){
            cell.park = park
        }
      */
        
        return cell
    }
}

extension ViewController{
    
    func downloadProducts(subcategory_id: String, completion: @escaping ([String]) -> Void) {
        Alamofire.request(InstaRouter.products("57eec92f072d415b67c24175"))
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    print("Error while fetching products: \(String(describing: response.result.error))")
                    completion([String]())
                    return
                }
                
                guard (response.result.value as? [String: Any]) != nil else{
                    print("Invalid product information received from the service")
                    completion([String]())
                    return
                }
            
                completion(["djdjd"])
        }
    }
}
