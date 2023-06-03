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
}

/**
 Button들의 래퍼
 
 
 // Parameters
 
 buttonType: 버튼의 종류(genderButton, miniButton, nextButton, mainViewButton)
 content: 버튼 안에 쓰일 텍스트
 isTapped: 버튼이 눌리면 변화되는 Bool. false이면 선택되지 않은 상태의 UI가 표현된다.
 imageName: mainViewButton에서만 필요한 것으로, 버튼안에 표시될 심볼의 String을 입력한다.
 */
struct ButtonComponent: View {
    var buttonType: ButtonType
    let content: String
    var isTapped: Bool
    var imageName: String = ""
    let action: () -> Void
    
    
    var body: some View {
        switch buttonType {
        case .genderButton:
            GenderButton(isTapped: isTapped, content: content, action: action)
        case .mainViewButton:
            MainViewButton(isTapped: isTapped, imageName: imageName, content: content, action: action)
        case .miniButton:
            MiniButton(isTapped: isTapped, content: content, action: action)
        case .nextButton:
            NextButton(isTapped: isTapped, content: content, action: action)
        }
    }
}

extension ButtonComponent {
    
    struct GenderButton: View {
        var isTapped: Bool
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
            .background(isTapped ? Color.theme.white : Color.theme.gray1)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isTapped ? Color.theme.green1 : Color.white.opacity(1), lineWidth: 3)
            )
        }
    }
    
    struct MainViewButton: View {
        var isTapped: Bool
        let imageName: String
        let content: String
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                VStack(spacing: 0) {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 41)
                        .foregroundColor(isTapped ? Color.theme.white : Color.theme.yellow)
                        .padding(8)
                    Text(content)
                        .font(Font.seoul(.body6))
                        .foregroundColor(isTapped ? Color.theme.white : Color.theme.gray4)
                        .padding(8)
                }
            }
            .frame(width: 138, height: 159)
            .background(isTapped ? Color.theme.yellow : Color.theme.white)
            .cornerRadius(30)
            .shadow(color: Color.theme.shadow, radius: 3, y: 4)
        }
    }
    
    struct MiniButton: View {
        var isTapped: Bool
        let content: String
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Text(content)
                    .frame(width: 93, height: 45)
                    .font(Font.seoul(.body6))
                    .foregroundColor(isTapped ? Color.theme.white : Color.theme.gray4)
                    
            }
            .background(isTapped ? Color.theme.green1 : Color.theme.gray1)
            .cornerRadius(12)
        }
    }

    struct NextButton: View {
        var isTapped: Bool
        let content: String
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Text(content)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .font(Font.seoul(.button1))
                    .foregroundColor(Color.theme.white)
                
            }
            .background(isTapped ? Color.theme.green1 : Color.theme.gray3)
            .cornerRadius(30)
            
        }
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
            ButtonComponent(buttonType: .genderButton, content: "시험용", isTapped: false, action: {
                
            })
            ButtonComponent(buttonType: .miniButton, content: "시험용", isTapped: false, action: {
                
            })
            ButtonComponent(buttonType: .nextButton, content: "시험용", isTapped: false, action: {
                
            })
            ButtonComponent(buttonType: .mainViewButton, content: "산책\n시작하기", isTapped: false, imageName: "figure.walk", action: {
                
            })
        }
    }
}

