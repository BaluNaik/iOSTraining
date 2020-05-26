//
//  MasterViewController.swift
//  UserDefaultAndPlist
//
//  Created by Balu Naik on 5/26/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var object = [String: Any]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getDataFromPlist()
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        if let user = UserDefaultManager.sharedInstance.getUser() {
            if let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController")  as? DetailViewController {
                vc.detailItem = user.userName
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
        let alertVc = UIAlertController(title: "Enter user name", message: nil, preferredStyle: .alert)
        alertVc.addTextField { (textfiled) in
            textfiled.placeholder = "User name here...."
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default) {[weak self] (_) in
            if let textField = alertVc.textFields?[0], let text = textField.text {
                self?.saveNewUser(newUser: text)
            }
        }
        alertVc.addAction(submitAction);
        self.present(alertVc, animated: true, completion: nil)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let userList = object["User"] as? [String] {
                    let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                    controller.detailItem = userList[indexPath.row]
                    controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                    controller.navigationItem.leftItemsSupplementBackButton = true
                    detailViewController = controller
                }
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let userList = object["User"] as? [String] {
            
            return userList.count
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let userList = object["User"] as? [String] {
            let userName = userList[indexPath.row]
            cell.textLabel!.text = userName
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

}

extension MasterViewController {
    
    func getDataFromPlist() {
        // Fist check this file in docuemnt dir
        
        if let fileUrl = Bundle.main.path(forResource: "User", ofType: "plist") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: fileUrl))
                if let dic = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format:.none) as? [String: Any] {
                    self.object = dic
                }
            }
            catch {
                print("Error in reading")
            }
        }
    }
    
    func saveNewUser( newUser: String) {
        if let isReadOnly = self.object["ReadOnly"] as? Bool, !isReadOnly {
            if var users = self.object["User"] as? [String] {
                users.append(newUser)
                self.object["User"] = users
                self.object["LastUpdateDate"] = Date()
                if let fileUrl = Bundle.main.path(forResource: "User", ofType: "plist") {
                    if !writePlistFile(withData: self.object as NSDictionary, atPath: fileUrl) {
                        print("Error writing list \(fileUrl)")
                    }
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    func writePlistFile(withData data: NSDictionary, atPath path: String) -> Bool {
        guard FileManager.default.fileExists(atPath: path) else {
            
            return false
        }

        return data.write(toFile: path, atomically: false)
    }
}

