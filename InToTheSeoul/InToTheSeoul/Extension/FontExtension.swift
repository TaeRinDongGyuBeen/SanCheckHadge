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
        case h1
        case h2
        case h3
        case h4
        case h5
        case h6
        case h7
        case h8
        case body1
        case body2
        case body3
        case body4
        case body5
        case body6
        case body7
        case button1
        case button2
        case coin
        
        var customStyle: TextStyle {
            switch self {
            case .h1:
                return .title2
            case .h2:
                return .footnote
            case .h3:
                return .headline
            case .h4:
                return .caption2
            case .h5:
                return .footnote
            case .h6:
                return .footnote
            case .h7:
                return .largeTitle
            case .h8:
                return .title3
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
                return .headline
            case .button2:
                return .caption2
            case .coin:
                return .body


            }
        }
        
        var customWeight: Weight {
            switch self {
            case .h1:
                return .bold
            case .h2:
                return .regular
            case .h3:
                return .bold
            case .h4:
                return .regular
            case .h5:
                return .bold
            case .h6:
                return .regular
            case .h7:
                return .bold
            case .h8:
                return .bold
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
                return .regular
            case .coin:
                return .bold
            }
        }
    }

    static func seoul(_ type: SeoulFont) -> Font {
        return .system(type.customStyle, weight: type.customWeight)
    }
}
