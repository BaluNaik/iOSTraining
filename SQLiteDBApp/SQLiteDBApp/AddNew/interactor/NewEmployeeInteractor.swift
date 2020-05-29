//
//  NewEmployeeInteractor.swift
//  SQLiteDBApp
//
//  Created by Balu Naik on 5/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

class NewEmployeeInteractor: NewEmployeeInteractorInput {
    
    weak var presenter: NewEmployeeInteractorOutput?
    
    
    // MARK: - NewEmployeeInteractorInput
    
    func submitNewRecord(data: EMP) {
        SQLiteManager.sharedInstance.insert(data: data) {[weak self] (status) in
            let queryStatus = status ? QueryStatus.insertSucess : QueryStatus.insertFailure
            self?.presenter?.updateQueryStatus(status: queryStatus)
        }
    }
    
    func submitUpdateRecord(data: EMP) {
        SQLiteManager.sharedInstance.update(data: data) {[weak self] (status) in
            let queryStatus = status ? QueryStatus.updateSucess : QueryStatus.updateFailure
            self?.presenter?.updateQueryStatus(status: queryStatus)
        }
    }
    
}
