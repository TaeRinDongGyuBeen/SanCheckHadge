//
//  MapView.swift
//  InToTheSeoul
//
//  Created by KimTaeHyung on 2023/06/04.
//

import CoreLocation
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    @Binding var showUserLocation: Bool
    
    @Binding var userLocation: CLLocationCoordinate2D?
    
    @Binding var region: MKCoordinateRegion
    
    @Binding var span: MKCoordinateSpan
    
    @ObservedObject var pointModel: PointsModel
    
    //UIViewRepresentable이 만들 View에 대한 정의를 해줘야 함
    typealias UIViewType = MKMapView

    //MapViewCoordinator가 coordinator임을 알려줘야 함
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(userLocation: $userLocation, region: $region, span: $span)
    }
    

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        //MapViewCoordinator에게 delegate 위임
        mapView.delegate = context.coordinator
        
        //MARK: - 현재 위치 표시
        mapView.showsUserLocation = showUserLocation

        //유저 위치 설정
        mapView.showsUserLocation = true
        
        
        
        //MARK: - region 설정

        //region을 기준으로 map setting
        mapView.setRegion(region, animated: true)
        
        // MARK: - JSON을 통해 불러온 데이터 어노테이션 추가
//
//        for busStop in busStopModel.busStopList {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = busStop.locationCoordinate
//            annotation.title = busStop.stop_nm
//            mapView.addAnnotation(annotation)
//        }
        
        
        
        //NYC
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.71, longitude: -74))
        
        //Boston
        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.36, longitude: -71.05))
        
        let p3 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 43.36, longitude: -72))
        
        let p4 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 44.01, longitude: -71.25))
        let p5 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 41.12, longitude: -73.3))

        //MARK: - 여러 경로
        let placemarks: [MKPlacemark] = [p1, p2, p3, p4, p5] // 지점들의 배열

        var directions: [MKDirections] = []

        for i in 0..<placemarks.count {
            let request = MKDirections.Request()
            
            // 출발지와 목적지 설정
            request.source = MKMapItem(placemark: placemarks[i])
            request.destination = MKMapItem(placemark: placemarks[(i+1) % placemarks.count])
            
            // 경로 옵션 설정
            request.requestsAlternateRoutes = true
            request.transportType = .walking
            
            let directionsRequest = MKDirections(request: request)
            directions.append(directionsRequest)
        }

        for direction in directions {
            direction.calculate { response, error in
                guard let route = response?.routes.first else { return }
                mapView.addOverlay(route.polyline)
            }
        }

        // p1, p2, p3에 어노테이션 찍기
        mapView.addAnnotations(placemarks)

        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        
    }
    
    //MARK: - Coordinator 역할 (Delegate)
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        
        //MARK: - 위치에 대한 변수
        
        var locationManager: CLLocationManager?

        @Binding var userLocation: CLLocationCoordinate2D?
        
        @Binding var region: MKCoordinateRegion
        
        @Binding var span: MKCoordinateSpan
        
        init(userLocation: Binding<CLLocationCoordinate2D?>, region: Binding<MKCoordinateRegion>, span: Binding<MKCoordinateSpan>) {
            _userLocation = userLocation
            _region = region
            _span = span
            super.init()
            checkIfLocationServicesIsEnabled()
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            region = mapView.region
            span = mapView.region.span // Update the span binding when the region changes
        }
        
        //MARK: - 현재 위치 관련
        
        func checkIfLocationServicesIsEnabled() {
            if CLLocationManager.locationServicesEnabled() {
                locationManager = CLLocationManager()
                locationManager!.delegate = self
                locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            } else {
                print("Show an alert")
            }
        }
                
        func checkLocationAuthorization() {
            guard let locationManager = locationManager else { return }
            
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted, likely due to parental controls.")
            case .denied:
                print("You have denied this app location permission. Go to Settings to change it.")
            case .authorizedAlways, .authorizedWhenInUse:
                let currentCoordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D()
                let span = MKCoordinateSpan(latitudeDelta: region.span.latitudeDelta, longitudeDelta: region.span.longitudeDelta)
                region = MKCoordinateRegion(center: currentCoordinate, span: span)
                            
                print("PPPPPPPPP \(currentCoordinate)")
                print("region --- \(region)")
                
            @unknown default:
                break
            }
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationAuthorization()
        }
        
        //MARK: - region 업데이트
        
        
        
        //MARK: - 경로 관련
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            
            return renderer
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
