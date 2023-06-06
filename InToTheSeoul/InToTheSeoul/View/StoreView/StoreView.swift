//
//  StoreView.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/04.
//

import SwiftUI

// TODO: CoreDataManager를 활용하여 돈의 변화와 아이템 소장 여부를 CRU 해주어야 함.

struct StoreView: View {
    @State var userMoney: Int = 1500
    
    //Int(CoreDataManager.coreDM.readUser()[0].accumulateCoin)
    @State var presentClothes: String = (CoreDataManager.coreDM.readCharacter()[0].presentClothes ?? "")
    @State var clothes: [String] = CoreDataManager.coreDM.readCharacter()[0].clothes ?? [String]()
    @State var characterEmotion: String = CoreDataManager.coreDM.readCharacter()[0].emotion ?? "Bad"
    
    @State var puttingClothes: String = ""
    
    @State var buttonIsActiveArray = [false, false, false, false, false]
    
    @State private var alertShowing: Bool = false
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
                    Image("\(characterEmotion)_Hedge")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 153, height: 167)
                }
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 13.5, trailing: 0))
            Spacer()
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    StoreProductButton(
                        isActive: buttonIsActiveArray[0],
                        color: canBuyItemColor(userMoney: userMoney, price: 1500),
                        isOwnItem: checkOwnItem(itemName: "palleteSet"),
                        money: 1500,
                        imageName: "palleteSet",
                        action: {
                            buttonActive(index: 0)
                            puttingClothes = "palleteSet"
                        })
                    .disabled(cantBuyItemDisable(userMoney: userMoney, price: 1500))
                    
                    Spacer()
                    
                    StoreProductButton(
                        isActive: buttonIsActiveArray[1],
                        color: canBuyItemColor(userMoney: userMoney, price: 2000),
                        isOwnItem: checkOwnItem(itemName: "drum"),
                        money: 2000,
                        imageName: "drum",
                        action: {
                            buttonActive(index: 1)
                            puttingClothes = "drum"
                        })
                    .disabled(cantBuyItemDisable(userMoney: userMoney, price: 2000))
                    
                    Spacer()
                    
                    StoreProductButton(
                        isActive: buttonIsActiveArray[2],
                        color: canBuyItemColor(userMoney: userMoney, price: 1200),
                        isOwnItem: clothes.contains("books"),
                        money: 1200,
                        imageName: "books",
                        action: {
                            buttonActive(index: 2)
                            puttingClothes = "books"
                        })
                    .disabled(cantBuyItemDisable(userMoney: userMoney, price: 1200))
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 13.5, trailing: 0))
                
                HStack(spacing: 0) {
                    StoreProductButton(
                        isActive: buttonIsActiveArray[3],
                        color: canBuyItemColor(userMoney: userMoney, price: 1700),
                        isOwnItem: checkOwnItem(itemName: "trainingTools"),
                        money: 1700,
                        imageName: "trainingTools",
                        action: {
                            buttonActive(index: 3)
                            puttingClothes = "trainingTools"
                        })
                    .disabled(cantBuyItemDisable(userMoney: userMoney, price: 1700))
                    
                    Spacer()
                    
                    StoreProductButton(isActive: buttonIsActiveArray[4], color: canBuyItemColor(userMoney: userMoney, price: 1500), isOwnItem: checkOwnItem(itemName: "macbook"), money: 1500, imageName: "macbook", action: {
                        buttonActive(index: 4)
                        puttingClothes = "macbook"
                    })
                    .disabled(cantBuyItemDisable(userMoney: userMoney, price: 1500))
                    
                    Spacer()
                    
                    ButtonComponent(buttonType: .storeReadyForSaleButton, content: "준비중입니다", isActive: false, action: {
                        
                    })
                }
                .padding(EdgeInsets(top: 13.5, leading: 0, bottom: 0, trailing: 0))
                
            }
            .padding(EdgeInsets(top: 13.5, leading: 0, bottom: 14, trailing: 0))
            
            Spacer()
            
            ButtonComponent(buttonType: .nextButton, content: "저장하기", isActive: true, action: {
                alertShowing.toggle()
            })
            .alert("정말 구매하실건가요?", isPresented: $alertShowing) {
                Button("취소") {
                    
                }
                Button("확인") {
                    
                }
                
            } message: {
                Text("확인 버튼을 누르면 행복코인으로 아이템을 구매합니다.")
                    .textFontAndColor(.body4)
            }
            .padding(EdgeInsets(top: 14, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(EdgeInsets(top: 30, leading: 40, bottom: 20, trailing: 40))
    }
    
    func buttonActive(index: Int) {
        for i in stride(from: 0, through: buttonIsActiveArray.count - 1, by: 1) {
            buttonIsActiveArray[i] = false
        }
        buttonIsActiveArray[index].toggle()
    }
    
    func canBuyItemColor(userMoney: Int, price: Int) -> Color {
        return userMoney >= price ? Color.theme.yellow : Color.theme.gray3
    }
    
    func cantBuyItemDisable(userMoney: Int, price: Int) -> Bool {
        return userMoney >= price ? false : true
    }
    
    /**
     사용자가 해당 아이템을 가지고 있는지 확인하는 메서드
     */
    func checkOwnItem(itemName: String) -> Bool {
        // TODO: 코어데이터의 데이터 값과 비교하여, 데이터가 있으면 true, 아니면 false
        return false
    }
}

struct StoreView_Previewer: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
