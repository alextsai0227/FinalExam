//
//  Books.swift
//  FinalExam
//
//  Created by 蔡舜珵 on 2016/7/22.
//  Copyright © 2016年 蔡舜珵. All rights reserved.
//

import Foundation

class Books{
    
    var address: String
    var description: String
    var latitude: String
    var longtitude:String
    var name: String
    var phone:String
    var pic:String
    var website:String
    init(address:String,description:String,latitude:String,longtitude:String,name:String,phone:String,pic:String,website:String){
        self.address = address
        self.description = description
        self.latitude = latitude
        self.longtitude = longtitude
        self.name = name
        self.phone = phone
        self.pic = pic
        self.website = website
    
    }


}
class Book {
    
    static let book = Book()
    
    
    var address: String?
    var description: String?
    var latitude: String?
    var longtitude:String?
    var name: String?
    var phone:String?
    var pic:String?
    var website:String?

}