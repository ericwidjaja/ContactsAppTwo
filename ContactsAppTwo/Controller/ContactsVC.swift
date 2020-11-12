//  ViewController.swift
//  ContactsAppTwo
//  Created by Eric Widjaja on 11/6/20.
//  Copyright © 2020 ericSwidjaja. All rights reserved.

import UIKit

class ContactsVC: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var contactsTableView: UITableView!
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        isEditingTableView.toggle() // changes a boolean value
    }
    
    private var allContacts = [Contact]()
    var isEditingTableView = false {
        didSet {
            contactsTableView.isEditing = isEditingTableView
            // toggle bar button item's title between "Edit" and "Done"
            navigationItem.leftBarButtonItem?.title = isEditingTableView ? "Done" : "Edit"
        }
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        loadAllContacts()
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
    }
    
    //MARK: Methods
    private func loadAllContacts() {
        //        allContacts = Contact.getAllContacts().sorted {$0.firstName < $1.firstName }
        do {
            allContacts = try PersistenceHelper.loadAllContacts()
        } catch {
            print("error loading contacts: \(error)")
        }
    }
    
    private func deleteContact(at indexPath: IndexPath) {
        do {
            try PersistenceHelper.delete(contact: indexPath.row)
        } catch {
            print("error deleting contact: \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ContactDetailVC,
            let contactIndexPath = contactsTableView.indexPathForSelectedRow else { return }
        let contactToSend = allContacts[contactIndexPath.row]
        destination.currentContact = contactToSend
    }
}

extension ContactsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contact = allContacts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        cell.textLabel?.text = contact.fullName
        cell.detailTextLabel?.text = contact.phoneNumber.description
        
        return cell
    }
}
