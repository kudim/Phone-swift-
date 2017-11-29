//
//  ViewController.swift
//  Phone
//
//  Created by Dmitry Anikin on 23/11/2017.
//  Copyright © 2017 KudimovMikhail. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var nameContact: UITextField!
    @IBOutlet weak var phoneContact: UITextField!
    var contactName : String?
    var contactPhone : String?
    var changeEnable = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameContact.text = contactName
        phoneContact.text = contactPhone
        nameContact.isUserInteractionEnabled = changeEnable
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ssveContact(_ sender: UIButton) {
        contactName = nameContact.text
        contactPhone = phoneContact.text
        guard let tableController = navigationController?.viewControllers.first as? ContactsViewController else {
            return
        }
        if changeEnable {
        if tableController.contacts[String(contactName![(contactName?.startIndex)!]).uppercased()] != nil {
            let cont = tableController.contacts[String(contactName![(contactName?.startIndex)!]).uppercased()]
            var names = [String]()
            for name in cont!{
                names.append(name.name)
            }
            if !(names.contains(contactName!)) {
                tableController.contacts[String(contactName![(contactName?.startIndex)!]).uppercased()]?.append(Contact(name:contactName!, number:contactPhone!))
            }
            else {
                let alertController = UIAlertController(title: "Error", message: "this name is already taken", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let replaceAction = UIAlertAction(title: "Replace", style: .default) {
                    (action) in self.replaceContact()}
                alertController.addAction(replaceAction)
                alertController.addAction(defaultAction)
                
                present(alertController, animated: true, completion: nil)
            }
        } else {
            tableController.contacts[String(contactName![(contactName?.startIndex)!])] = [Contact(name:contactName!, number:contactPhone!)]
        }
        }
        else {
            replaceContact()
        }
        tableController.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    func replaceContact() {
        guard let tableController = navigationController?.viewControllers.first as? ContactsViewController else {
            return
        }
        var index = 0
        for element in (tableController.contacts[String(contactName![(contactName?.startIndex)!]).uppercased()])! {
            if element.name == contactName  {
                Array((tableController.contacts[String(contactName![(contactName?.startIndex)!]).uppercased()])!)[index].name = contactName!
                Array((tableController.contacts[String(contactName![(contactName?.startIndex)!]).uppercased()])!)[index].number = contactPhone!
                break
            }
            index += 1
        }
    }
}

