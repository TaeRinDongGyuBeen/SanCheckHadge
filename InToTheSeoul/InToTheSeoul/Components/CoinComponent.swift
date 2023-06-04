//
//  File.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/04.
//

import SwiftUI


struct CoinComponent: View {
    @State var money: Int
    @State var color: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 90, height: 27)
                .cornerRadius(30)
                .foregroundColor(color)
            HStack {
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundColor(Color.theme.white)
                Text("\(money)")
                    .textFontAndColor(.coin)
            }
        }
    
    }
}

struct CoinComponent_Previewer: PreviewProvider {
    static var previews: some View {
        CoinComponent(money: 1750, color: Color.theme.green1)
    }
}
