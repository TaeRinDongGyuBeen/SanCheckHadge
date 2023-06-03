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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .foregroundColor(Color.theme.yellow)
                .font(Font.seoul(.body4))
            TextField("시험용", text: $test)
            
            ButtonComponent(buttonType: .genderButton, isTapped: isTapped, content: "시험용", action: {
                isTapped.toggle()
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
