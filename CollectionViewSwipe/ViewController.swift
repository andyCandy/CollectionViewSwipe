//
//  ViewController.swift
//  CollectionViewSwipe
//
//  Created by Alex on 3/18/15.
//  Copyright (c) 2015 WebFuture. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    // MARK: Data
    
    let images = ["img1", "img2", "img3", "img4", "img5", "img6", "img7"]
    
    
    // MARK: Outlets & Actions
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func goToNextImage(sender: AnyObject) {
        
        var indexPathArray = collectionView.indexPathsForVisibleItems()
        var currentIndexPath = indexPathArray.first as NSIndexPath
        var nextIndexPath = NSIndexPath(forItem: currentIndexPath.item + 1, inSection: 0)

        // protecting against crash
        
        if nextIndexPath.item < images.count {
            
            self.collectionView.scrollToItemAtIndexPath(nextIndexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
            pageControl.currentPage = nextIndexPath.item
        }
    }
    
    @IBAction func goBackToImage(sender: AnyObject) {
        
        var indexPathArray = collectionView.indexPathsForVisibleItems()
        var currentIndexPath = indexPathArray.first as NSIndexPath
        var previousIndexPath = NSIndexPath(forItem: currentIndexPath.item - 1, inSection: 0)
        
        // protecting against crash
        
        if previousIndexPath.item >= 0 {
            
            self.collectionView.scrollToItemAtIndexPath(previousIndexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
            pageControl.currentPage = previousIndexPath.item
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var pageScoll: UIScrollView!
    
    @IBOutlet weak var sizesSegmentedControl: UISegmentedControl!
    
    
    
    // MARK: UICollectionViewDataSource & UICollectionViewDelegate
    
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
    
    
    // MARK: UIScrollViewDelegate
    
    // updating page control's current page when scroll stops
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        var indexPathArray = collectionView.indexPathsForVisibleItems()
        var currentIndexPath = indexPathArray.first as NSIndexPath
        
        pageControl.currentPage = currentIndexPath.item
    }
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageScoll.delegate = self
        
        pageScoll.contentSize.width = UIScreen.mainScreen().bounds.width
        pageScoll.contentSize.height = 936
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        
//        sizesSegmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.redColor()], forState: UIControlState.Normal)
    }
    

}

