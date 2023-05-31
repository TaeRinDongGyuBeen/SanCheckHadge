//
//  WalkingMapView.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/05/31.
//

import SwiftUI
import MapKit

struct WalkingMapView: View {
    // 현재 위치를 나타내주는 @State 변수. Map()의 파라미터의 Binding으로 사용됨.
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.4025,
            longitude: 127.1013),
        span: MKCoordinateSpan(
            latitudeDelta: 0.03,
            longitudeDelta: 0.03
        )
    )
    @State private var userTrackingMode: MapUserTrackingMode = .none
    @State private var locationManager = CLLocationManager()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Map(coordinateRegion: $region, interactionModes: MapInteractionModes.all, showsUserLocation: true, userTrackingMode: $userTrackingMode)
                    
                    .edgesIgnoringSafeArea(.all)
                
                Button(action: {
                    userTrackingMode = .follow
                    // 정확도 설정 - 최고로 높은 정확도
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    requestLocationPermission()
                    // 위치 업데이트 시작
                    locationManager.startUpdatingLocation()
                }) {
                    Image(systemName: "location.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 13, height: geometry.size.height / 13)
                        .foregroundColor(.blue)
                        .position(x: geometry.size.width - 40, y: geometry.size.height / 1.2)
                }
            }
            .onAppear {
                checkLocationPermission()
            }
        }
    }
    
    /**
     위치 권한 획득 여부 체크 메서드
     */
    func checkLocationPermission() {
        let status = locationManager.authorizationStatus
        if status == .denied || status == .restricted {
            // 위치 권한이 거부되었거나 제한되었음을 사용자에게 알리는 알림 표시
        }
    }
    
    /**
     위치 권한이 없을 경우 권한을 요청하는 메서드.
     */
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
}

struct WalkingMapView_Previews: PreviewProvider {
    static var previews: some View {
        WalkingMapView()
    }
}
