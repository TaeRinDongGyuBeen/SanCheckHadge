//
//  ColorExtension.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/03.
//
import SwiftUI

extension Color {
    /// Assets에 추가한 색상 사용하기 편하도록 extenstion 구현
    /// ```
    /// Ex)
    /// Text("Red Color")
    ///     .foregroundColor(Color.theme.red)
    /// ```
    static let theme = ColorTheme()
}

struct ColorTheme {
    let white = Color("White")
    let gray1 = Color("Gray1")
    let gray2 = Color("Gray2")
    let gray3 = Color("Gray3")
    let gray4 = Color("Gray4")
    let gray5 = Color("Gray5")
    let black = Color("Black")
    let green1 = Color("Green1")
    let green2 = Color("Green2")
    let green3 = Color("Green3")
    let red = Color("Red")
    let yellow = Color("Yellow")
    let shadow = Color("Shadow")
}
