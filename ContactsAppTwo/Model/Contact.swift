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
//    let image: String
    
//    static func getAllContacts() -> [Contact] {
//        
//        let contactsDict =
//            [03364152046: ("Christin", "Böttger"),
//             927525456: ("Joaquin", "Bravo"),
//             6868840334: ("David", "Edwards"),
//             07905753: ("Roope", "Mattila"),
//             27991860: ("Lærke", "Wist"),
//             957021797: ("Jonathan", "Diez"),
//             01768757320: ("Emily", "Long"),
//             0501439641: ("Noe", "Roussel"),
//             375351453: ("Justin", "Harris"),
//             3028950023: ("Ezra", "Lee"),
//             0478121870: ("Ninon", "Bernard"),
//             60749217: ("Helene", "Strange"),
//             7638623154: ("Estefânia", "Barros"),
//             2945132492: ("Gül", "Sinanoğlu"),
//             1963139555: ("George", "Miller"),
//             64513463: ("Cecilie", "Peterson"),
//             01539627648: ("Jared", "Mitchelle"),
//             0157693915: ("Valdelaine", "de Souza"),
//             07798852536: ("Kristin", "Tausch"),
//             00499228235: ("Marissa", "Rode")]
//        
//        var allContacts = [Contact]()
//        
//        for (key, value) in contactsDict {
//            let newContact = Contact(phoneNumber: key, firstName: value.0, lastName: value.1)
//            allContacts.append(newContact)
//        }
//        return allContacts
//    }
}

