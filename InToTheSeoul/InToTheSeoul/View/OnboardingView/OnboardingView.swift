//
//  OnboardingView.swift
//  InToTheSeoul
//
//  Created by 정승균 on 2023/06/05.
//

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)

        webView.scrollView.isScrollEnabled = false

        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

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
                GifImage("Onboarding_1")
                    
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 322)
                    .tag(0)
                GifImage("Onboarding_2")
                    
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 322)
                    .tag(1)
                GifImage("Onboarding_3")
                    
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 322)
                    .tag(2)
                GifImage("Onboarding_4")
                    
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 322)
                    .tag(3)
                
                Image("Onboarding_5")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 280)
                    .tag(4)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .accentColor(.black) // 인디케이터 점의 색상을 까만색으로 설정
            
            
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
