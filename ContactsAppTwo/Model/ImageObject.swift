//  ImageObject.swift
//  ContactsAppTwo
//  Created by Eric Widjaja on 11/14/20.
//  Copyright © 2020 ericSwidjaja. All rights reserved.

import Foundation

struct ImageObject:Codable {
    let imageData: Data
    let date: Date
    let identifier = UUID().uuidString
}
