//
//  ProfileDetailsScreen.swift
//  ProfileApp
//
//  Created by pu on 28/04/20.
//  Copyright © 2020 RobustItIntellect. All rights reserved.
//

import UIKit

enum DetailsType {
    case Show
    case Add
}

protocol ProfileDetailsScreenDelegate: class {
    
    func saveNewprofile(data: Profile)
    
}

class ProfileDetailsScreen: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var profileData: Profile?
    var pageType:DetailsType = .Add
    weak var delegate: ProfileDetailsScreenDelegate?
   
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pageType == .Add ? "Add Details" : "Details"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackButton()
//        if let _ = self.profileData {
//            // Show profile information screen
//            showProfileDataScreen()
//        } else {
//            // Show add profile screen
//            addProfileDataScreen()
//        }
        if self.pageType == .Add {
            addProfileDataScreen()
        } else {
            showProfileDataScreen()
        }
    }
    
    private func setBackButton() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backButton = UIBarButtonItem(image:UIImage(named: "back-button"), style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showProfileDataScreen() {
        if let childVC = self.storyboard?.instantiateViewController(identifier: "ProfileShowViewController") as? ProfileShowViewController {
            childVC.profileData = self.profileData
            self.addChild(childVC)
            childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            childVC.view.frame = self.containerView.bounds // i.e. containerView autolayout sizes are applying to childview
            self.containerView.addSubview(childVC.view)  // Add childVc on top of containerView
            childVC.didMove(toParent: self) //Now childVC view lifecycle methods will call
        }
    }
    
    private func addProfileDataScreen() {
        if let childVC = self.storyboard?.instantiateViewController(identifier: "AddProfileViewController") as? AddProfileViewController {
            childVC.delegate = self
            self.addChild(childVC)
            childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            childVC.view.frame = self.containerView.bounds // i.e. containerView autolayout sizes are applying to childview
            self.containerView.addSubview(childVC.view)  // Add childVc on top of containerView
            childVC.didMove(toParent: self) //Now childVC view lifecycle methods will call
        }
    }
    
  }


extension ProfileDetailsScreen: AddProfileViewControllerDelegate {
    
    func saveNewprofile(data: Profile) {
        self.delegate?.saveNewprofile(data: data)
        self.navigationController?.popViewController(animated: true)
    }
}
