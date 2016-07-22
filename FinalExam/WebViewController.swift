//
//  WebViewController.swift
//  FinalExam
//
//  Created by 蔡舜珵 on 2016/7/22.
//  Copyright © 2016年 蔡舜珵. All rights reserved.
//

import UIKit
import WebKit
import SafariServices
class WebViewController: UIViewController {
    @IBOutlet weak var bookWebView: UIWebView!
    var webView:WKWebView = WKWebView()
    var website:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: UIScreen.mainScreen().bounds)
 
        self.view.addSubview(webView)
        let url = NSURL(string: website!)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
