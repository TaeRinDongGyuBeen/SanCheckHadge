//
//  UserDataStore.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/13.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

// MARK: -


class UserDataStore: ObservableObject {
    @Published var userDatum: [UserData] = []
    @Published var changeCount: Int = 0
    
    //Realtime Database의 기본 경로 저장하는 변수
    let ref: DatabaseReference? = Database.database().reference()
    
    /**
     Realtime Database의 데이터 구조는 기본적으로 JSON 형태. 저장소와 데이터를 주고 받을 때 JSON 형식의 데이터를 주고 받기에 Encoder, Decoder 인스턴스가 필요.
     */
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // TODO: - Database CRUD Method Implementation
    
    /**
     데이터베이스를 실시간으로 관찰하여 데이터 변경 여부를 확인하여 실시간 데이터 읽기, 쓰기를 할 수 있게 하는 함수. Create, Update, Delete를 감지한다.
     
     databasePath.observe(관찰내용) 여기서 '변경내용'에 들어갈 수 있는 내용은 다음과 같다.
  
     .value: 경로에 있는 컨텐츠의 모든 변경 내용을 감지하고 읽어온다.
     .childAdded: 경로에 있는 컨텐츠 중 추가된 아이템이 있는 경우 아이템을 읽어온다.
     .childChanged: 경로에 있는 컨텐츠 중 수정된 아이템이 있는경우 아이템을 읽어온다.
     .childRemoved: 경로에 있는 컨텐츠 중 삭제된 아이템이 있는 경우 아이템을 읽어온다.
     .childMoved: 경로에 있는 컨텐츠 중 아이템 순서가 변경된 경우 아이템을 읽어온다.
     */
    func listenToRealtimeDatabase() {
        guard let databasePath = ref?.child("userDatum") else {
            return
        }
        
        // .childAdded: 저장소에 추가된 데이터를 읽어와서 UserDataStore내 UserDatum 변수에 추가한다.
        databasePath
            .observe(.childAdded) { [weak self] snapshot, _ in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else {
                    return
                }
                do {
                    let userDatum = try JSONSerialization.data(withJSONObject: json)
                    let userData = try self.decoder.decode(UserData.self, from: userDatum)
                    self.userDatum.append(userData)
                } catch {
                    print("에러가 발생됨", error)
                }
            }
        
        // .childChange: 저장소에 수정된 데이터를 읽어와서 UserDataStore 내 UserDatum을 순회하면서 id 값이 같은 아이템을 찾아내 재할당 한다.
        databasePath
            .observe(.childChanged) { [weak self] snapshot, _ in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else{
                    return
                }
                do{
                    let userDatum = try JSONSerialization.data(withJSONObject: json)
                    let userData = try self.decoder.decode(UserData.self, from: userDatum)
                    
                    var index = 0
                    for userDataItem in self.userDatum {
                        if (userData.id == userDataItem.id) {
                            break
                        } else {
                            index += 1
                        }
                    }
                    self.userDatum[index] = userData
                } catch{
                    print("에러가 발생됨", error)
                }
            }
        
        // .childRemoved: 저장소에 삭제된 데이터를 읽어와서 UserDataStore 내 UserDatum을 순회하면서 id 값이 같은 아이템을 찾아내어 삭제한다.
        databasePath
            .observe(.childRemoved) { [weak self] snapshot in
                guard
                    let self = self,
                    let json = snapshot.value as? [String: Any]
                else{
                    return
                }
                do{
                    let userDatum = try JSONSerialization.data(withJSONObject: json)
                    let userData = try self.decoder.decode(UserData.self, from: userDatum)
                    for (index, userDataItem) in self.userDatum.enumerated() where userData.id == userDataItem.id {
                        self.userDatum.remove(at: index)
                    }
                } catch{
                    print("에러가 발생됨", error)
                }
            }
        
        // .value: 저장소 데이터의 변경 여부를 감지한다.
        databasePath
            .observe(.value) { [weak self] snapshot in
                guard
                    let self = self
                else {
                    return
                }
                self.changeCount += 1
            }
    }
    
    /**
     데이터베이스를 실시간으로 관찰하는 것을 중지한다. 실행되면 listenToRealtimeDatabase() 기능이 상실된다.
     */
    func stopListening() {
        ref?.removeAllObservers()
    }
    
    /**
     데이터베이스에 UserData 인스턴스를 추가하는 함수
     */
    func createUserData(userData: UserData) {
        self.ref?.child("userDatum").child("\(userData.id)").setValue([
            "id": userData.id,
            "sex": userData.sex,
            "age": userData.age,
            "walkingDate": userData.walkingDate,
            "walkingRoute": userData.walkingRoute,
            "totalDistance": userData.totalDistance,
            "accumulateDistance": userData.accumulateDistance
        ] as [String : Any])
    }
    
    /**
     데이터베이스에서 UserData 인스턴스를 읽어오는 함수
     */
    func readUserData() {
        
    }
    
    /**
     데이터베이스에서 특정 경로의 데이터를 수정하는 함수
     */
    func updateUserData(userData: UserData) {
        let updates: [String : Any] = [
            "id": userData.id,
            "sex": userData.sex,
            "age": userData.age
        ]
        
        let childUpdates = ["userData/\(userData.id)": updates]
        for (index, userDataItem) in userDatum.enumerated() where userDataItem.id == userData.id {
            userDatum[index] = userData
        }
        self.ref?.updateChildValues(childUpdates)
    }
    
    /**
     데이터베이스에서 특정 경로의 데이터를 삭제하는 함수
     key는 경로를 의미한다. 이에 해당하는 데이터가 삭제되는 것이다.
     */
    func deleteUserData(key: String) {
        ref?.child("userData/\(key)").removeValue()
    }
    
}
