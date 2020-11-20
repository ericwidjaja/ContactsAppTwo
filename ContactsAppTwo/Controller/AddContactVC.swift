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
    @IBOutlet weak var newContactImage: UIImageView!
    @IBOutlet weak var newFirstName: UITextField!
    @IBOutlet weak var newLastName: UITextField!
    @IBOutlet weak var newEmail: UITextField!
    @IBOutlet weak var newPhone: UITextField!
    
    private let imagePickerController = UIImagePickerController()
    private var contactImage = UIImage() {
        didSet {
            newContactImage.image = contactImage
        }
    }

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewContactData()
        
    }
    //MARK: Methods
    func loadNewContactData() {
        setContactImage()
        newPhone.delegate = self
        newFirstName.delegate = self
        newLastName.delegate = self
    }
    
    func showImagePicker() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        showImagePicker()
    }
    
    private func setContactImage() {
        newContactImage.layer.cornerRadius = newContactImage.frame.size.width/2
        newContactImage.clipsToBounds = true
    }
    
    func hideKeyboard() {
        newFirstName.resignFirstResponder()
        newLastName.resignFirstResponder()
        newEmail.resignFirstResponder()
        newPhone.resignFirstResponder()
        
    }
    
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        
        //use Optionals Chaining -> https://www.youtube.com/watch?v=B77J3WIhDAw
        guard let addFirstName = newFirstName.text, !addFirstName.isEmpty,
            let addLastName = newLastName.text, !addLastName.isEmpty,
            let addPhoneNumber = newPhone.text, !addPhoneNumber.isEmpty,
            let addEmail = newEmail.text,
            let contactImage = newContactImage.image else {
                showAlert(with: "Required", and: "Please fill out all fields")
                return
        }
        
        let newContact = Contact(phoneNumber: addPhoneNumber.description, firstName: addFirstName.description, lastName: addLastName.description, email: addEmail.description, image: ImageObject(imageData: newContactImage.image?.pngData(), date: Date.init()))
        
        try? PersistenceHelper.create(newContact: newContact)
        delegate?.didAddContact()
        dismiss(animated: true)
    }
}

//MARK: Extensions
extension AddContactVC: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        newFirstName.clearsOnBeginEditing = true
        newLastName.clearsOnBeginEditing = true
        newPhone.clearsOnBeginEditing = true
        newEmail.clearsOnBeginEditing = true

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        print("textfield is pressed")
        return true
    }
}

extension AddContactVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            //couldn't get image :(
            return
        }
        self.contactImage = image
        print(image)
        dismiss(animated: true, completion: nil)
    }
}
