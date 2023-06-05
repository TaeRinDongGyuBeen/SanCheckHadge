//
//  TrackingView.swift
//  InToTheSeoul
//
//  Created by KimTaeHyung on 2023/06/04.
//

import SwiftUI
import MapKit
import CoreLocation

struct TrackingView: View {
    
    var body: some View {
        ZStack {
            VStack {
                MapView()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            
            //MARK: - 모달 뷰
            VStack(alignment: .trailing) {
                Button(action: {
                    
                }, label: {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 40)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 0.3)
                            )
                            .shadow(radius: 3, x: 0, y: 2)
                        Image(systemName: "scope")
                            .foregroundColor(.black)
                    }

                })
                .padding()
                TrackingModalView()
                    .shadow(radius: 10)
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

