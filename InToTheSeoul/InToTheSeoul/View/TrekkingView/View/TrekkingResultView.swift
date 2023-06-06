//
//  TrekkingResultView.swift
//  InToTheSeoul
//
//  Created by KimTaeHyung on 2023/06/06.
//

import SwiftUI

struct TrekkingResultView: View {

    @State var height: CGFloat = 400
    
    @State var isRecordViewPresented = false
    
    let minHeight: CGFloat = 80
    let maxHeight: CGFloat = 400
    var percentage: Double {
        Double(height / maxHeight)
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
        .onChanged { val in
            
            var newHeight = height - val.translation.height
            
            if newHeight > maxHeight {
                newHeight = maxHeight
            }
            else if newHeight < minHeight {
                newHeight = minHeight
            }
            height = newHeight
            
        }
        .onEnded { val in
            let percentage = height / maxHeight
            var finalHeight = maxHeight
            
            if percentage < 0.45 {
                finalHeight = minHeight
            }
            withAnimation(Animation.easeOut(duration: 0.3)) {
                height = finalHeight
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            //Handle
            ZStack {
                Capsule()
                    .foregroundColor(Color.theme.gray3)
                    .frame(width: 120, height: 10)
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .gesture(dragGesture)

            Group {
                VStack {
                    HStack(spacing: 0) {
                        
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
            
            NavigationLink(destination: MyRecordView(), isActive: $isRecordViewPresented) {
                ButtonComponent(buttonType: .nextButton, content: "산책 기록 보기", isActive: true, action: {
                    isRecordViewPresented = true
                })
            }
            
            Spacer()
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
            )
            .opacity(1.5 * (percentage - 0.3))
        }
        .padding(.leading, 40)
        .padding(.trailing, 40)
        .frame(maxWidth: .infinity)
        .frame(height: height, alignment: .top)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
    
}

struct TrekkingResultView_Previews: PreviewProvider {
    static var previews: some View {
        TrekkingResultView()
    }
}
