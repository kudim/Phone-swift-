//
//  RecentViewController.swift
//  Phone
//
//  Created by Dmitry Anikin on 23/11/2017.
//  Copyright © 2017 KudimovMikhail. All rights reserved.
//

import UIKit

class RecentViewController: UITableViewController {

    var calls = [Call]()
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return calls.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRecent", for: indexPath) as! MyTableViewCell
        cell.nameLabel?.text = calls[calls.count - indexPath.row - 1].contact.name
        cell.phoneLabel?.text = calls[calls.count - indexPath.row - 1].contact.number
        var hour : String
        var minute : String
        if Int(calls[calls.count - indexPath.row - 1].date.component(.hour,from: Date())) < 10 {
            hour = String("0" + String(calls[calls.count - indexPath.row - 1].date.component(.hour,from: Date())))
        }
        else {
            hour = String(calls[calls.count - indexPath.row - 1].date.component(.hour,from: Date()))
        }
        
        if Int(calls[calls.count - indexPath.row - 1].date.component(.hour,from: Date())) < 10 {
            minute = String("0" + String(calls[calls.count - indexPath.row - 1].date.component(.minute,from: Date())))
        }
        else {
            minute = String(calls[calls.count - indexPath.row - 1].date.component(.minute,from: Date()))
        }
        cell.timeLabel?.text = String(hour + ":" + minute)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
