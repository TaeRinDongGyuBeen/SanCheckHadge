//
//  ProgressView.swift
//  InToTheSeoul
//
//  Created by KimTaeHyung on 2023/06/05.
//

import SwiftUI

struct ProgressView: View {
    @State private var progress: Double = 0.0
    
    var body: some View {
        VStack {
            CustomProgressBar(progress: progress)
                .frame(height: 50)
            
            //MARK: - 계산식 수정 필요
            
            Button("Increase Progress") {
                withAnimation(Animation.linear(duration: 3)) {
                    progress += 0.2
                    
                    if progress >= 1.0 {
                        progress = 0
                    }
                }
                print(progress)
            }
            .padding()
        }
        .padding()
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}


struct CustomProgressBar: View {
    var progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                //가장 큰 캡슐
                Capsule()
                    .opacity(0.85)
                    .foregroundColor(Color.white)
                    .frame(width: geometry.size.width, height: 65)
                
                VStack {
                    HStack {
                        Image("progressHedge")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 27, height: 21)
                            .padding(.top, 7)
                            .offset(x: CGFloat(self.progress) * (geometry.size.width - 20) + 24)
                        Spacer()
                        
                        Image("ProgressPoint")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 21)
                            .padding(.trailing, 27)
                            .padding(.leading, 27)

                        
                    }
                    .padding(.bottom, 0)
                    //실선
                    DashedLine()
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundColor(Color.theme.gray4)
                        .frame(width: geometry.size.width - 60, height: 1)
//                        .padding(.leading, 30)
//                        .padding(.trailing, 30)
                    
                    Text("2.5km · 40분 예상")
                        .textFontAndColor(.h5)
                    
                    Spacer()
                    
                    
                    
                }
//                Capsule()
//                    .foregroundColor(Color.red)
//                    .frame(width: geometry.size.width, height: 10)
                
                
//                Rectangle()
//                    .foregroundColor(.blue)
//                    .frame(width: CGFloat(self.progress) * geometry.size.width, height: 10)
            }
            .cornerRadius(20)
        }
    }
}




struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // 시작점 설정
        let start = CGPoint(x: rect.minX, y: rect.midY)
        
        // 패턴 설정
        let pattern: [CGFloat] = [2, 0] // 4 포인트의 실선과 4 포인트의 공백 패턴
        
        var currentX: CGFloat = start.x
        var shouldDrawLine = true
        
        // 패턴 반복하여 경로 생성
        while currentX < rect.maxX {
            let endX = currentX + pattern.reduce(0, +)
            let endPoint = CGPoint(x: endX, y: start.y)
            
            if shouldDrawLine {
                path.move(to: CGPoint(x: currentX, y: start.y))
                path.addLine(to: endPoint)
            }
            
            currentX = endX
            shouldDrawLine = !shouldDrawLine
        }
        
        return path
    }
}
