//
//  SizeChartViewController.swift
//  CollectionViewSwipe
//
//  Created by Alex on 3/20/15.
//  Copyright (c) 2015 WebFuture. All rights reserved.
//

import UIKit

class SizeChartViewController: UIViewController {
    
    

    @IBOutlet weak var mainScroll: UIScrollView!
    
    @IBOutlet weak var scroll1: UIScrollView!
    @IBOutlet weak var scroll2: UIScrollView!
    @IBOutlet weak var scroll3: UIScrollView!
    @IBOutlet weak var scroll4: UIScrollView!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll1.contentSize.width = 490
        scroll1.contentSize.height = 242
                
        scroll2.contentSize.width = 490
        scroll2.contentSize.height = 256
        
        scroll3.contentSize.width = 490
        scroll3.contentSize.height = 253
        
        scroll4.contentSize.width = 490
        scroll4.contentSize.height = 192
        
//        mainScroll.contentSize.width = UIScreen().bounds.width
//        mainScroll.contentSize.height = 1040
        
        image1.image = UIImage(named: "sizeChart_slide1")
        image2.image = UIImage(named: "sizeChart_slide2")
        image3.image = UIImage(named: "sizeChart_slide3")
        image4.image = UIImage(named: "sizeChart_slide4")

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
