//
//  ContentView.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/05/31.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("_isFirstLaunch") var isFirst: Bool = true
    
    var body: some View {
        if isFirst {
            OnboardingView(isFirstLaunch: $isFirst)
        } else {
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
