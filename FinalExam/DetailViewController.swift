//
//  DetailViewController.swift
//  FinalExam
//
//  Created by 蔡舜珵 on 2016/7/22.
//  Copyright © 2016年 蔡舜珵. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    var selectedBook: Book?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1234567\(selectedBook?.longtitude)")
        self.imageView.image = UIImage(named: (selectedBook?.pic)!)
        self.addressLabel.text = "地址：" + (selectedBook?.address)!
        self.nameLabel.text = "書名：" + (selectedBook?.name)!
        self.descriptionLabel.text = "簡介：" + (selectedBook?.description)!
        self.websiteButton.setTitle("網站\(selectedBook!.website!)", forState: .Normal)
        self.phoneButton.setTitle("tel:\(selectedBook!.phone!)", forState: .Normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makePhoneCall(sender: AnyObject) {
        if let url = NSURL(string: "tel://\(selectedBook!.phone!)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    @IBAction func toWebView(sender: AnyObject) {
        self.performSegueWithIdentifier("showWebView", sender: selectedBook)
    }
    @IBAction func toMapView(sender: AnyObject) {
        self.performSegueWithIdentifier("showMapView", sender: selectedBook)
    }

    @IBAction func toBigImageView(sender: AnyObject) {
      self.performSegueWithIdentifier("showBigImage", sender: selectedBook)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBigImage" {
            let destinationViewController = segue.destinationViewController as! BigImageViewController
            let selectedBook = sender as? Book
            
            destinationViewController.image = selectedBook?.pic
            print(destinationViewController.image)
        }else if segue.identifier == "showMapView" {
            let destinationViewController = segue.destinationViewController as! MapViewController
            let selectedBook = sender as? Book
            
            destinationViewController.longtitude = selectedBook?.longtitude
            destinationViewController.latitude = selectedBook?.latitude
            print(selectedBook?.longtitude)
            print(destinationViewController.latitude)

        }else if segue.identifier == "showWebView" {
            let destinationViewController = segue.destinationViewController as! WebViewController
            let selectedBook = sender as? Book
            
            destinationViewController.website = selectedBook?.website
            print(destinationViewController.website)
            
        }
    
    }

}
