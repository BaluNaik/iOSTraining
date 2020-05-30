//
//  NewEmployeePresenterIO.swift
//  SQLiteDBApp
//
//  Created by Balu Naik on 5/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation


protocol NewEmployeePresenterInput: class {
    
    func submitNewRecord(data: EMP)
    func submitUpdateRecord(data: EMP)
    func loadNextScreen()
    
}


protocol NewEmployeePresenterOutput: class {
    
    func updateQueryStatus(status: QueryStatus)
    
}
