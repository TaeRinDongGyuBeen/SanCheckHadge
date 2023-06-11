//
//  File.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/05.
//

import CoreData
import UIKit
import Combine

class CoreDataManager: ObservableObject {
    
    static let coreDM: CoreDataManager = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    private var cancellables = Set<AnyCancellable>()
    
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
        user.accumulateCoin = 1200
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
        character.emotion = "Bad"
        character.presentClothes = ""
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("캐릭터 생성 에러 \(error)")
        }
    }
    
    func createWorkData(date: Date, distance: Double, totalTime: Int, gainPoint: Int, moveRoute: [(Double)], checkPoint: [String], startPoint: String) {
        let workData = WorkData(context: persistentContainer.viewContext)
        workData.date = date
        workData.totalDistance = distance
        workData.totalTime = Int16(totalTime)
        workData.gainCoin = Int16(gainPoint)
        workData.moveRoute = moveRoute
        workData.checkPoint = checkPoint
        workData.startPoint = startPoint
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("운동 데이터 생성 에러 \(error)")
        }
        
        updateCharacterEmotion(CoreDataManager.coreDM.readWorkData().count)
        // TODO: USER의 누적 포인트, 누적 총 거리 +하는 update 메서드 실행 필요
        
    }
    
    func readUser() -> [User] {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    
    func readWorkData() -> [WorkData] {
        let fetchRequest: NSFetchRequest<WorkData> = WorkData.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func readCharacter() -> [Character] {
        let fetchRequest: NSFetchRequest<Character> = Character.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    

    func updateCharacterEmotion(_ trekkingCount: Int) {
        if trekkingCount <= 2 {
            CoreDataManager.coreDM.readCharacter()[0].emotion = "Bad"
        } else if trekkingCount <= 4 {
            CoreDataManager.coreDM.readCharacter()[0].emotion = "Normal"
        } else {
            CoreDataManager.coreDM.readCharacter()[0].emotion = "Happy"
        }
        
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback() // 오류나면 오류난 걸 지워버린다. 오류나지 않은 가장 최신의 것을 불러온다.
        }
    }
    
    func updateCharacterPresentClothes(_ presentClothes: String) {
        CoreDataManager.coreDM.readCharacter()[0].presentClothes = presentClothes
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback() // 오류나면 오류난 걸 지워버린다. 오류나지 않은 가장 최신의 것을 불러온다.
        }
    }
    
    func updateCharacterClothes(_ clothes: String) {
        var tempClothes = CoreDataManager.coreDM.readCharacter()[0].clothes
        print("updateCharacterClothes 내부 :", tempClothes!)
        tempClothes?.append(clothes)
        print("updateCharacterClothes append 이후 :", tempClothes!)
        CoreDataManager.coreDM.readCharacter()[0].clothes = tempClothes
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback() // 오류나면 오류난 걸 지워버린다. 오류나지 않은 가장 최신의 것을 불러온다.
        }
    }
    
    func updateCoin(_ gainCoin: Int) {
        CoreDataManager.coreDM.readUser()[0].accumulateCoin += Int16(gainCoin)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback() // 오류나면 오류난 걸 지워버린다. 오류나지 않은 가장 최신의 것을 불러온다.
        }
    }
    
    func updateAccumulateDistance(_ gainDistance: Double) {
        CoreDataManager.coreDM.readUser()[0].accumulateDistance = gainDistance
        
        do {
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
