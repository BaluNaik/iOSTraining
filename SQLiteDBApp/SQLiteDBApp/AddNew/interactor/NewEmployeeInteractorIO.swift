//
//  NewEmployeeInteractorIO.swift
//  SQLiteDBApp
//
//  Created by Balu Naik on 5/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

enum QueryStatus {
    case insertSucess
    case insertFailure
    case updateSucess
    case updateFailure
}


protocol NewEmployeeInteractorInput: class {
    
    func submitNewRecord(data: EMP)
    func submitUpdateRecord(data: EMP)
    
}


protocol NewEmployeeInteractorOutput: class {
    
    func updateQueryStatus(status: QueryStatus)
    
}

