//
//  MyRecordView.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/05.
//

import SwiftUI

struct MyRecordView: View {
    
    // 내 기록보기에서 버튼을 감추기 위한 변수
    @State var buttonUse: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer(minLength: 30)
            Group {
                Text("(날짜)의 기록")
                    .textFontAndColor(.h1)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                Text("포기하지 않고 끝까지 완주하신 것을 축하드려요!")
                    .textFontAndColor(.h2)
            }
            Spacer(minLength: 40)
            Group {
                HStack(spacing: 0) {
                    Text("산책 경로")
                        .textFontAndColor(.h3)
                    Text("(경로 숫자)개의 포인트를 달성했어요!")
                        .textFontAndColor(.h4)
                        .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 0))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 0) {
                    Image("storeCharacter")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                    Spacer()
                    ScrollView {
                        
                    }
                    .frame(maxWidth: 140, maxHeight: 160)
                    
                    .background(.black)
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            }
            Spacer(minLength: 40)
            Group {
                VStack {
                    HStack(spacing: 0) {
                        Text("산책 요약")
                            .textFontAndColor(.h3)
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                        
                        Image("congreteCharacter")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 108, height: 78)
                    }
                    .frame(maxHeight: 78)
                    
                    ZStack {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 108)
                            .cornerRadius(12)
                            .foregroundColor(Color.theme.gray1)
                        
                        HStack {
                            VStack(spacing: 0) {
                                Text("산책 거리")
                                    .textFontAndColor(.body3)
                                Spacer()
                                HStack(alignment: .bottom, spacing: 0) {
                                    Text("거리")
                                        .textFontAndColor(.body4)
                                    
                                    Text("km")
                                        .textFontAndColor(.h5)
                                }
                                
                                
                            }
                            Spacer()
                            VStack(spacing: 0) {
                                Text("산책 시간")
                                    .textFontAndColor(.body3)
                                Spacer()
                                HStack(alignment: .bottom, spacing: 0) {
                                    Text("시간")
                                        .textFontAndColor(.body4)
                                    Text("분")
                                        .textFontAndColor(.h5)
                                }
                                .frame(maxHeight: .infinity, alignment: .bottom)
                            }
                            
                            
                        }
                        .frame(maxHeight: 59)
                        .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 60))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                }
                .frame(maxHeight: 164)
            }
            
            Group {
                Spacer(minLength: 14)
                Image("underTriangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                Spacer(minLength: 18)
                HStack(spacing: 0) {
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundColor(Color.theme.yellow)
                    Spacer()
                    Text("NN")
                        .textFontAndColor(.body5)
                    Spacer()
                    Text("획득")
                        .textFontAndColor(.h5)
                }
                .frame(maxWidth: 118)
            }
            
            Spacer(minLength: 41)
            if buttonUse {
                ButtonComponent(buttonType: .nextButton, content: "기록 저장하기",isActive: true, action: {
                    
                })
                
            }
            
        }
        .padding(EdgeInsets(top: 0, leading: 40, bottom: 20, trailing: 40))
    }
    
}

struct MyRecordView_Previewer: PreviewProvider {
    static var previews: some View {
        MyRecordView()
    }
}
