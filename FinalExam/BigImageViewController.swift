//
//  BigImageViewController.swift
//  FinalExam
//
//  Created by 蔡舜珵 on 2016/7/22.
//  Copyright © 2016年 蔡舜珵. All rights reserved.
//

import UIKit

class BigImageViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    var imageView: UIImageView?
    var image: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(image)
        self.imageView = UIImageView(image: UIImage(named: image!))
        self.scrollView.delegate = self
        self.scrollView.addSubview(imageView!)
        self.scrollView.contentSize = imageView!.frame.size
        self.scrollView.maximumZoomScale = 5.0
        self.scrollView.minimumZoomScale = 0.1

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
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
