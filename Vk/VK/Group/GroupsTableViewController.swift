//
//  GroupsTableViewController.swift
//  VK
//
//  Created by Михаил Чудаев on 10.03.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    var groups = [String]()
    var selectedGroup: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupTableViewCell
        let group = groups[indexPath.row]
        cell.titleLabel.text = group
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedGroup = groups[indexPath.row]
        performSegue(withIdentifier: "toGroup", sender: self)
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup",
           let sourceVC = segue.source as? AllGroupTableViewController,
           let selectedGroup = sourceVC.selectedGroup {
            if !groups.contains(selectedGroup) {
                groups.append(selectedGroup)
                tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "toGroup",
           let destination = segue.destination as? ImageGroupViewController {
            destination.title = selectedGroup
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
