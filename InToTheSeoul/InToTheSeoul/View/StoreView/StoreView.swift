//
//  StoreView.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/04.
//

import SwiftUI

struct StoreView: View {
    var body: some View {
        VStack(spacing: 0) {
            CoinComponent(money: 1750, color: Color.theme.green1)
            ZStack {
                
                ZStack {
                    VStack {
                        Ellipse()
                            .frame(width: 208, height: 38)
                            .foregroundColor(Color.theme.green1)
                    }
                    .frame(maxHeight: 208, alignment: .bottom)
                    Image("storeCharacter")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 153, height: 167)
                }
            }
        }
    }
}

struct StoreView_Previewer: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
