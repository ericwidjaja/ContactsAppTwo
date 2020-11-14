//
//  ContactDetailVC.swift
//  ContactsAppTwo
//
//  Created by Eric Widjaja on 11/8/20.
//  Copyright © 2020 ericSwidjaja. All rights reserved.
//

import UIKit

class ContactDetailVC: UIViewController {
    
    //MARK: Properties
    
    var currentContact: Contact!
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactFirstName: UILabel!
    @IBOutlet weak var contactLastName: UILabel!
    @IBOutlet weak var contactPhoneNumber: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        populateContactInfo()

    }
    
    //MARK: Functions
    
    func populateContactInfo() {
        contactFirstName.text = "First Name :  \(currentContact.firstName) "
        contactLastName.text = "Last Name :  \(currentContact.lastName) "
        contactPhoneNumber.text = "Phone Number :  \(currentContact.phoneNumber.description)"
        contactEmail.text = "Email Address : \(currentContact.email.description)"
    }
    
}
