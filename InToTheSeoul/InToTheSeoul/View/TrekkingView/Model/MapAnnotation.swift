//
//  MapAnnotation.swift
//  InToTheSeoul
//
//  Created by KimTaeHyung on 2023/06/05.
//

import SwiftUI

struct MapAnnotation: View {
    let style: AnnotationStyle
    let number: Int
    
    var body: some View {
        switch style {
        case .start:
            ZStack {
                Image("StartPoint")
                    .resizable()
                    .scaledToFit()
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 10)
                .padding(.top, 9)
                .padding(.bottom, 20)
            }
            .frame(width: 36, height: 45)
        case .arrived:
            ZStack {
                Image("ReachedPoint")
                    .resizable()
                    .scaledToFit()
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    Text("\(number)")
                        .font(.headline)
                        .foregroundColor(.theme.green2)
                }
                .padding(.horizontal, 6)
                .padding(.top, 6)
                .padding(.bottom, 18)
            }
            .frame(width: 36, height: 45)
        case .toGo:
            ZStack {
                Image("WillPoint")
                    .resizable()
                    .scaledToFit()
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    Text("\(number)")
                        .font(.headline)
                        .foregroundColor(.theme.yellow)
                }
                .padding(.horizontal, 6)
                .padding(.top, 6)
                .padding(.bottom, 18)
            }
            .frame(width: 36, height: 45)
        }
    }
}

enum AnnotationStyle {
    case start
    case arrived
    case toGo
}

struct MapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MapAnnotation(style: .start, number: 1)
            MapAnnotation(style: .arrived, number: 1)
            MapAnnotation(style: .toGo, number: 1)
        }
    }
}
