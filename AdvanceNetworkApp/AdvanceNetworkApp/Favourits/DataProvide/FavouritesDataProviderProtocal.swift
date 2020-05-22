//
//  FavouritesDataProviderProtocal.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/20/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

protocol FavouritesDataProviderProtocal: class {
    
    func updateContent()
    func showLoader(_ show: Bool)
    func showError(_ message: String)
    
}
