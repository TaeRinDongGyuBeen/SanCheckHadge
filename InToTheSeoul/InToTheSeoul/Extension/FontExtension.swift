//
//  FontExtension.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/03.
//

import SwiftUI



extension Font {
    /**
     system 폰트를 사용하기에 TextSyle과 FontWeight를 case마다 지정했습니다.
     
     /// 사용예시
     Text("")
        .font(.custom(Font.seoulFont(.headline1))
     
     */
    enum SeoulFont {
        case headline1
        case headline2
        case headline3
        case headline4
        case headline5
        case headline6
        case body1
        case body2
        case body3
        case body4
        case body5
        case body6
        case body7
        case button1
        case button2
        
        var customStyle: TextStyle {
            switch self {
            case .headline1:
                return .title2
            case .headline2:
                return .footnote
            case .headline3:
                return .headline
            case .headline4:
                return .caption2
            case .headline5:
                return .footnote
            case .headline6:
                return .footnote
            case .body1:
                return .body
            case .body2:
                return .title2
            case .body3:
                return .footnote
            case .body4:
                return .title
            case .body5:
                return .title
            case .body6:
                return .headline
            case .body7:
                return .body
            case .button1:
                return .caption2
            case .button2:
                return .body
            }
        }
        
        var customWeight: Weight {
            switch self {
            case .headline1:
                return .bold
            case .headline2:
                return .regular
            case .headline3:
                return .bold
            case .headline4:
                return .regular
            case .headline5:
                return .bold
            case .headline6:
                return .regular
            case .body1:
                return .regular
            case .body2:
                return .bold
            case .body3:
                return .regular
            case .body4:
                return .bold
            case .body5:
                return .bold
            case .body6:
                return .bold
            case .body7:
                return .regular
            case .button1:
                return .bold
            case .button2:
                return .bold
            }
        }
    }

    static func seoul(_ type: SeoulFont) -> Font {
        return .system(type.customStyle, weight: type.customWeight)
    }
}
