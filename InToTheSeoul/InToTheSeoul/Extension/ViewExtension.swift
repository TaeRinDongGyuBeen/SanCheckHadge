//
//  ViewExtension.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/03.
//

import Foundation
import SwiftUI

extension View {

    /**
     기본 폰트로 적용된 modifier
     */
    func textFontAndColor(_ font: Font.SeoulFont) -> some View {
        self.modifier(FontAndColorModifier(font: font))
    }
    
    func isHidden(_ isHidden: Bool) -> some View {
        self.modifier(ViewHideModifier(isHidden: isHidden))
    }
}

struct FontAndColorModifier: ViewModifier {
    let font: Font.SeoulFont
    
    func body(content: Content) -> some View {
        switch font {
        case .h1:
            content
                .font(Font.seoul(.h1))
                .foregroundColor(Color.theme.black)
        case .h2:
            content
                .font(Font.seoul(.h2))
                .foregroundColor(Color.theme.gray5)
        case .h3:
            content
                .font(Font.seoul(.h3))
                .foregroundColor(Color.theme.black)
        case .h4:
            content
                .font(Font.seoul(.h4))
                .foregroundColor(Color.theme.gray4)
        case .h5:
            content
                .font(Font.seoul(.h5))
                .foregroundColor(Color.theme.gray4)
        case .h6:
            content
                .font(Font.seoul(.h6))
                .foregroundColor(Color.theme.white)
        case .h7:
            content
                .font(Font.seoul(.h7))
                .foregroundColor(Color.theme.gray5)
        case .h8:
            content
                .font(Font.seoul(.h8))
                .foregroundColor(Color.theme.green1)
        case .body1:
            content
                .font(Font.seoul(.body1))
                .foregroundColor(Color.theme.gray4)
        case .body2:
            content
                .font(Font.seoul(.body2))
                .foregroundColor(Color.theme.green1)
        case .body3:
            content
                .font(Font.seoul(.body3))
                .foregroundColor(Color.theme.gray4)
        case .body4:
            content
                .font(Font.seoul(.body4))
                .foregroundColor(Color.theme.green1)
        case .body5:
            content
                .font(Font.seoul(.body5))
                .foregroundColor(Color.theme.yellow)
        case .body6:
            content
                .font(Font.seoul(.body6))
                .foregroundColor(Color.theme.gray4)
        case .body7:
            content
                .font(Font.seoul(.body7))
                .foregroundColor(Color.theme.black)
        case .button1:
            content
                .font(Font.seoul(.button1))
                .foregroundColor(Color.theme.white)
        case .button2:
            content
                .font(Font.seoul(.button2))
                .foregroundColor(Color.theme.white)
        case .coin:
            content
                .font(Font.seoul(.coin))
                .foregroundColor(Color.theme.white)
        }

        
    }
}

struct ViewHideModifier: ViewModifier {
    let isHidden: Bool
    
    func body(content: Content) -> some View {
        if isHidden {
            content
                .hidden()
        } else {
            content
        }
    }
}
