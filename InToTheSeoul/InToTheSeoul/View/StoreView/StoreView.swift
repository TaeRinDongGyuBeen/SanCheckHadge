//
//  StoreView.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/04.
//

import SwiftUI

// TODO: CoreDataManager를 활용하여 돈의 변화와 아이템 소장 여부를 CRU 해주어야 함.

struct StoreView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var userMoney: Int
    
    //Int(CoreDataManager.coreDM.readUser()[0].accumulateCoin)
    
    @Binding var presentClothes: String
    @Binding var clothes: [String]
    @Binding var characterEmotion: String
    
    
    @State var buttonIsActiveArray = [false, false, false, false, false]
    
    @State private var alertShowing: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                CoinComponent(money: $userMoney, color: Color.theme.green1)
                
                ZStack {
                    VStack {
                        Ellipse()
                            .frame(width: 208, height: 38)
                            .foregroundColor(Color.theme.green1)
                    }
                    .frame(maxHeight: 208, alignment: .bottom)
                    ZStack {
                        Image("\(characterEmotion)_Hedge")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 208, height: 207)
                        Image("\(presentClothes)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 208, height: 207)
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 13.5, trailing: 0))
            Spacer()
            
            ScrollView {
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
                                presentClothes = "palleteSet"
                            })
                        .disabled(clothes.contains("palleteSet") ? false : cantBuyItemDisable(userMoney: userMoney, price: 1500))
                        
                        Spacer()
                        
                        StoreProductButton(
                            isActive: buttonIsActiveArray[1],
                            color: canBuyItemColor(userMoney: userMoney, price: 2000),
                            isOwnItem: checkOwnItem(itemName: "drum"),
                            money: 2000,
                            imageName: "drum",
                            action: {
                                buttonActive(index: 1)
                                presentClothes = "drum"
                            })
                        .disabled(clothes.contains("drum") ? false : cantBuyItemDisable(userMoney: userMoney, price: 2000))
                        
                        Spacer()
                        
                        StoreProductButton(
                            isActive: buttonIsActiveArray[2],
                            color: canBuyItemColor(userMoney: userMoney, price: 1200),
                            isOwnItem: checkOwnItem(itemName: "books"),
                            money: 1200,
                            imageName: "books",
                            action: {
                                buttonActive(index: 2)
                                presentClothes = "books"
                            })
                        .disabled(clothes.contains("books") ? false : cantBuyItemDisable(userMoney: userMoney, price: 1200))
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 13.5, trailing: 10))
                    
                    HStack(alignment: .top, spacing: 0) {
                        StoreProductButton(
                            isActive: buttonIsActiveArray[3],
                            color: canBuyItemColor(userMoney: userMoney, price: 1700),
                            isOwnItem: checkOwnItem(itemName: "trainingTools"),
                            money: 1700,
                            imageName: "trainingTools",
                            action: {
                                buttonActive(index: 3)
                                presentClothes = "trainingTools"
                            })
                        .disabled(clothes.contains("trainingTools") ? false : cantBuyItemDisable(userMoney: userMoney, price: 1700))
                        
                        Spacer()
                        
                        StoreProductButton(isActive: buttonIsActiveArray[4], color: canBuyItemColor(userMoney: userMoney, price: 1500), isOwnItem: checkOwnItem(itemName: "macbook"), money: 1500, imageName: "macbook", action: {
                            buttonActive(index: 4)
                            presentClothes = "macbook"
                        })
                        .disabled(clothes.contains("macbook") ? false : cantBuyItemDisable(userMoney: userMoney, price: 1500))
                        
                        Spacer()
                        
                        ButtonComponent(buttonType: .storeReadyForSaleButton, content: "준비중입니다", isActive: false, action: {
                            
                        })
                    }
                    .padding(EdgeInsets(top: 13.5, leading: 10, bottom: 10, trailing: 10))
                    
                }
                .padding(EdgeInsets(top: 13.5, leading: 20, bottom: 14, trailing: 20))
            }
            .padding(.horizontal, 20)
            .scrollIndicators(.hidden)
            .border(Color.theme.gray1, width: 5)
            .cornerRadius(8)
            
            Spacer()
            
            ButtonComponent(buttonType: .nextButton, content: "저장하기", isActive: true, action: {
                if clothes.contains(presentClothes) {
                    print("clothes를 가지고 있을 경우")
                    CoreDataManager.coreDM.updateCharacterClothes(presentClothes)
                    dismiss()
                } else {
                    alertShowing.toggle()
                }
            })
            .alert("정말 구매하실건가요?", isPresented: $alertShowing) {
                Button("취소") {
                    
                }
                Button("확인") {
                    print("확인 내부")
                    clothes.append(presentClothes)
                    CoreDataManager.coreDM.updateCharacterClothes(presentClothes)
                    CoreDataManager.coreDM.updateCharacterPresentClothes(presentClothes)
                    payCoin(buyItem: presentClothes)
                    
                    dismiss()
                }
                
            } message: {
                Text("확인 버튼을 누르면 행복코인으로 아이템을 구매합니다.")
                    .textFontAndColor(.body4)
            }
            .padding(EdgeInsets(top: 14, leading: 40, bottom: 0, trailing: 40))
        }
        .padding(EdgeInsets(top: 30, leading: 0, bottom: 20, trailing: 0))
        .onAppear {
            print(presentClothes)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .onDisappear {
            let isBuying = clothes.contains(presentClothes)
            if !isBuying {
                presentClothes = CoreDataManager.coreDM.readCharacter()[0].presentClothes ?? ""
            }
            
        }
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
    
    func payCoin(buyItem: String) {
        switch presentClothes {
        case "palleteSet":
            userMoney -= 1500
            CoreDataManager.coreDM.updateCoin(-1500)
        case "drum":
            userMoney -= 2000
            CoreDataManager.coreDM.updateCoin(-2000)
        case "books":
            userMoney -= 1200
            CoreDataManager.coreDM.updateCoin(-1200)
        case "trainingTools":
            userMoney -= 1700
            CoreDataManager.coreDM.updateCoin(-1700)
        case "macbook":
            userMoney -= 1500
            CoreDataManager.coreDM.updateCoin(-1500)
        default:
            print("없는 상품입니다.")
        }
    }
    
    /**
     사용자가 해당 아이템을 가지고 있는지 확인하는 메서드
     */
    func checkOwnItem(itemName: String) -> Bool {
        // TODO: 코어데이터의 데이터 값과 비교하여, 데이터가 있으면 true, 아니면 false
        return clothes.contains(itemName)
    }
}

//struct StoreView_Previewer: PreviewProvider {
//
//    static var previews: some View {
//        StoreView(presentClothes: <#Binding<String>#>, characterEmotion: <#Binding<String>#>)
//    }
//}
