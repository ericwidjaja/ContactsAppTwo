//  AddContactVC.swift
//  ContactsAppTwo
//  Created by Eric Widjaja on 11/8/20.
//  Copyright © 2020 ericSwidjaja. All rights reserved.

import UIKit

protocol AddContactVCDelegate: AnyObject {
    func didAddContact()
}

class AddContactVC: UIViewController {
    
    weak var delegate: AddContactVCDelegate?
    
    //MARK: Properties
    @IBOutlet weak var addNewImage: UIImageView!
    @IBOutlet weak var addNewFirstName: UITextField!
    @IBOutlet weak var addNewLastName: UITextField!
    @IBOutlet weak var addNewEmail: UITextField!
    @IBOutlet weak var addNewPhone: UITextField!
    
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewContactData()
        
    }
    //MARK: Methods
    
    func loadNewContactData() {
        addNewPhone.delegate = self
        addNewFirstName.delegate = self
        addNewLastName.delegate = self
    }
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        //TODO: Refactor and make sure to have an alert if user missing field. watch ALex Optional Chaining about guard let
        
        guard let addFirstName = addNewFirstName.text, !addFirstName.isEmpty,
            let addLastName = addNewLastName.text, !addLastName.isEmpty,
            let addPhoneNumber = addNewPhone.text, !addPhoneNumber.isEmpty,
            let addEmail = addNewEmail.text, !addEmail.isEmpty else {
                showAlert(with: "Required", and: "Please fill out all fields")
                return
        }
        let newContact = Contact(phoneNumber: addPhoneNumber.description, firstName: addFirstName.description, lastName: addLastName.description, email: addEmail.description)
        
        try? PersistenceHelper.create(newContact: newContact)
        delegate?.didAddContact()
        dismiss(animated: true)
    }
}

extension AddContactVC: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        addNewFirstName.clearsOnBeginEditing = true
        addNewLastName.clearsOnBeginEditing = true
        addNewPhone.clearsOnBeginEditing = true
        return true
    }
}
