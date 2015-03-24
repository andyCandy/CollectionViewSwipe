//
//  SizeChartViewController.swift
//  CollectionViewSwipe
//
//  Created by Alex on 3/20/15.
//  Copyright (c) 2015 WebFuture. All rights reserved.
//

import UIKit

class SizeChartViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var chart: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.image = UIImage(named: "sizeChart")
        scrollView.contentSize = chart.image!.size
        
        

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
