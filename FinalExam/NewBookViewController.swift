//
//  NewBookViewController.swift
//  FinalExam
//
//  Created by 蔡舜珵 on 2016/7/22.
//  Copyright © 2016年 蔡舜珵. All rights reserved.
//

import UIKit
import Firebase
class NewBookViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var websiteLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var picLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitData(sender: AnyObject) {
        let ref = FIRDatabase.database().reference()
        let postRef = ref.child("Books").childByAutoId()
        
        postRef.setValue(["name":"\(self.nameLabel.text)","pic":"\(self.picLabel.text!)","address":"\(self.addressLabel.text!)","phone":"\(self.phoneLabel.text!)","website":"\(self.websiteLabel.text!)","description":"\(self.descriptionLabel.text!)"])
    }


}
