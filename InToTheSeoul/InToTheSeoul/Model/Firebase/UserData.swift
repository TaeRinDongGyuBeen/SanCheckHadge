//
//  UserData.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/13.
//

struct UserData: Codable, Identifiable, Hashable {
    var id: String
    var sex: Int
    var age: Int
    var walkingDate: String
    var walkingRoute: [[Double]]
    var totalDistance: Double
    var accumulateDistance: Double
}
