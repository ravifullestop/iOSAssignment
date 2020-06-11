//
//  Utilities.swift
//  PayTabsIntegrationSwift
//
//  Created by Prahalad Kumawat on 11/06/20.
//  Copyright © 2020 Prahalad Kumawat. All rights reserved.
//

import Foundation

func random(digits:Int) -> String {
    var number = String()
    for _ in 1...digits {
       number += "\(Int.random(in: 1...9))"
    }
    return number
}
