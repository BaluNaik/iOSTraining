//
//  UtilityExtension.swift
//  formalProtocolWithTextField
//
//  Created by Balu Naik on 4/17/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation

extension String {
    
    func isValidateLength(_ maxLength: Int) -> Bool {
        
        return self.count <= maxLength
    }
}
