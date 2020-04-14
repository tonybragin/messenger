//
//  Int.swift
//  chat
//
//  Created by Tony on 14/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

extension Int {
    var printable: String {
        return "\(self < 10 ? "0": "")\(self)"
    }
}
