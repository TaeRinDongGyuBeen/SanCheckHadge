//
//  File.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/04.
//

import SwiftUI

struct CoinComponent: View {
    @State var money: String
    @State var color: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 90, height: 27)
                .cornerRadius(30)
                .foregroundColor(Color.theme.green1)
            HStack {
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundColor(Color.theme.white)
                Text(money)
                    .textFontAndColor(.coin)
            }
        }
    
    }
}

struct CoinComponent_Previewer: PreviewProvider {
    static var previews: some View {
        CoinComponent(money: "1,750", color: Color.theme.green1)
    }
}
