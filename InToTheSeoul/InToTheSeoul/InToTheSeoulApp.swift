//
//  InToTheSeoulApp.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/05/31.
//

import SwiftUI

@main
struct InToTheSeoulApp: App {
    @StateObject var pointsModel: PointsModel = PointsModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TrekkingInformationInput()
                    .environmentObject(pointsModel)
            }
        }
    }
}
