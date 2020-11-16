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
    @IBOutlet weak var contactFullName: UILabel!
    @IBOutlet weak var contactPhoneNumber: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        populateContactInfo()
        
    }
    
    //MARK: Functions
    func populateContactInfo() {
        contactImage.image = UIImage(data: currentContact.image?.imageData ?? Data())
        contactFullName.text = currentContact.fullName
        contactPhoneNumber.text = "Phone No. : \(currentContact.phoneNumber.description)"
        contactEmail.text = "Email Address :  \(currentContact.email.description)"
    }
    
    @IBAction func callButtonClicked(_ sender: UIButton) {
        guard let phoneNumberURL = URL(string: "tel://\(currentContact.phoneNumber)") else { return }
        if UIApplication.shared.canOpenURL(phoneNumberURL) {
            UIApplication.shared.open(phoneNumberURL)
        } else {
            print("unable to open phoneNumberURL on this device")
        }
    }
}

