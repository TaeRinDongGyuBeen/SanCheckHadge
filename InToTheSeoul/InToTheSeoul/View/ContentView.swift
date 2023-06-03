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
                .textFontAndColor(font: Font.SeoulFont.headline7, color: Color.theme.yellow)
            TextField("시험용", text: $test)
            
            ButtonComponent(buttonType: .mainViewButton, content: "산책\n기록보기", isActive: isTapped, imageName: "bookmark.fill") { isTapped.toggle()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
