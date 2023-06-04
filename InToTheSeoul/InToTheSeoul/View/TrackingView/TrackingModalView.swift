//
//  TrackingModalView.swift
//  InToTheSeoul
//
//  Created by KimTaeHyung on 2023/06/04.
//

import SwiftUI

struct TrackingModalView: View {
    
    @State var height: CGFloat = 60
    let minHeight: CGFloat = 60
    let maxHeight: CGFloat = 400
    var percentage: Double {
        Double(height / maxHeight)
    }
    
    var body: some View {

        VStack(spacing: 0) {
            
            //Handle
            ZStack {
                Capsule()
                    .foregroundColor(Color.theme.gray3)
                    .frame(width: 120, height: 10)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .gesture(dragGesture)
            
            VStack {
                Text("Hello World")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
            )
            .padding(.all, 20)
            .opacity(1.5 * (percentage - 0.3))
        }
        .frame(maxWidth: .infinity)
        .frame(height: height, alignment: .top)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
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
}


struct TrackingModalView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingModalView()
    }
}
