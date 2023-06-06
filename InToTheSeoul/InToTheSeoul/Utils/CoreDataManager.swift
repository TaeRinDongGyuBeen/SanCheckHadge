//
//  File.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/05.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static var coreDM: CoreDataManager = CoreDataManager()
    
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
    

    func updateCharacterEmotion(_ emotion: String) {
        CoreDataManager.coreDM.readCharacter()[0].emotion = emotion
        
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
        tempClothes?.append(clothes)
        CoreDataManager.coreDM.readCharacter()[0].clothes = tempClothes
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback() // 오류나면 오류난 걸 지워버린다. 오류나지 않은 가장 최신의 것을 불러온다.
        }
    }
    
    func updateCoin(_ gainCoin: Int) {
        CoreDataManager.coreDM.readUser()[0].accumulateCoin = Int16(gainCoin)
        
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
//
//
//                                                  static var shared: CoreDataManager = CoreDataManager()
//
//                                                  lazy var persistentContainer: NSPersistentContainer = {
//                let container = NSPersistentContainer(name: "Model")
//                container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//                    if let error = error as NSError? {
//                        fatalError("Unresolved error \(error), \(error.userInfo)")
//                    }
//                })
//                return container
//            }()
//
//                                                  var context: NSManagedObjectContext {
//                return persistentContainer.viewContext
//            }
//
//                                                  // MARK: - Entity
//
//                                                  var userEntity: NSEntityDescription? {
//                return  NSEntityDescription.entity(forEntityName: "User", in: context)
//            }
//
//                                                  var characterEntity: NSEntityDescription? {
//                return  NSEntityDescription.entity(forEntityName: "Character", in: context)
//            }
//
//                                                  var workDataEntity: NSEntityDescription? {
//                return  NSEntityDescription.entity(forEntityName: "WorkData", in: context)
//            }
//
//
//                                                  // MARK: - CRUD 메서드
//
//                                                  // 기본 save 메서드
//                                                  func saveToContext() {
//                do {
//                    try context.save()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//
//                                                  // MARK: - User 관련 메서드
//                                                  func fetchUser() -> [User] {
//                do {
//                    let request = User.fetchRequest()
//                    let results = try context.fetch(request)
//                    return results
//                } catch {
//                    print(error.localizedDescription)
//                }
//                return []
//            }
//
//                                                  func createUser(_ user: User) {
//                if let entity = userEntity {
//                    let managedObject = NSManagedObject(entity: entity, insertInto: context)
//                    managedObject.setValue(user.username, forKey: "username")
//                    managedObject.setValue(user.gender, forKey: "gender")
//                    managedObject.setValue(user.age, forKey: "age")
//                    managedObject.setValue(user.accumulateCoin, forKey: "accumulateCoin")
//                    managedObject.setValue(user.accumulateDistance, forKey: "accumulateDistance")
//                    saveToContext()
//                }
//            }
//
//                                                  func getUser() -> [User] {
//                var notices: [User] = []
//                let fetchResults = fetchUser()
//                for result in fetchResults {
//                    let notice = Notice(title: result.title ?? "", time: result.time ?? "", url: result.url ?? "")
//                    notices.append(notice)
//                }
//                return notices
//            }
//
//                                                  func updateBookmarks(_ notice: Notice) {
//                let fetchResults = fetchBookmarks()
//                for result in fetchResults {
//                    if result.url == notice.url {
//                        result.title = "업데이트한 제목"
//                    }
//                }
//                saveToContext()
//            }
