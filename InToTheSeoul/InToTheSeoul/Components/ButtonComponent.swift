//
//  ButtonComponent.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/03.
//
import SwiftUI

// TODO: 짧은 버튼, 긴 버튼, Disable 여부, 정사각형 버튼 대응 필요

/**
 genderButton : 정보 수집에서 성별 선택하는 버튼
 miniButton : 정보 수집 or 어떤 산책? 뷰에서 나이대 또는 가고 싶은 곳 선택하는 버튼
 nextButton : 모든 뷰에서 하단의 긴 버튼
 mainViewButton : 산책 시작하기 or 산책 기록하기 버튼
 */
enum ButtonType {
    case genderButton
    case miniButton
    case nextButton
    case mainViewButton
    case storeReadyForSaleButton
}

/**
 Button들의 래퍼
 
 
 // Parameters
 
 buttonType: 버튼의 종류(genderButton, miniButton, nextButton, mainViewButton)
 content: 버튼 안에 쓰일 텍스트
 isActive: 버튼이 눌리면 변화되는 Bool. false이면 선택되지 않은 상태의 UI가 표현된다.
 imageName: mainViewButton에서만 필요한 것으로, 버튼안에 표시될 심볼의 String을 입력한다.
 */
struct ButtonComponent: View {
    var buttonType: ButtonType
    var content: String = ""
    var isActive: Bool
    var imageName: String = ""
    let action: () -> Void
    
    var body: some View {
        switch buttonType {
        case .genderButton:
            GenderButton(isActive: isActive, content: content, action: action)
        case .mainViewButton:
            MainViewButton(isActive: isActive, imageName: imageName, content: content, action: action)
        case .miniButton:
            MiniButton(isActive: isActive, content: content, action: action)
        case .nextButton:
            NextButton(isActive: isActive, content: content, action: action)
        case .storeReadyForSaleButton:
            StoreReadyForSaleButton(isActive: isActive, content: content, action: action)
        }
    }
}


struct GenderButton: View {
    var isActive: Bool
    let content: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            // padding을 정확히 주기 위해 spacing을 0으로 처리한다.
            VStack(spacing: 0) {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 49, height: 52)
                    .foregroundColor(Color.theme.gray3)
                    .padding(9)
                Text(content)
                    .font(Font.seoul(.body6))
                    .foregroundColor(Color.theme.gray4)
                    .padding(9)
            }
        }
        .frame(width: 138, height: 140)
        .background(isActive ? Color.theme.white : Color.theme.gray1)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isActive ? Color.theme.green1 : Color.white.opacity(1), lineWidth: 3)
        )
    }
}

struct MainViewButton: View {
    var isActive: Bool
    let imageName: String
    let content: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 60)
                    .foregroundColor(Color.theme.white)
                    .padding(16)
                Text(content)
                    .textFontAndColor(.h8)
            }
        }
        .frame(width: 138, height: 159)
        .background(Color.theme.white)
        .cornerRadius(20)
        .shadow(color: Color.theme.shadow, radius: 3, y: 4)
    }
}

struct MiniButton: View {
    var isActive: Bool
    let content: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(content)
                .frame(width: 93, height: 45)
                .font(Font.seoul(.body6))
                .foregroundColor(isActive ? Color.theme.white : Color.theme.gray4)
            
        }
        .background(isActive ? Color.theme.green1 : Color.theme.gray1)
        .cornerRadius(12)
    }
}

struct NextButton: View {
    var isActive: Bool
    let content: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(content)
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .textFontAndColor(.button1)
            
        }
        .background(isActive ? Color.theme.green1 : Color.theme.gray3)
        .cornerRadius(30)
        
    }
}

/**
 ButtonCompont 객체로 부를 수 없음.
 money: 보여질 돈(Int)
 color: 보여질 background 색상(Color)
 */
struct StoreProductButton: View {
    var isActive: Bool
    var color: Color
    var isOwnItem: Bool
    let money: Int
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Button(action: action) {
                    ZStack {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 49, height: 52)
                        
                        
                    }
                }
                .frame(width: 94, height: 103)
                .background(Color.theme.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isActive ? Color.theme.yellow : Color.theme.gray3, lineWidth: 3)
                )
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
                if isActive {
                    VStack(spacing: 0) {
                        Image("check")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 94, height: 103, alignment: .topTrailing)
                }
                
                
            }
            if isOwnItem {
                Text("보유중")
                    .font(Font.seoul(.coin))
                    .foregroundColor(Color.theme.yellow)
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
            } else {
                CoinComponent(money: money, color: color)
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}


struct StoreReadyForSaleButton: View {
    var isActive: Bool
    let content: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            // padding을 정확히 주기 위해 spacing을 0으로 처리한다.
            VStack(spacing: 0) {
                Text("준비중\n입니다")
                    .textFontAndColor(.body3)
            }
        }
        .frame(width: 94, height: 103)
        .background(Color.theme.gray1)
        .cornerRadius(20)
        .disabled(true)
    }
}


struct ButtonComponent_Previews: PreviewProvider {
    enum ButtonType {
        case genderButton
        case miniButton
        case nextButton
        case mainViewButton
    }
    
    static var previews: some View {
        VStack {
            ButtonComponent(buttonType: .genderButton, content: "시험용", isActive: false, action: {
                
            })
            ButtonComponent(buttonType: .miniButton, content: "시험용", isActive: false, action: {
                
            })
            ButtonComponent(buttonType: .nextButton, content: "시험용", isActive: false, action: {
                
            })
            ButtonComponent(buttonType: .mainViewButton, content: "산책하기", isActive: false, imageName: "figure.walk", action: {
                
            })
            ButtonComponent(buttonType: .storeReadyForSaleButton, isActive: false, imageName: "palleteSet", action: {
                
            })
            StoreProductButton(isActive: false, color: Color.theme.yellow, isOwnItem: true , money: 1800, imageName: "palleteSet", action: {
                
            })
        }
    }
    
}
