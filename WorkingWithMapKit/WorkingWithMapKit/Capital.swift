//
//  Capital.swift
//  WorkingWithMapKit
//
//  Created by Balu Naik on 6/4/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import Foundation
import MapKit

class Capital: NSObject, MKAnnotation {
    
    var title: String?
    var info: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
}
