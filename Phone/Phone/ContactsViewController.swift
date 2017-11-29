//
//  ContactsViewController.swift
//  Phone
//
//  Created by Dmitry Anikin on 23/11/2017.
//  Copyright © 2017 KudimovMikhail. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController {

    var contacts = ["A": [Contact(name: "Alice", number: "+7(823)345-09-45"), Contact(name:"Ann", number: "+7(950)436-14-98"), Contact(name:"Andrey", number:"+7(965)543-23-90")], "D": [Contact(name: "Dima",number: "+7(999)999-99-99"), Contact(name: "Dasha", number: "+7(950)234-11-12")], "M": [Contact(name:"My", number:"+7(345)-345-23-11")],"K": [Contact(name:"Kate", number: "+7(947)456-36-32")]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return contacts.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let sortedKeys = Array(contacts.keys).sorted(by: <)
        let name = Array(contacts[sortedKeys[section]]!)
        let sortedNames = name.sorted {$0.name < $1.name }
        return sortedNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let sortedKeys = Array(contacts.keys).sorted(by: <)
        let name = Array(contacts[sortedKeys[indexPath.section]]!)
        let sortedNames = name.sorted { $0.name < $1.name }
        cell.textLabel?.text = sortedNames[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sortedKeys = Array(contacts.keys).sorted(by: <)
        let name = Array(contacts[sortedKeys[section]]!)
        return name[0].titleFirstLetter
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "What", message: "are you gonna do?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Call", style: .default) { (action) in self.call(section: indexPath.section, row: indexPath.row) }
        let replaceAction = UIAlertAction(title: "Change", style: .default) {
            (action) in self.change(section: indexPath.section, row: indexPath.row)}
        alertController.addAction(replaceAction)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func call(section: Int, row: Int) {
        
        let controller = tabBarController?.viewControllers![1] as? RecentViewController
        let sortedKeys = Array(contacts.keys).sorted(by: <)
        let name = Array(contacts[sortedKeys[section]]!)
        let sortedNames = name.sorted { $0.name < $1.name }
        
        if let url = URL(string: "tel://\(String(describing: sortedNames[row].number))"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        if controller?.calls.count != 0 {
            if controller?.calls[(controller?.calls.count)! - 1].contact.name != sortedNames[row].name {
                controller?.calls.append(Call(contact: Contact(name: sortedNames[row].name, number:sortedNames[row].number), date: Calendar.current))
                controller?.tableView.reloadData()
            }
            else {
                controller?.calls[(controller?.calls.count)! - 1].date = Calendar.current
            controller?.tableView.reloadData()
            }
        }
        else {
            controller?.calls.append(Call(contact: Contact(name: sortedNames[row].name, number:sortedNames[row].number), date: Calendar.current))
            controller?.tableView.reloadData()
        }
    }
    
    func change(section: Int, row: Int) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "contactController") as? ViewController
        let sortedKeys = Array(contacts.keys).sorted(by: <)
        let name = Array(contacts[sortedKeys[section]]!)
        let sortedNames = name.sorted { $0.name < $1.name }
        controller?.contactName = sortedNames[row].name
        controller?.contactPhone = sortedNames[row].number
        controller?.changeEnable = false
        show(controller!, sender: self)
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let sortedKeys = Array(contacts.keys).sorted(by: <)
            let key = sortedKeys[indexPath.section]
            
            if contacts[key]?.count == 1 {
                contacts.removeValue(forKey: key)
                let indexSet = IndexSet(integer: indexPath.section)
                tableView.deleteSections(indexSet, with: .fade)
            }
            else {
                let name = Array(contacts[sortedKeys[indexPath.section]]!)
                let sortedNames = name.sorted { $0.name < $1.name }
                contacts[key]?.remove(at: (contacts[key]?.index(of: sortedNames[indexPath.row]))!)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
