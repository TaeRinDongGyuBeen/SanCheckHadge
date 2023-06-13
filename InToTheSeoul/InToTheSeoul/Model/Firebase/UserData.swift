//
//  UserData.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/13.
//

struct UserData: Codable, Identifiable, Hashable {
    var id: String
    var sex: String
    var age: String
    var walkingDate: String
    var walkingRoute: [[Double]]
    var startingPoint: String
    var endPoint: String
    var totalDistance: Double
    var accumulateDistance: Double
}
