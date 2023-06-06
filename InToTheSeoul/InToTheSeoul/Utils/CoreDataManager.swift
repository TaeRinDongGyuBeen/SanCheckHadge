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
    
    func createUser(username: String, age: Int, gender: Int) {
        
        let user = User(context: persistentContainer.viewContext)
        user.username = username
        user.age = Int16(age)
        user.gender = Int16(gender)
        user.accumulateCoin = 0
        user.accumulateDistance = 0.0
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("유저 데이터 생성 에러 \(error)")
        }
    }
    
    func createCharacter() {
        
        let character = Character(context: persistentContainer.viewContext)
        character.clothes = [String]()
        character.emotion = "bad"
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("캐릭터 생성 에러 \(error)")
        }
    }
    
    func createWorkData(date: Date, distance: Double, gainPoint: Int, moveRoute: [(Double)], checkPoint: [String], startPoint: String) {
        let workData = WorkData(context: persistentContainer.viewContext)
        workData.date = date
        workData.totalDistance = distance
        workData.gainCoin = Int16(gainPoint)
        workData.moveRoute = moveRoute
        workData.checkPoint = checkPoint
        workData.startPoint = startPoint
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("운동 데이터 생성 에러 \(error)")
        }
        
        // TODO: USER의 누적 포인트, 누적 총 거리 +하는 update 메서드 실행 필요
        
    }

    func readAllUser() -> [User] {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    
    
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
