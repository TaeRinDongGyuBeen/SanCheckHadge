//
//  Ex+ CLocationCoordinate2D.swift
//  InToTheSeoul
//
//  Created by 정승균 on 2023/06/04.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
        /// Returns distance from coordianate in meters.
        /// - Parameter from: coordinate which will be used as end point.
        /// - Returns: Returns distance in meters.
        func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
            let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
            let to = CLLocation(latitude: self.latitude, longitude: self.longitude)
            return from.distance(from: to)
        }
}
