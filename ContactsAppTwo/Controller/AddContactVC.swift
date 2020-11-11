//
//  AddContactVC.swift
//  ContactsAppTwo
//
//  Created by Eric Widjaja on 11/8/20.
//  Copyright © 2020 ericSwidjaja. All rights reserved.
//

import UIKit

class AddContactVC: UIViewController {
//MARK: Properties
    @IBOutlet weak var addContactImage: UIImageView!
    @IBOutlet weak var addContactFirstName: UITextField!
    @IBOutlet weak var addContactLastName: UITextField!
    @IBOutlet weak var addContactEmail: UITextField!
    @IBOutlet weak var addContactPhone: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
//MARK: Methods
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        
        if addContactPhone.text != "" && addContactFirstName.text != "" && addContactLastName.text != "" {
            guard let addPhoneNumber = addContactPhone.text else {return}
            guard let addFirstName = addContactFirstName.text else {return}
            guard let addLastName = addContactLastName.text else { return }
            
            let newContact = Contact(phoneNumber: addPhoneNumber.count, firstName: addFirstName.description, lastName: addLastName.description)
            try? PersistenceHelper.create(newContact: newContact)
        }
    }
}

extension AddContactVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        addContactFirstName.text = ""
        addContactLastName.text = ""
        addContactPhone.text = ""
    }
}
