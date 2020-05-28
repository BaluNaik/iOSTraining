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
    
    func getFileURL() -> URL? {
        /*
          * First check User.plist is in doc dir
          * if it's in doc dir than return doc dir path
          * Else copy User.plist from bundle.main to documetn dir
          * Return file URL from this method
         */
        let rootPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)[0]
        let filePath = rootPath.appending("/User.plist")
        if !FileManager.default.fileExists(atPath: filePath) {
            if let fileBundlePath = Bundle.main.path(forResource: "User", ofType: "plist") {
                let fileBundleURl = URL(fileURLWithPath: fileBundlePath)
                let filePathUrl = URL(fileURLWithPath: filePath)
                do {
                    try FileManager.default.copyItem(at: fileBundleURl, to: filePathUrl)
                } catch {
                    
                    return nil
                }
            }
        }
        
        return URL(fileURLWithPath: filePath)
    }
    
    func getDataFromPlist() {
        if let fileUrl = getFileURL() {
            do {
                let data = try Data(contentsOf: fileUrl)
                if let dic = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format:.none) as? [String: Any] {
                    self.object = dic
                    self.tableView.reloadData()
                }
            } catch {
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
                if !writePlistFile(withData: self.object as NSDictionary) {
                    print("Error writing list")
                }
                self.getDataFromPlist()
            }
        }
    }
    
    func writePlistFile(withData data: NSDictionary) -> Bool {
        let rootPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)[0]
        let filePath = rootPath.appending("/User.plist")
        guard FileManager.default.fileExists(atPath: filePath) else {
            
            return false
        }

        return data.write(toFile: filePath, atomically: false)
    }
    
    func saveCustObject() {
        let user1 = User(userName: "Test1", password: "pass1")
        let user2 = User(userName: "Test2", password: "pass2")
        let user3 = User(userName: "Test3", password: "pass3");
        
        let array = [user1, user2, user3];
        
        let rootPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)[0]
        let filePath = rootPath.appending("/User.plist")
        guard FileManager.default.fileExists(atPath: filePath) else {
            
            return
        }
        //Saving
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false)
            try data.write(to: URL(fileURLWithPath:filePath))
        } catch {
            print("Couldn't write file")
        }
        
        //reading
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            if let loadedUser = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [User] {
                let result = loadedUser
            }
        } catch {
            print("Couldn't read file.")
        }
    }
    
    
}

