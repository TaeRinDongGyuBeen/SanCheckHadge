//
//  ViewExtension.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/03.
//

import Foundation
import SwiftUI

extension View {
    
    /// TextField의 디자인을 View와 ViewModifier를 활용한 함수로 구현
    ///
    ///  - parameters:
    ///     - color : TextField의 테두리 색
    ///     - padding :  내용과 테두리 사이의 간격
    ///     - lineWidth : TextField의 선 굵기
    ///     - cornerRadius : 테두리 둥글기 정도
    ///
    ///
    func customTextField(color: Color = Color.theme.gray2, padding: CGFloat = 3, lineWidth: CGFloat = 1, cornerRadius: CGFloat = 8) -> some View {
        self.modifier(TextfieldModifier(color: color, padding: padding, lineWidth: lineWidth, cornerRadius: cornerRadius))
    }
    
    /// Bool을 통해 View의 Hidden 속성 제어
    ///
    ///  - parameters:
    ///     - isTrue : Hidden 조건
    ///
    ///
    func hideToBool(_ isTrue: Bool) -> some View {
        self.modifier(ViewHideModifier(isTrue: isTrue))
    }
    
    /**
     기본 폰트로 적용된 modifier
     */
    func textFontAndColor(_ font: Font.SeoulFont) -> some View {
        self.modifier(FontAndColorModifier(font: font))
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
                .foregroundColor(Color.theme.yellow)
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

struct TextfieldModifier: ViewModifier {
    let color: Color
    let padding: CGFloat
    let lineWidth: CGFloat
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: lineWidth)
            )
            .disableAutocorrection(true) // 자동 수정 방지 수정자
            .textInputAutocapitalization(.never)
            
    }
}

struct ViewHideModifier: ViewModifier {
    let isTrue: Bool
    
    func body(content: Content) -> some View {
        if isTrue {
            content
                .hidden()
        } else {
            content
        }
    }
}
