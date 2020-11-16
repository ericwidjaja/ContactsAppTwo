//  PersistenceHelper.swift
//  ContactsAppTwo
//  Created by Eric Widjaja on 11/8/20.
//  Copyright © 2020 ericSwidjaja. All rights reserved.

import Foundation

enum DataPersistenceError: Error { // conforming to the Error protocol
    case savingError(Error)
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistenceHelper {
    // CRUD - create, read, update, delete
    // array of contacts
    
    private static var contacts = [Contact]()
    private static let filename = "contacts.plist"
    
    private static func save() throws {
        //step 1. get url path to the file that the Contact will be saved to
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        print(url)
        
        //'contacts' array will be object that being converted to Data.
        //Data Object will be used and written (saved) to the documents directory
        do {
            //step 3. conveert(serialize) the contacts array into Data
            let data = try PropertyListEncoder().encode(contacts)
            // step 4. writes, saves, persist the data to the documents directory
            try data.write(to: url, options: .atomic)
        } catch {
            //step 5.
            throw DataPersistenceError.savingError(error)
        }
    }
    // for re-ordering
    public static func reorderContacts(contacts: [Contact]) {
        self.contacts = contacts
        try? save()
    }
    
    //CREATE - save item(new contact) to documents directory
    static func create(newContact: Contact) throws {
        //step 2. append new contact to the 'contacts' array
        contacts.append(newContact)
        
        do {
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    //READ - load (retrieve) contacts from documents directory
    static func loadAllContacts() throws -> [Contact] {
        //we need access to the filename URL that we are reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        //we need to check if the file exist, then
        // to convert URL to String we use .path on the URL
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    contacts = try PropertyListDecoder().decode([Contact].self, from: data)
                } catch {
                    throw DataPersistenceError.decodingError(error)
                }
            } else {
                throw DataPersistenceError.noData
            }
        } else {
            throw DataPersistenceError.fileDoesNotExist(filename)
        }
        return contacts
    }
    
    //UPDATE
    
    //DELETE - remove a contact from documents directory
    static func delete(contact index: Int) throws {
        //remove the contact from 'contacts' array
        contacts.remove(at: index)
        
        //save the remaining elements of 'contacts' array into the documents directory
        do {
            try save()
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
}

