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
    
    @State var mkMapView: MKMapView = MKMapView()
    
    @State private var showUserLocation = false
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var region = MKCoordinateRegion(center: DefaultLocation.startingLocation, span: DefaultLocation.defaultSpan)
    @State private var span = DefaultLocation.defaultSpan
    
    @State var toVisitPointIndex: Int = 0
    @State private var isNearby = false
    
    @State var val: Double = 0
    
    @State private var showRewardView = false   //해찌 나오는 보상뷰
    @State private var showResultView = false   //모달 바꾸기
    @State private var showLoadingView = true
    @Binding var firstTime: Date
    
    @Binding var userMoney: Int
    @Binding var accumulateDistance: Double
    
    @Binding var totalDistance: Double
    @Binding var predictMin: Int
    
    var body: some View {
        ZStack {
            //            if showLoadingView {
            //                LoadingView()
            //                    .onAppear {
            //                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            //                            showLoadingView = false
            //                        }
            //                    }
            //            } else {
            VStack {
                MapView(mkMapView: $mkMapView, showUserLocation: $showUserLocation, userLocation: $userLocation, region: $region, span: $span)
                    .environmentObject(pointsModel)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .onAppear {
                startBackgroundTask()
            }
            
            VStack {
                CustomProgressBar(progress: val, totalDistance: $totalDistance, predictMin: $predictMin)
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
                
                if !showResultView {
                    TrekkingModalView(isNearby: $isNearby, showRewardView: $showRewardView, showResultView: $showResultView, toVisitPointIndex: $toVisitPointIndex, firstTime: $firstTime, mkMapView: $mkMapView)
                } else {
                    TrekkingResultView(userMoney: $userMoney, accumulateDistance: $accumulateDistance)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(edges: .bottom)
        }
        .overlay(
            Group {
                if showRewardView {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            withAnimation(.easeInOut(duration: 4)) {
                                VStack {
                                    RewardView(points: Int(pointsModel.selectedPoints[toVisitPointIndex].distanceNextPoint))
                                }
                            }
                        )
                }
            }
        )
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
}

//struct TrackingView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrekkingView()
//            .environmentObject(PointsModel())
//    }
//}

