//
//  NewEmployeeAssembly.swift
//  SQLiteDBApp
//
//  Created by Balu Naik on 5/28/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit

class NewEmployeeAssembly {
    
    func assemblyModule() -> NewEmployeeVC? {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewEmployeeVC") as? NewEmployeeVC
        vc?.presenter = presenterModule(with: vc)
        
        return vc
    }
    
    func presenterModule(with controller: NewEmployeeVC?) -> NewEmployeePresenter {
        let presenter = NewEmployeePresenter()
        presenter.userinterface = controller
        presenter.interactor = interactorModule(with: presenter)
        presenter.router = routerModule(with: presenter)
        
        return presenter
    }
    
    func interactorModule(with presenter:NewEmployeePresenter?) -> NewEmployeeInteractor {
        let interactor = NewEmployeeInteractor()
        interactor.presenter = presenter
        
        return interactor
    }
    
    func routerModule(with presenter: NewEmployeePresenter?) -> NewEmployeeRouter {
        let router = NewEmployeeRouter()
        
        return router
    }
    
}
