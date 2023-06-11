//
//  CustomBackButton.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/08.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 0) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.theme.green1)
                
                Text("뒤로")
                    .foregroundColor(Color.theme.green1)
                    .padding(5)
            }
        }
    }
}

struct CustomBackButton_Preview: PreviewProvider {
    static var previews: some View {
        CustomBackButton()
    }
}
