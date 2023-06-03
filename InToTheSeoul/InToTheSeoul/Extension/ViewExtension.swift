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
