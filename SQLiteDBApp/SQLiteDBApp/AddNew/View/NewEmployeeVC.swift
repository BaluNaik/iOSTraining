//
//  NewEmployeeVC.swift
//  SQLiteDBApp
//
//  Created by Balu Naik on 5/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class NewEmployeeVC: UIViewController {
    
    var presenter: NewEmployeePresenterInput?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


// MARK: - NewEmployeePresenterOutput

extension NewEmployeeVC: NewEmployeePresenterOutput {
    
}
