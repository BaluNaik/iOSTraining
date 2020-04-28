//
//  ViewController.swift
//  tableViewBasic
//
//  Created by Balu Naik on 4/27/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var flowersList: [String] = ["Daffodil",
                                         "Jasmine",
                                         "Lily",
                                         "Marigold",
                                         "Primrose",
                                         "Sweet violet",
                                         "Saffron",
                                         "Daisy",
                                         "Lady of the Night",
                                         "Lotus",
                                         "Narcissus",
                                         "Rose"]
    
    private var animalsList: [String] = ["bear",
                                         "cat",
                                         "dog",
                                         "elephant",
                                         "girraffe",
                                         "horse",
                                         "leopard",
                                         "lion",
                                         "monkey",
                                         "zebra"]
    
    private var fruitsList: [String] = ["apple",
                                        "banana",
                                        "dragonfruit",
                                        "graps",
                                        "mango",
                                        "oranges",
                                        "pomogranate",
                                        "strwberry",
                                        "turkey",
                                        "watermelon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Favorite"
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func getTitleInSection(section: Int) -> String {
        switch section {
        case 0:
            
            return "Animals"
        case 1:
            
            return "Flowers"
        default:
            
            return "Fruits"
        }
    }
    
    private func geItemInSection(section: Int, row: Int) -> String {
          switch section {
          case 0:
              
            return self.animalsList[row]
          case 1:
              
              return self.flowersList[row]
          default:
              
              return self.fruitsList[row]
          }
      }
      

}

// MARK: - Private extension

extension ViewController: UITableViewDelegate, UITableViewDataSource {
   
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3;   // By default 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            
            return self.animalsList.count
        case 1:
            
            return self.flowersList.count
        default:
            
            return self.fruitsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.section == 0 {  // it's animal section
            cell.textLabel?.text = self.animalsList[indexPath.row]
            cell.imageView?.image = UIImage(named: self.animalsList[indexPath.row])
            print("Location: \(indexPath.section), \(indexPath.row)")
        } else if indexPath.section == 1 { // it's flower section
            cell.textLabel?.text = self.flowersList[indexPath.row]
            cell.imageView?.image = UIImage(named: self.flowersList[indexPath.row])
             print("Location: \(indexPath.section), \(indexPath.row)")
        } else { // its fruits
            cell.textLabel?.text = self.fruitsList[indexPath.row]
            cell.imageView?.image = UIImage(named: self.fruitsList[indexPath.row])
             print("Location: \(indexPath.section), \(indexPath.row)")
        }
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    //    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    //
    //        return ["Animals", "Flowers", "Fruits"]
    //    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        switch section {
    //        case 0:
    //
    //            return "Animals"
    //        case 1:
    //
    //            return "Flowers"
    //        default:
    //
    //            return "Fruits"
    //        }
    //
    //    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headeView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50.0))
        let headerTitleLabel = UILabel(frame: headeView.frame)
        if section == 0 {
            headerTitleLabel.text = "Animals"
            headerTitleLabel.textAlignment = .left
            headeView.backgroundColor = UIColor.lightGray
        } else if section == 1 {
            headerTitleLabel.text = "Flowers"
            headerTitleLabel.textAlignment = .center
            headeView.backgroundColor = UIColor.blue
        } else {
            headerTitleLabel.text = "Fruits"
            headerTitleLabel.textAlignment = .right
            headeView.backgroundColor = UIColor.brown
        }
        headerTitleLabel.textColor = UIColor.red
        headerTitleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        headeView.addSubview(headerTitleLabel)
        
        return headeView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return section == 2 ?  10 : 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 || section == 1 {
            
            return nil
        }
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10.0))
        footerView.backgroundColor = UIColor.purple
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.section) \(indexPath.row)")
        if let vc = self.storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController {
            vc.setData(title: self.getTitleInSection(section: indexPath.section), imageName: self.geItemInSection(section: indexPath.section, row: indexPath.row))
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}

