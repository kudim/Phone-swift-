//
//  Bell.swift
//  Phone
//
//  Created by Dmitry Anikin on 25/11/2017.
//  Copyright © 2017 KudimovMikhail. All rights reserved.
//

import UIKit

class Call: NSObject {
    var contact : Contact
    var date : Calendar
    
    init (contact: Contact, date: Calendar) {
        self.contact = contact
        self.date = date
    }
}
