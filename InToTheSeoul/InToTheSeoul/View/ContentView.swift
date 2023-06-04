//
//  ContentView.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/05/31.
//

import SwiftUI

struct ContentView: View {
    @State var test = ""
    @State var isTapped = false
    var body: some View {
        StoreView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
