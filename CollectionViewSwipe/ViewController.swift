//
//  ViewController.swift
//  CollectionViewSwipe
//
//  Created by Alex on 3/18/15.
//  Copyright (c) 2015 WebFuture. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, SMSegmentViewDelegate {
    
    // MARK: - Local data
    
    let images = ["img1", "img2", "img3", "img4"]
    var colors = ["black", "coconut", "flamingo pink", "tropical orange", "kalua nude", "pacific blue", "colibri green"]
    
    //
    
    let detailsText = "- Tulle: 100% silk\n- Corset structured bodice\n- Skin-tone tulle inserts on the sides of the bodice\n- Covered back\n- Crossed strips of silk tulle cover the bust, creating delicate cutouts\n- Well positioned layers of silk tulle on the hips help flatter the silhouette\n- Hook & Eye closure in the back"
    
    let notesText = "Ailani is a beautiful gown with the most flattering bodice. The carefully crafted bust doesn’t show too much, just enough to intrigue."
    
    let sizeAndFitText = "- Fitted bust and waist, loose at the hips\n- French sizing\n- The model is 178 cm tall and is wearing a size FR 36"
    
    
   
    
    
    // MARK: - Vars
    var segmentView: SMSegmentView!
    var margin: CGFloat = 30.0
    
    let mediumGray = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    
    var colorSelectionImageView = UIImageView()
    
    
    
    // MARK: - Outlets & Actions
    
    @IBOutlet weak var swipeCV: UICollectionView!
    
    @IBOutlet weak var colorSelectionCV: UICollectionView!
    
    
    @IBAction func goToNextImage(sender: AnyObject) {
        
        var indexPathArray = swipeCV.indexPathsForVisibleItems()
        var currentIndexPath = indexPathArray.first as NSIndexPath
        var nextIndexPath = NSIndexPath(forItem: currentIndexPath.item + 1, inSection: 0)

        // protecting against crash
        
        if nextIndexPath.item < images.count {
            
            self.swipeCV.scrollToItemAtIndexPath(nextIndexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
            pageControl.currentPage = nextIndexPath.item
        }
    }
    
    @IBAction func goBackToImage(sender: AnyObject) {
        
        var indexPathArray = swipeCV.indexPathsForVisibleItems()
        var currentIndexPath = indexPathArray.first as NSIndexPath
        var previousIndexPath = NSIndexPath(forItem: currentIndexPath.item - 1, inSection: 0)
        
        // protecting against crash
        
        if previousIndexPath.item >= 0 {
            
            self.swipeCV.scrollToItemAtIndexPath(previousIndexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
            pageControl.currentPage = previousIndexPath.item
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var pageScoll: UIScrollView!
    
    @IBOutlet weak var psvLabel: UILabel! // programmatic SV; disable in viewWillAppear (using to position custom segmented view)
    
    // size & color labels
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    
    @IBOutlet weak var productDetailsSV: UISegmentedControl!
    
    // Segmented view text label
    
    @IBOutlet weak var svTextLabel: UILabel!
    
    
    @IBOutlet weak var addToShoppingBagButton: UIButton!
    @IBOutlet weak var addToWishListButton: UIButton!
    
    
    @IBOutlet weak var sizeChartButton: UIButton!
    
    

    
    // MARK: - UICollectionView data source & delegate
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
     
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1 {
            
            return images.count
        }

        if collectionView.tag == 2 {
        
            return colors.count
        }
            
        return 0
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = colorSelectionCV.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as ColorSelectionCollectionViewCell
        
        if collectionView.tag == 1 {
            
            let swipeCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as MyCollectionViewCell
            
            // Configure the cell
            
            // Image aspect fill & hidden horizontal scroll indicator set in storyboard
            
            var imageName = images[indexPath.row] as String
            swipeCell.slideImage.image = UIImage(named: imageName)
            
            return swipeCell
            
        } else if collectionView.tag == 2 {
        
            let colorCell = colorSelectionCV.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as ColorSelectionCollectionViewCell
            
            // Configure the cell
            
            var colorName = colors[indexPath.row] as String
            colorCell.colorSelectionImageView.image = UIImage(named: "\(colorName).jpeg")
            
            return colorCell

        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
        // Update color label
        
        colorLabel.text = "Selected color: \(colors[indexPath.item])"
        
        // Draw custom circle around selected cell item
        
        // delete previous selection
        colorSelectionImageView.image = nil
        colorSelectionImageView.removeFromSuperview() // possible memory management problem until 'viewWillDisappear'!
        
        // make new selection
        let rectX: CGFloat = self.colorSelectionCV.cellForItemAtIndexPath(indexPath)!.frame.origin.x
        let rectY: CGFloat = self.colorSelectionCV.cellForItemAtIndexPath(indexPath)!.frame.origin.y
        
        let cellWidth = self.colorSelectionCV.cellForItemAtIndexPath(indexPath)!.bounds.width
        let cellHeight = self.colorSelectionCV.cellForItemAtIndexPath(indexPath)!.bounds.height
        
        let imageSize = CGSize(width: 40, height: 40)
        
        colorSelectionImageView = UIImageView(frame: CGRect(origin: CGPoint(x: rectX - (imageSize.width - cellWidth)/2 , y: rectY - (imageSize.height - cellHeight)/2), size: imageSize))
        let image = drawCustomCircle(imageSize)
        
        self.colorSelectionCV.addSubview(colorSelectionImageView)
        colorSelectionImageView.image = image
    }
    
    func drawCustomCircle(size: CGSize) -> UIImage {
        
        let lineWidth: CGFloat = 2.0
        
        // Setup our context
        // prevent stroke croping
        let bounds = CGRect(origin: CGPointMake(lineWidth/2, lineWidth/2), size: CGSize(width: size.width - lineWidth, height: size.height - lineWidth))
        let opaque = false
        let scale: CGFloat = 0
        
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        CGContextSetStrokeColorWithColor(context, mediumGray.CGColor)
        CGContextSetLineWidth(context, lineWidth)
        CGContextStrokeEllipseInRect(context, bounds)
        
        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    

    
    
    // MARK: - UIScrollViewDelegate
    
    // updating page control's current page when scroll stops
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        var indexPathArray = swipeCV.indexPathsForVisibleItems()
        var currentIndexPath = indexPathArray.first as NSIndexPath
        
        pageControl.currentPage = currentIndexPath.item
        
    }
    
    
    
    
    // MARK: -


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Settig page scroll
        
        pageScoll.delegate = self
        
//        pageScoll.contentSize.width = UIScreen.mainScreen().bounds.width
//        pageScoll.contentSize.height = 1036
        

        
        
        // Create a custom SM segmented view (NO AUTOLAYOUT!)
        
            let segmentViewProperties : Dictionary<String, AnyObject> = [   keySegmentTitleFont: UIFont.systemFontOfSize(14),
                                                                            keySegmentOnSelectionColour: mediumGray,
                                                                            keySegmentOffSelectionColour: UIColor.whiteColor(),
                                                                            keyContentVerticalMargin: 10.0]
            var psvLabelY = psvLabel.frame.origin.y
            let svFrame = CGRect(x: margin, y: psvLabelY, width: self.view.frame.size.width - margin*2, height: 30)
            
            segmentView = SMSegmentView(frame: svFrame, separatorColour: UIColor.clearColor(), separatorWidth: 0.5, segmentProperties: segmentViewProperties)
        
            segmentView.delegate = self
        
            segmentView.addSegmentWithTitle("34", onSelectionImage: nil, offSelectionImage: nil)
            segmentView.addSegmentWithTitle("36", onSelectionImage: nil, offSelectionImage: nil)
            segmentView.addSegmentWithTitle("38", onSelectionImage: nil, offSelectionImage: nil)
            segmentView.addSegmentWithTitle("40", onSelectionImage: nil, offSelectionImage: nil)
            segmentView.addSegmentWithTitle("42", onSelectionImage: nil, offSelectionImage: nil)
            segmentView.addSegmentWithTitle("44", onSelectionImage: nil, offSelectionImage: nil)
            segmentView.addSegmentWithTitle("LSM", onSelectionImage: nil, offSelectionImage: nil)
        
            // You can programmatically select/deselect a segment by calling selectSegmentAtIndex(index: Int)
            // segmentView.selectSegmentAtIndex(0)
        
            // adding custom SV to pageScroll view
            self.pageScoll.addSubview(self.segmentView)
        
        
        // register target-action method for the bottom segmented view
        productDetailsSV.addTarget(self, action: "segmentChanged", forControlEvents: .ValueChanged)

    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        
        // hide storyboard label
        psvLabel.hidden = true
        
        sizeLabel.text = "Selected size: none"
        
        // cusomize size chart button
        sizeChartButton.layer.borderWidth = 1.0
        sizeChartButton.layer.borderColor = mediumGray.CGColor
        sizeChartButton.layer.cornerRadius = 5.0
        
        
        // setting text notes label (combined with auto layout in storyboard)
        svTextLabel.numberOfLines = 0
        svTextLabel.text = notesText
        svTextLabel.sizeToFit()
    }
    

    
    func segmentChanged() {
        
        switch productDetailsSV.selectedSegmentIndex {
            
        case 0: svTextLabel.text = notesText
        case 1: svTextLabel.text = sizeAndFitText
        case 2: svTextLabel.text = detailsText

        default: svTextLabel.text = notesText

        }
        
        // println("text label height: \(svTextLabel.frame.height)")
        
    }
    
    // MARK: - SMSegment delegate
    
    func didSelectSegmentAtIndex(segmentIndex: Int) {
        
        // Replace the following line to implement what you want the app to do after the segment gets tapped.
        
        println("Select segment at index: \(segmentIndex)")
        
        switch segmentIndex {
            
        case 0: sizeLabel.text = "Selected size: 34"
        case 1: sizeLabel.text = "Selected size: 36"
        case 2: sizeLabel.text = "Selected size: 38"
        case 3: sizeLabel.text = "Selected size: 40"
        case 4: sizeLabel.text = "Selected size: 42"
        case 5: sizeLabel.text = "Selected size: 44"
        case 6: sizeLabel.text = "Selected size: luxury-sur-mesure"
            
        default: sizeLabel.text = "Selected size: none"
        
        }
        
    }
    

}

