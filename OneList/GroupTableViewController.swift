//
//  GroupTableViewController.swift
//  OneList
//
//  Created by 田逸昕 on 2019/4/24.
//  Copyright © 2019 Ezreal. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = sender as! IndexPath
        let to = segue.destination as! DetailViewController
        to.listTitle = TitleList[info.row]
        to.detailList = Details[to.listTitle!]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TitleList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableCell", for: indexPath) as! GroupTableViewCell
        cell.titleLabel.text = TitleList[indexPath.row]
        let list:[String?] = Details[TitleList[indexPath.row]]!
        cell.textLabel1.text = list[0] ?? ""
        cell.textLabel2.text = list[1] ?? ""
        cell.textLabel3.text = list[2] ?? ""
        cell.textLabel4.text = list[3] ?? ""
        cell.textLabel5.text = list[4] ?? ""
        cell.indexPath = indexPath
        cell.mainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handle(sender: ))))
        return cell
    }
    
    @objc func handle(sender: UITapGestureRecognizer) {
        let cell = sender.view?.superview?.superview as! GroupTableViewCell
        print("hello")
        performSegue(withIdentifier: "move", sender: cell.indexPath)
    }
    
    //override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "move", sender: indexPath)
    //}
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
