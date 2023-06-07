//
//  TrackingModalView.swift
//  InToTheSeoul
//
//  Created by KimTaeHyung on 2023/06/04.
//

import SwiftUI
import CoreLocation
import MapKit

struct TrekkingModalView: View {
    @EnvironmentObject var pointsModel: PointsModel
    
    @State var height: CGFloat = 80
    @Binding var isNearby: Bool
    
    @Binding var showRewardView: Bool
    
    @Binding var showResultView: Bool
    
    @Binding var toVisitPointIndex: Int
    
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var showAlert = false
    
    @State var lastTime = Date()
    
    @State var isLast = false
    
    @Binding var firstTime: Date
    
    @State var timeInterval: Int = 0
    
    @Binding var mkMapView: MKMapView
    
    let minHeight: CGFloat = 80
    let maxHeight: CGFloat = 320
    var percentage: Double {
        Double(height / maxHeight)
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            //Handle
            ZStack {
                Capsule()
                    .foregroundColor(Color.theme.gray3)
                    .frame(width: 120, height: 10)
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .gesture(dragGesture)
            
            VStack {
                HStack(alignment: .top) {
                    Image(systemName: "heart")
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("\(pointsModel.selectedPoints[toVisitPointIndex].isStartPoint ? "최종지점" : pointsModel.selectedPoints[toVisitPointIndex].nowPoint.name)에 도착하면")
                            .textFontAndColor(.body1)
                        
                        Text("40 행복코인 지급")
                            .textFontAndColor(.body2)
                        
                        HStack {
                            Text("이전 지점에서 4km")
                                .font(Font.seoul(.h5))
                                .foregroundColor(Color.theme.gray5)
                            
                            Text("(3,430걸음)")
                                .textFontAndColor(.h5)
                            
                            Text(" · 7분 예상")
                                .font(Font.seoul(.h5))
                                .foregroundColor(Color.theme.gray5)
                        }
                    }
                }
                .padding(.bottom, 20)
                
                //최종 지점이 아닐 때
                if !isLast { ButtonComponent(buttonType: .nextButton, content: "리워드 받기", isActive: isNearby,action: {
                    lastTime = Date()
                    
                    //                    let minutes = Calendar.current.dateComponents([.minute], from: firstTime, to: lastTime).minute ?? 0
                    print("last time : \(lastTime)")
                    
                    showRewardView = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showRewardView = false
                    }
                    
                    pointsModel.annotationPoints[toVisitPointIndex].viewPoint.isVisited = true
                    mkMapView.removeAnnotation(pointsModel.annotationPoints[toVisitPointIndex])
                    mkMapView.addAnnotation(pointsModel.annotationPoints[toVisitPointIndex])
                    toVisitPointIndex += 1
                })
                .disabled(!isNearby)
                .onChange(of: isNearby) { newValue in
                    DispatchQueue.main.async {
                        self.isNearby = newValue
                    }
                }
                .padding(.bottom, 12)
                    
                } else {    //최종 지점일 때
                    ButtonComponent(buttonType: .nextButton, content: "리워드 받기", isActive: isNearby,action: {
                        lastTime = Date()
                        
                        //                    let minutes = Calendar.current.dateComponents([.minute], from: firstTime, to: lastTime).minute ?? 0
                        print("최종----------")
                        print("first time : \(firstTime)")
                        print("last time : \(lastTime)")
                        
                        timeInterval = Int(lastTime.timeIntervalSince(firstTime) / 60) // 시간 간격 (분 단위)
                        
                        print("timeInterval : \(timeInterval)")
                        
                        showRewardView = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showRewardView = false
                        }
                        
                        pointsModel.annotationPoints[toVisitPointIndex].viewPoint.isVisited = true
                        mkMapView.removeAnnotation(pointsModel.annotationPoints[toVisitPointIndex])
                        mkMapView.addAnnotation(pointsModel.annotationPoints[toVisitPointIndex])
                        //                        toVisitPointIndex += 1
                        showResultView = true
                        
                    })
                    .disabled(!isNearby)
                    .onChange(of: isNearby) { newValue in
                        DispatchQueue.main.async {
                            self.isNearby = newValue
                        }
                    }
                    .padding(.bottom, 12)
                }
                
                Button(action: {
                    showAlert = true
                }, label: {
                    Text("오늘은 그만할래요")
                        .textFontAndColor(.h5)
                })
                .padding(.bottom, 16)
            }
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("정말 그만하실건가요?"),
                    message: Text("리워드 받은 지점까지만 기록 저장이 되니,\n신중하게 결정해주세요!"),
                    primaryButton: .destructive(Text("취소")),
                    secondaryButton: .default(Text("확인"), action: {
                        showResultView = true
                    })
                )
            })
            .padding(.leading, 40)
            .padding(.trailing, 40)
            .padding(.top, 20)
            
            Spacer()
            
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                )
                .opacity(1.5 * (percentage - 0.3))
        }
        .frame(maxWidth: .infinity)
        .frame(height: height, alignment: .top)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onReceive(self.time) { (_) in
            checkIsNear()
            checkIsLast()
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { val in
                
                var newHeight = height - val.translation.height
                
                if newHeight > maxHeight {
                    newHeight = maxHeight
                }
                else if newHeight < minHeight {
                    newHeight = minHeight
                }
                height = newHeight
                
            }
            .onEnded { val in
                let percentage = height / maxHeight
                var finalHeight = maxHeight
                
                if percentage < 0.45 {
                    finalHeight = minHeight
                }
                withAnimation(Animation.easeOut(duration: 0.3)) {
                    height = finalHeight
                }
            }
    }
    
    func checkIsLast() {
        if pointsModel.selectedPoints[toVisitPointIndex].isStartPoint {
            print("=========")
            print(pointsModel.selectedPoints.last)
            isLast = true
        } else {
        }
    }
}

// MARK: 현재위치 관련 함수
extension TrekkingModalView {
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
    
    func checkIsNear() {
        
        getCurrentLocation { coordinate in
            guard let currentCoordinate = coordinate else {
                print("현재 위치를 가져올 수 없음()")
                return
            }
            
            let targetLocation: Point = pointsModel.selectedPoints[toVisitPointIndex].nowPoint
            
            DispatchQueue.global(qos: .background).async {
                let currentLocation = CLLocationCoordinate2D(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)
                
                //MARK: - 활성화 기준
                let maxDistance: CLLocationDistance = 20 // 최대 허용 거리 (예: 500 미터)
                
                let isNearby: Bool = currentLocation.distance(from: targetLocation.locationCoordinate) <= maxDistance
                
                DispatchQueue.main.async {
                    self.isNearby = isNearby
                }
            }
        }
    }
}


//struct TrackingModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrekkingModalView()
//    }
//}
