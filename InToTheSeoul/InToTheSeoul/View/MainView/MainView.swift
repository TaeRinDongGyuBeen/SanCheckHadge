//
//  MainView.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/04.
//
import SwiftUI

struct MainView: View {
    @State var userMoney: Int = 0
    @State var username: String = "태린동규빈"
    @State var userAccumulateDistance = 24
    var body: some View {
            VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    CoinComponent(money: userMoney, color: Color.theme.green1)
                    
                    Spacer()
                    NavigationLink(destination: {
                        
                    }, label: {
                        Image("storeButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 39, height: 23)
                    })
                }
                
                Spacer()
                
                HStack(spacing: 0) {
                    Text(username)
                        .textFontAndColor(.h7)
                    Text("님, 안녕하세요!")
                        .textFontAndColor(.body1)
                }
                
                Spacer()
                
                VStack {
                    ZStack {
                        VStack {
                            Ellipse()
                                .frame(width: 257, height: 47)
                                .foregroundColor(Color.theme.gray3)
                        }
                        .frame(maxHeight: 245, alignment: .bottom)
                        Image("storeCharacter")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 189, height: 207)
                    }
                }
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .cornerRadius(12)
                        .foregroundColor(Color.theme.yellow)
                    HStack {
                        Text("총 누적 산책거리")
                            .textFontAndColor(.body1)
                        Spacer()
                        Text("\(userAccumulateDistance)km")
                            .foregroundColor(Color.theme.gray5)
                            .font(Font.seoul(.body6))
                        
                    }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                
                HStack(spacing: 0) {
                    ButtonComponent(buttonType: .mainViewButton, content: "산책하기", isActive: false, imageName: "", action: {
                        
                    })
                    
                    Spacer()
                    
                    ButtonComponent(buttonType: .mainViewButton, content: "기록보기", isActive: false, imageName: "", action: {
                        
                    })
                }
            }
            .padding(EdgeInsets(top: 0, leading: 40, bottom: 40, trailing: 40))
        }
}

struct MainView_Previewer: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
