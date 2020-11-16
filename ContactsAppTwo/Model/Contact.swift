//  Contact.swift
//  ContactsAppTwo
//  Created by Eric Widjaja on 11/6/20.
//  Copyright © 2020 ericSwidjaja. All rights reserved.

import Foundation

struct Contact: Codable {
    
    let phoneNumber: String
    let firstName: String
    let lastName: String
    var fullName: String {
        return firstName + " " + lastName
    }
    
    let email: String
    let image: ImageObject?
}

