//
//  ViewController.swift
//  instabuy
//
//  Created by Bruno Lemgruber on 19/09/17.
//  Copyright © 2017 Bruno Lemgruber. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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


