//
//  MainView.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/04.
//
import SwiftUI

struct MainView: View {
    @State var userMoney: Int = Int(CoreDataManager.coreDM.readUser()[0].accumulateCoin)
    @State var username: String = (CoreDataManager.coreDM.readUser()[0].username ?? "태린동규빈")
    @State var userAccumulateDistance = (CoreDataManager.coreDM.readUser()[0].accumulateDistance)
    
    @State var showTimeDestination = false
    @State var showTrakingDestination = false
    @EnvironmentObject var pointsModel: PointsModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    CoinComponent(money: userMoney, color: Color.theme.green1)
                    
                    Spacer()
                    NavigationLink(destination: {
                        StoreView()
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
                        .frame(alignment: .bottom)
                    Text("님, 안녕하세요!")
                        .textFontAndColor(.body1)
                        .frame(maxHeight: 30, alignment: .bottom)
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
                        Text("\(userAccumulateDistance, specifier: "%.2f")km")
                            .foregroundColor(Color.theme.gray5)
                            .font(Font.seoul(.body6))
                        
                    }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                
                HStack(spacing: 0) {
                    ButtonComponent(buttonType: .mainViewButton, content: "산책하기", isActive: false, imageName: "walkingStartButton", action: {
                        showTrakingDestination = true
                    })
                    
                    NavigationLink(destination: TrekkingInformationInput(), isActive: $showTrakingDestination) {
                        
                    }
                    .hidden()
                    
                    Spacer()
                    
                    ButtonComponent(buttonType: .mainViewButton, content: "기록보기", isActive: false, imageName: "recordCheckButton", action: {
                        showTimeDestination = true
                    })
                    
                    NavigationLink(destination: TimelineView(), isActive: $showTimeDestination) {
                        
                    }
                    .hidden()
                    
                    
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 40, bottom: 40, trailing: 40))
        }
    }
    
}

struct MainView_Previewer: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
