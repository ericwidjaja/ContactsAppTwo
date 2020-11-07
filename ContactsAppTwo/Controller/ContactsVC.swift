//  ViewController.swift
//  ContactsAppTwo
//  Created by Eric Widjaja on 11/6/20.
//  Copyright © 2020 ericSwidjaja. All rights reserved.

import UIKit

class ContactsVC: UIViewController {
    
    //MARK: Properties
    private var allContacts = [Contact]()
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        loadAllContacts()
    }
    
    //MARK: Methods
    func loadAllContacts() {
        allContacts = Contact.getAllContacts()
    }
}
