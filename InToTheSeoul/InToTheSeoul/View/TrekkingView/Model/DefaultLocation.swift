//
//  DefaultLocation.swift
//  InToTheSeoul
//
//  Created by KimTaeHyung on 2023/06/05.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

//MARK: - Default Map Location

enum DefaultLocation {
    static var startingLocation = CLLocationCoordinate2D(latitude: 37.566535, longitude: 126.9779692)
    static var defaultSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
}
