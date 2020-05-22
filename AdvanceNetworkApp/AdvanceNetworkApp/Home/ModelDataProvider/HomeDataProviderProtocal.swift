//
//  HomeDataProviderProtocal.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/15/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

protocol HomeDataProviderProtocal: class {
    
    func updateContent()
    func showLoader(_ show: Bool)
    func showError(_ message: String)
    func stopLoadingNextPage()
    
}
