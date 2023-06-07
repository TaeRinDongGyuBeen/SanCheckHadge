//
//  OnboardingView.swift
//  InToTheSeoul
//
//  Created by 정승균 on 2023/06/05.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isFirstLaunch: Bool
    @State var selection: Int = 0
    @State var isStart: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button("건너뛰기") {
                    // Skip
                    isStart.toggle()
                }
                .textFontAndColor(.h5)
            }
            .padding(.bottom, 18)
            
            Spacer()
            
            TabView(selection: $selection) {
                RoundedRectangle(cornerRadius: 20)
                    .tag(0)
                RoundedRectangle(cornerRadius: 20)
                    .tag(1)
                RoundedRectangle(cornerRadius: 20)
                    .tag(2)
            }
            .tabViewStyle(.page)
            
            ButtonComponent(buttonType: .nextButton, content: selection == 2 ? "시작하기" : "다음 페이지 넘어가기", isActive: true) {
                if selection < 2 {
                    withAnimation {
                        selection += 1
                    }
                } else {
                    isStart.toggle()
                }
            }
            .padding(.top, 25)
            .padding(.bottom, 25)
        }
        .fullScreenCover(isPresented: $isStart, content: {
            NavigationStack {
                DataReceiveView(isFirstLaunch: $isFirstLaunch)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("취소") {
                                isStart.toggle()
                            }
                            .foregroundColor(.theme.green2)
                        }
                    }
            }
        })
        .padding(.horizontal, 26)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    @State static var isFirst = true
    
    static var previews: some View {
        OnboardingView(isFirstLaunch: $isFirst)
    }
}
