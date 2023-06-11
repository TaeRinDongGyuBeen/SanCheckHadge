//
//  Point.swift
//  InToTheSeoul
//
//  Created by 정승균 on 2023/06/04.
//

import Foundation
import CoreLocation
import MapKit

struct Point: Hashable, Codable, Identifiable {
    var name: String
    var lat: String
    var lon: String
    var category: String
    var address: String
    var id: Int
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: Double(lat) ?? 0.0, longitude: Double(lon) ?? 0.0)
    }
}

struct ViewPoint: Hashable, Codable, Identifiable {
    var id: Int
    var mustWaypoint: Bool = false
    var isVisited: Bool = false
    var isStartPoint: Bool = false
    var distanceNextPoint: Double = 0
    var nowPoint: Point
}

class AnnotationPoint: NSObject, MKAnnotation, ObservableObject {
    var coordinate: CLLocationCoordinate2D
    @Published var viewPoint: ViewPoint
    
    var annotationStyle: AnnotationStyle {
        if viewPoint.isStartPoint {
           return .start
        } else {
            if viewPoint.isVisited {
                return .visited
            } else {
                return .toVisit
            }
        }
    }
    
    init(viewPoint: ViewPoint) {
        self.viewPoint = viewPoint
        self.coordinate = viewPoint.nowPoint.locationCoordinate
    }
    
}

// enum 생성
// 가고자하는 방향성
// NE, NW, SW, SE
enum ForwardDirection {
    case NE
    case NW
    case SW
    case SE
}

// 방향 전환 경우의 수
enum DirectionCount: Double {
    case first = 0.7
    case second = 0.4
    case last = 0.0
}

enum RecommendError: Error {
    case pointNotFound
}
