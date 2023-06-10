//
//  MapAnnotation.swift
//  InToTheSeoul
//
//  Created by KimTaeHyung on 2023/06/05.
//

import SwiftUI
import MapKit

struct MapAnnotation: View {
    @State var style: AnnotationStyle
    let number: Int
    let annotation: AnnotationPoint
    
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
        case .visited:
            ZStack {
                Image("ReachedPoint")
                    .resizable()
                    .scaledToFit()
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    Text("\(annotation.viewPoint.id + 1)")
                        .font(.headline)
                        .foregroundColor(.theme.green2)
                }
                .padding(.horizontal, 6)
                .padding(.top, 6)
                .padding(.bottom, 18)
            }
            .frame(width: 36, height: 45)
        case .toVisit:
            ZStack {
                Image("WillPoint")
                    .resizable()
                    .scaledToFit()
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    Text("\(annotation.viewPoint.id + 1)")
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
    case visited
    case toVisit
}

//struct MapAnnotation_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            MapAnnotation(style: .start, number: 1)
//            MapAnnotation(style: .visited, number: 1)
//            MapAnnotation(style: .toVisit, number: 1)
//        }
//    }
//}


final class MapAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(annotationStyle: AnnotationStyle, annotationId: Int, annotation: AnnotationPoint) {
        backgroundColor = .clear
        
        let vc = UIHostingController(rootView: MapAnnotation(style: annotationStyle, number: annotationId, annotation: annotation))
        
        vc.view.backgroundColor = .clear
        addSubview(vc.view)

        vc.view.frame = bounds
    }
}
