//
//  StoreView.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/04.
//

import SwiftUI

struct StoreView: View {
    @State var userMoney: Int = 1530
    
    @State var buttonIsActiveArray = [false, false, false, false, false]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                CoinComponent(money: userMoney, color: Color.theme.green1)
                
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
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 13.5, trailing: 0))
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    StoreProductButton(isActive: buttonIsActiveArray[0], color: canBuyItemColor(userMoney: userMoney), money: 1500, imageName: "palleteSet", action: {
                        buttonActive(index: 0)
                    })
                    .disabled(cantBuyItemDisable(userMoney: userMoney))
                    Spacer()
                    StoreProductButton(isActive: buttonIsActiveArray[1], color: canBuyItemColor(userMoney: userMoney), money: 1500, imageName: "palleteSet", action: {
                        buttonActive(index: 1)
                    })
                    .disabled(cantBuyItemDisable(userMoney: userMoney))
                    Spacer()
                    StoreProductButton(isActive: buttonIsActiveArray[1], color: canBuyItemColor(userMoney: userMoney), money: 1500, imageName: "palleteSet", action: {
                        buttonActive(index: 1)
                    })
                    .disabled(cantBuyItemDisable(userMoney: userMoney))
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 13.5, trailing: 0))
                
                HStack(spacing: 0) {
                    StoreProductButton(isActive: buttonIsActiveArray[0], color: canBuyItemColor(userMoney: userMoney), money: 1500, imageName: "palleteSet", action: {
                        buttonActive(index: 0)
                    })
                    .disabled(cantBuyItemDisable(userMoney: userMoney))
                    Spacer()
                    StoreProductButton(isActive: buttonIsActiveArray[1], color: canBuyItemColor(userMoney: userMoney), money: 1500, imageName: "palleteSet", action: {
                        buttonActive(index: 1)
                    })
                    .disabled(cantBuyItemDisable(userMoney: userMoney))
                    Spacer()
                    StoreProductButton(isActive: buttonIsActiveArray[1], color: canBuyItemColor(userMoney: userMoney), money: 1500, imageName: "palleteSet", action: {
                        buttonActive(index: 1)
                    })
                    .disabled(cantBuyItemDisable(userMoney: userMoney))
                }
                .padding(EdgeInsets(top: 13.5, leading: 0, bottom: 0, trailing: 0))
                
            }
            .padding(EdgeInsets(top: 13.5, leading: 0, bottom: 14, trailing: 0))
            
            ButtonComponent(buttonType: .nextButton, content: "저장하기", isActive: true, action: {
                
            })
            .padding(EdgeInsets(top: 14, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(EdgeInsets(top: 30, leading: 40, bottom: 20, trailing: 40))
    }
    
    func buttonActive(index: Int) {
        
        //
    }
    
    func canBuyItemColor(userMoney: Int) -> Color {
        return Color.theme.gray3
    }
    
    func cantBuyItemDisable(userMoney: Int) -> Bool {
        return false
    }
}

struct StoreView_Previewer: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
