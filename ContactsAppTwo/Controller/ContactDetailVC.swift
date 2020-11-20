//
//  ContactDetailVC.swift
//  ContactsAppTwo
//
//  Created by Eric Widjaja on 11/8/20.
//  Copyright © 2020 ericSwidjaja. All rights reserved.
//

import UIKit
import MessageUI

class ContactDetailVC: UIViewController {
    
    //MARK: Properties
    
    var currentContact: Contact!
    private let imagePickerController = UIImagePickerController()
    
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
        contactPhoneNumber.text = "Phone No.: \n \(currentContact.phoneNumber.description)"
        contactEmail.text = "Email Address: \n \(currentContact.email.description)"
    }
    
    func showMailComposer() {
        //check if your device can send mail
        guard MFMailComposeViewController.canSendMail() else {
            //show alert informing the user
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self //make sure to create delegate for the VC
        composer.setToRecipients(["support@eric.com"])
        composer.setSubject("Help!")
        composer.setMessageBody("Good app, but... I need more help", isHTML: false)
        present(composer, animated: true)
    }
    
    func showImagePicker() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    @IBAction func editPhotoButtonTapped(_ sender: UIButton) {
        showImagePicker()
        print(currentContact as Any)
//        let updateImage = currentContact.image?.imageData
//        
//        try? PersistenceHelper.update
    }
    
    // the following IBAction can only be ran on a device
    @IBAction func callButtonClicked(_ sender: UIButton) {
        guard let phoneNumberURL = URL(string: "tel://\(currentContact.phoneNumber)") else { return }
        if UIApplication.shared.canOpenURL(phoneNumberURL) {
            UIApplication.shared.open(phoneNumberURL)
        } else {
            print("unable to open phoneNumberURL on this device")
        }
    }
    
    //https://www.youtube.com/watch?v=J-pn5V2jcfo
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        showMailComposer()
    }
    
}
//MARK: - Extensions

extension ContactDetailVC: MFMailComposeViewControllerDelegate {
    // delegate enable us to dismiss the email composer
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            //show error alert
            controller.dismiss(animated: true)
        }
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to send")
        case .saved:
            print("Saved")
        case .sent:
            print("Email Sent")
        }
        
        controller.dismiss(animated: true)
    }
}
