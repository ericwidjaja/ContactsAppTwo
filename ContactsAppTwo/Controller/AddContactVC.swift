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
    
    private let imagePickerController = UIImagePickerController()
    
    
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
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {

        // present an action sheet to ther user
        // actions: camera, photo library, cancel
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] alertAction in
            self?.showImageController(isCameraSelected: true)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] alertAction in
            self?.showImageController(isCameraSelected: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // check if camera is available, if camera is not available and you attempt to show
        // the camera the app will crash
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func showImageController(isCameraSelected: Bool) {
        // source type default will be .photoLibrary
        imagePickerController.sourceType = .photoLibrary
        
        if isCameraSelected {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }
    
    
    
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        
        //use Optionals Chaining -> https://www.youtube.com/watch?v=B77J3WIhDAw
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
