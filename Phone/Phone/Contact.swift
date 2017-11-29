//
//  Contact.swift
//  Phone
//
//  Created by Dmitry Anikin on 24/11/2017.
//  Copyright © 2017 KudimovMikhail. All rights reserved.
//

import UIKit

class Contact: NSObject {
    var name : String
    var number : String
    
    init(name:String, number:String) {
        self.name = name
        self.number = number
    }
    
    var titleFirstLetter: String {
        return String(self.name[self.name.startIndex]).uppercased()
    }
}
