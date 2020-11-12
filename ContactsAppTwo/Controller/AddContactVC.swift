//  AddContactVC.swift
//  ContactsAppTwo
//  Created by Eric Widjaja on 11/8/20.
//  Copyright © 2020 ericSwidjaja. All rights reserved.

import UIKit

class AddContactVC: UIViewController {
//MARK: Properties
    @IBOutlet weak var addContactImage: UIImageView!
    @IBOutlet weak var addContactFirstName: UITextField!
    @IBOutlet weak var addContactLastName: UITextField!
    @IBOutlet weak var addContactEmail: UITextField!
    @IBOutlet weak var addContactPhone: UITextField!
    
    
    
//MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewContactData()
        
    }
//MARK: Methods
    
    func loadNewContactData() {
        addContactPhone.delegate = self
        addContactFirstName.delegate = self
        addContactLastName.delegate = self
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        
        if addContactPhone.text != "" && addContactFirstName.text != "" && addContactLastName.text != "" {
            guard let addPhoneNumber = addContactPhone.text else {return}
            guard let addFirstName = addContactFirstName.text else {return}
            guard let addLastName = addContactLastName.text else { return }
            
            let newContact = Contact(phoneNumber: addPhoneNumber.description, firstName: addFirstName.description, lastName: addLastName.description)
            try? PersistenceHelper.create(newContact: newContact)
        }
    }
}

extension AddContactVC: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        addContactFirstName.clearsOnBeginEditing = true
        addContactLastName.clearsOnBeginEditing = true
        addContactPhone.clearsOnBeginEditing = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addContactPhone.resignFirstResponder()
        addContactFirstName.resignFirstResponder()
        addContactLastName.resignFirstResponder()
        return true
    }
}
