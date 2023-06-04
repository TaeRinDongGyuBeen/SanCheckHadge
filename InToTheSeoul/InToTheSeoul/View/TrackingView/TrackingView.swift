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

