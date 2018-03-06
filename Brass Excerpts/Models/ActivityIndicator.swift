//
//  ActivityIndicator.swift
//  Brass Excerpts
//
//  Created by Thomas Swatland on 06.03.2018.
//  Copyright © 2018 Thomas Swatland. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

struct ActivityIndicator {
    static let container = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    static let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: NVActivityIndicatorType.lineScalePulseOut, color: .white, padding: 10)
    
    static func start() {
        activityIndicator.startAnimating()
    }
    
    static func stop() {
        activityIndicator.stopAnimating()
    }
}

