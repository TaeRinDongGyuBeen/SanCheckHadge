//
//  TrackingView.swift
//  InToTheSeoul
//
//  Created by KimTaeHyung on 2023/06/04.
//

import SwiftUI
import MapKit

struct TrackingView: View {
    
    var body: some View {
        ZStack {
            VStack {
                Text("MapKit")
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
            .ignoresSafeArea()
            
            //MARK: - 모달 뷰
            VStack() {
                TrackingModalView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

struct TrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingView()
    }
}



//MARK: - TrackingModalView로 옮길 것들

struct TrackingModalView: View {
    
    @State var modalHeight: CGFloat = 100
    let minModalHeight: CGFloat = 100
    let maxModalHeight: CGFloat = 500
    
    var body: some View {
        VStack {
            
            //Handle
            ZStack {
                Capsule()
                    .foregroundColor(Color.theme.gray3)
                    .frame(width: 150, height: 10)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .gesture(dragGesture)
            
            
            Text("Hello world")
        }
        .frame(maxWidth: .infinity)
        .frame(height: modalHeight, alignment: .top)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { val in
                var newHeight = modalHeight - val.translation.height
                
                if newHeight > maxModalHeight {
                    newHeight = maxModalHeight
                }
                else if newHeight < minModalHeight {
                    newHeight = minModalHeight
                }
                
                modalHeight = newHeight
                
            }
            .onEnded { val in
                
            }
    }
}

struct TrackingModalView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingModalView()
    }
}
