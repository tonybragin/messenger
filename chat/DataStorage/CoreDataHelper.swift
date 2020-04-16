//
//  CoreDataHelper.swift
//  chat
//
//  Created by Tony on 16/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper {
    
    // MARK: - Public
    
    func save() {
        let context = getContext()
        try? context.save()
    }
    
    func load() -> ChatsCoreData {
        let context = getContext()
        
        let request = NSFetchRequest<ChatsCoreData>(entityName: "ChatsCoreData")
        request.returnsObjectsAsFaults = false
        
        if let result = try? context.fetch(request).first {
            return result
        } else {
            let entity = NSEntityDescription.entity(forEntityName: "ChatsCoreData", in: context)
            let newItem = ChatsCoreData(entity: entity!, insertInto: context)
            save()
            return newItem
        }
    }
    
    // MARK: - Utility
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
}

// MARK: - Working with DataHelper

extension CoreDataHelper: DataHelper {
    
    func getChats() -> Chats {
        let data = load().data
        return getChats(from: data)
    }
    func save(chats: Chats) {
        let data = getData(from: chats)
        let chatsCoreData = load()
        chatsCoreData.data = data
        save()
    }
}
