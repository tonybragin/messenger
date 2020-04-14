//
//  Charts.swift
//  chat
//
//  Created by Tony on 14/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

struct Charts {
    var charts: [Chart]
}

struct Chart {
    var messages: [Message]
}

struct Message {
    var message: String
    var time: Date
}
