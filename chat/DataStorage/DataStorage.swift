//
//  DataStorage.swift
//  chat
//
//  Created by Tony on 16/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit
import CoreData

class DataStorage {
    
    static var shared = DataStorage()
    
    private(set) var chats = Chats()
    
    private var dataHelper: DataHelper
    
    private init() {
        dataHelper = CoreDataHelper()
        chats = dataHelper.getChats()
    }
    
    func save() {
        dataHelper.save(chats: chats)
    }
}

protocol DataHelper {
    func getChats() -> Chats
    func save(chats: Chats)
}

extension DataHelper {
    func getChats(from data: Data?) -> Chats {
        if let data = data {
            if let decodedChats = try? JSONDecoder().decode(Chats.self, from: data) {
                return decodedChats
            }
        }
        return Chats()
    }
    
    func getData(from chats: Chats) -> Data? {
       return try? JSONEncoder().encode(chats)
    }
}

class UserDefaultsHelper: DataHelper {
    func getChats() -> Chats {
        let data = UserDefaults.standard.data(forKey: "chats")
        return getChats(from: data)
    }
    func save(chats: Chats) {
        if let data = getData(from: chats) {
            UserDefaults.standard.set(data, forKey: "chats")
            UserDefaults.standard.synchronize()
        }
    }
}

class CoreDataHelper: DataHelper {
    
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
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
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
}
