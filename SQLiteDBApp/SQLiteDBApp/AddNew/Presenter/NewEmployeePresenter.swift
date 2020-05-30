//
//  NewEmployeePresenter.swift
//  SQLiteDBApp
//
//  Created by Balu Naik on 5/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

class NewEmployeePresenter: NewEmployeePresenterInput, NewEmployeeInteractorOutput {
    
    weak var userinterface: NewEmployeePresenterOutput?  //it has to be weak only
    var interactor: NewEmployeeInteractorInput?
    var router: NewEmployeeRouterInput?
    
    // MARK: - NewEmployeePresenterInput
    
    func submitUpdateRecord(data: EMP) {
        self.interactor?.submitUpdateRecord(data: data)
    }
    
    func submitNewRecord(data: EMP) {
        self.interactor?.submitNewRecord(data: data)
    }
    
    func loadNextScreen() {
        self.router?.moveToSomeScreen()
    }
    
    
    // MARK: - NewEmployeeInteractorOutput
    
    func updateQueryStatus(status: QueryStatus) {
        self.userinterface?.updateQueryStatus(status: status)
    }
    
}
