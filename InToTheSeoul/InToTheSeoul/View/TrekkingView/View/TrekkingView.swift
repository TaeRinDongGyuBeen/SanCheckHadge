//
//  TrackingView.swift
//  InToTheSeoul
//
//  Created by KimTaeHyung on 2023/06/04.
//

import SwiftUI
import MapKit
import CoreLocation

struct TrekkingView: View {
    @EnvironmentObject var pointsModel: PointsModel
    
    @State private var showUserLocation = false
    
    @State private var userLocation: CLLocationCoordinate2D?
    
    @State private var region = MKCoordinateRegion(center: DefaultLocation.startingLocation, span: DefaultLocation.defaultSpan)

    @State private var span = DefaultLocation.defaultSpan
    
    @State private var isNearby = false
    
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var val: Double = 0
    
    var body: some View {
        ZStack {

            VStack {
                MapView(showUserLocation: $showUserLocation, userLocation: $userLocation, region: $region, span: $span)
                    .environmentObject(pointsModel)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .onAppear {
                startBackgroundTask()
            }
            .onReceive(self.time) { (_) in
                checkIsNear()
            }
            
            VStack {
                CustomProgressBar(progress: val)
                    .frame(height: 57)
                Spacer()
            }
            .padding(.top, 14)
            .padding(.leading, 45)
            .padding(.trailing, 45)

            
            //MARK: - 모달 뷰
            VStack(alignment: .trailing) {
                Button(action: {
                    getCurrentLocation { location in
                        if let current = location {
                            userLocation = current
                            region = MKCoordinateRegion(center: current, span: span)
                        }
                    }
                }, label: {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 40)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 0.3)
                            )
                            .shadow(radius: 3, x: 0, y: 2)
                        Image(systemName: "scope")
                            .foregroundColor(.black)
                    }

                })
                .padding()
                TrekkingModalView(isNearby: $isNearby)
                    .shadow(radius: 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarBackButtonHidden()
    }
    
    func getCurrentLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            if let location = locationManager.location {
                completion(location.coordinate)
            } else {
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }

    
    func startBackgroundTask() {
        var backgroundTask: UIBackgroundTaskIdentifier = .invalid
        DispatchQueue.global(qos: .background).async {
            let backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "Background Task") {
                // 백그라운드 작업이 종료되었을 때 처리할 코드
                UIApplication.shared.endBackgroundTask(backgroundTask)
            }
            while true {
                // 백그라운드 작업 수행
                Thread.sleep(forTimeInterval: 1)
            }
        }
    }
    
    func checkIsNear() {

        getCurrentLocation { coordinate in
            guard let currentCoordinate = coordinate else {
                print("현재 위치를 가져올 수 없음()")
                return
            }
            
            let targetLocationPoints = pointsModel.selectedPoints
            
            var targetLocation: [Point] = []
            
            for points in targetLocationPoints {
                targetLocation.append(points.nowPoint)
            }
            
            DispatchQueue.global(qos: .background).async {
                let currentLocation = CLLocation(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)
                
                //MARK: - 활성화 기준
                let maxDistance: CLLocationDistance = 400 // 최대 허용 거리 (예: 500 미터)

                let isNearby = targetLocation.contains { location in
                    let locationCoordinate = CLLocationCoordinate2D(latitude: location.locationCoordinate.latitude, longitude: location.locationCoordinate.longitude)
                    let locationLocation = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)

//                                    print("current location : \(currentLocation)")

                    let distance = currentLocation.distance(from: locationLocation)

//                    print("Distance : \(distance)")
                    return distance <= maxDistance
                }

                DispatchQueue.main.async {
                    self.isNearby = isNearby
                }
            }
        }
    }
}

struct TrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TrekkingView()
            .environmentObject(PointsModel())
    }
}
