//
//  DataStorage.swift
//  chat
//
//  Created by Tony on 16/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

class DataStorage {
    
    // MARK: - Properties
    
    static var shared = DataStorage()
    private(set) var chats = Chats()
    private var dataHelper: DataHelper
    
    // MARK: - Initialization
    
    private init() {
        dataHelper = CoreDataHelper()
        chats = dataHelper.getChats()
    }
    
    // MARK: - Public
    
    func save() {
        dataHelper.save(chats: chats)
    }
}
