//
//  ViewController.swift
//  FinalExam
//
//  Created by 蔡舜珵 on 2016/7/22.
//  Copyright © 2016年 蔡舜珵. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import SwiftyJSON
import SystemConfiguration

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var booklistTableView: UITableView!
    var booklistArray: [Book?] = []
    var data:NSArray = NSArray()
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.booklistTableView.registerNib(UINib(nibName: "BooklistTableViewCell",bundle: nil), forCellReuseIdentifier: "BooklistTableViewCell")
        self.booklistTableView.dataSource = self
        self.booklistTableView.delegate = self
        let ref = FIRDatabase.database().reference()
        let postRef = ref.child("Books")
        postRef.observeEventType(.ChildAdded, withBlock: {
            snapshot in
            let book = Book()
            book.name = snapshot.value!.objectForKey("name") as? String
            book.description = snapshot.value!.objectForKey("description") as? String
            book.address = snapshot.value!.objectForKey("address") as? String
            book.longtitude = snapshot.value!.objectForKey("longtitude") as? String
            book.latitude = snapshot.value!.objectForKey("latitude") as? String
            book.phone = snapshot.value!.objectForKey("phone") as? String
            book.pic = snapshot.value!.objectForKey("pic") as? String
            book.website = snapshot.value!.objectForKey("website") as? String
            print("我看看\(book.latitude)")
            self.booklistArray.append(book)
            self.booklistTableView.reloadData()

        })
        
        if !connectedToNetwork(){
            let alert = UIAlertController(title: "Wrong", message: "請重新連上網路", preferredStyle: .Alert)
           
            let action = UIAlertAction(title: "請重新連上網路", style: .Cancel, handler: nil )
                alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        self.refreshControl = UIRefreshControl()

        self.booklistTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), forControlEvents: UIControlEvents.ValueChanged)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func refresh() {
     self.booklistTableView.reloadData()
        self.refreshControl.endRefreshing()

    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.booklistArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.booklistTableView.dequeueReusableCellWithIdentifier("BooklistTableViewCell") as! BooklistTableViewCell
        
        cell.bookImageView.image = UIImage(named: (booklistArray[indexPath.row]?.pic)!)
        cell.bookNamelabel.text = booklistArray[indexPath.row]?.name
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedBook = booklistArray[indexPath.row]

        let detailViewController = storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
            detailViewController.selectedBook = selectedBook
        
        self.performSegueWithIdentifier("showDetail", sender: booklistArray[indexPath.row])

        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let destinationViewController = segue.destinationViewController as! DetailViewController
            let book = sender as? Book
            
            destinationViewController.selectedBook = book
        }
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        //Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            booklistArray.removeAtIndex(indexPath.row)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else {
            return false
        }
        var flags : SCNetworkReachabilityFlags = []
        
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            
            return false
            
        }
        
        let isReachable = flags.contains(.Reachable)
        
        let needsConnection = flags.contains(.ConnectionRequired)
        
        return (isReachable && !needsConnection)
        
    }

}