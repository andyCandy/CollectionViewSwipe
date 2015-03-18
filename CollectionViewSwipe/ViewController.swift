//
//  ViewController.swift
//  CollectionViewSwipe
//
//  Created by Alex on 3/18/15.
//  Copyright (c) 2015 WebFuture. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let images = ["img1", "img2", "img3", "img4", "img5", "img6", "img7"]
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
     
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as MyCollectionViewCell
        
        // Configure the cell
        
        // Image aspect fill & hidden horizontal scroll indicator set in storyboard

        var imageName = images[indexPath.row] as String
        cell.slideImage.image = UIImage(named: imageName)
        
        return cell
    }

}

