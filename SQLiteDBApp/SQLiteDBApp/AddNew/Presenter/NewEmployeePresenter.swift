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
    
    
}
