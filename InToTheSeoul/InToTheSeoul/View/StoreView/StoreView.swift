//
//  StoreView.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/04.
//

import SwiftUI

struct StoreView: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Ellipse
                    .Body(shape: Ellipse(), style: ForegroundStyle())
                Image("storeCharacter")
            }
        }
    }
}

struct StoreView_Previewer: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
