//
//  MasterViewController.swift
//  SQLiteDBApp
//
//  Created by Balu Naik on 5/27/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [EMP]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        self.objects = SQLiteManager.sharedInstance.display()
        self.tableView.reloadData()
    }

    @objc
    func insertNewObject(_ sender: Any) {
        let newAssembly = NewEmployeeAssembly()
        if let vc = newAssembly.assemblyModule(for: .New) {
            self.navigationController?.pushViewController(vc, animated: true);
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = (self.objects[indexPath.row].fistName ?? "") + " " + (self.objects[indexPath.row].lastName ?? "")
        cell.detailTextLabel?.text = self.objects[indexPath.row].email ?? ""
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let empID = self.objects[indexPath.row].empID {
                SQLiteManager.sharedInstance.delete(id: empID) {[weak self] (status) in
                    if status {
                        self?.objects.remove(at: indexPath.row)
                        self?.tableView.deleteRows(at: [indexPath], with: .fade)
                    } else {
                        let alertVc = UIAlertController(title: "Error", message: "Can't delete record!!", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alertVc.addAction(okAction)
                        self?.present(alertVc, animated: true, completion: nil)
                    }
                }
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newAssembly = NewEmployeeAssembly()
        if let vc = newAssembly.assemblyModule(for: .Update) {
            vc.empData = self.objects[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true);
        }
    }


}

