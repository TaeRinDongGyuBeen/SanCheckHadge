//
//  File.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/05.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let coreDM = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name:"UserDataModel")
        persistentContainer.loadPersistentStores {(description, error) in
            if let error = error {
                fatalError("CoreData 저장소 오류 \(error.localizedDescription)")
            }
        }
        
    }
    
    func createUser() {
        
        let user = User(context: persistentContainer.viewContext)
        user.username = "김예은"
        user.age = 200
        user.gender = ""
        user.accumulateCoin = 0
        user.accumulateDistance = 0.0
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save profile \(error)")
        }
    }
    
//    func createBunny() {
//
//        let bunny = Bunny(context: persistentContainer.viewContext)
//        bunny.characterName = "이동재"
//        bunny.level = 1
//
//        do {
//            try persistentContainer.viewContext.save()
//        } catch {
//            print("Failed to save profile \(error)")
//        }
//    }

    func readAllUser() -> [User] {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
//
//    func readAllBunny() -> [Bunny] {
//
//        let fetchRequest: NSFetchRequest<Bunny> = Bunny.fetchRequest()
//
//        do{
//            return try persistentContainer.viewContext.fetch(fetchRequest)
//        } catch {
//            return []
//        }
//    }
    
    func update() {
        
        do{
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback() // 오류나면 오류난 걸 지워버린다. 오류나지 않은 가장 최신의 것을 불러온다.
        }
    }
    
    func deleteUser(user: User) {
        
        persistentContainer.viewContext.delete(user)
        
        do{
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
}
