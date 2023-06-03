//
//  TrekkingInformationInput.swift
//  InToTheSeoul
//
//  Created by 정승균 on 2023/06/04.
//

import SwiftUI
import CoreLocation

struct TrekkingInformationInput: View {
    @StateObject var pointsModel: PointsModel = PointsModel()
    
    @State var trekkingTime: Float = 60
    
    @State var isSelectedWaypointHospital: Bool = false
    @State var isSelectedWaypointPharmacy: Bool = false
    @State var isSelectedWaypointLibrary: Bool = false
    @State var isSelectedWaypointPark: Bool = false
    @State var isSelectedWaypointBusStop: Bool = false
    
    @State var isRecommendError: Bool = false
    
    var body: some View {
        VStack {
            Title
                .padding(.bottom, 55)
            
            TimePicker
                .padding(.bottom, 51)
            
            WaypointPicker
                .padding(.bottom, 109)
            
            ButtonComponent(buttonType: .nextButton, content: "시작하기", isActive: true) {
                do {
                    try pointsModel.recommendPoint(nowPostion: CLLocationCoordinate2D(latitude: 37.4753668, longitude: 126.9625635), walkTimeMin: Int(trekkingTime), mustWaypoint: Waypoint(hospital: isSelectedWaypointHospital, pharmacy: isSelectedWaypointPharmacy, library: isSelectedWaypointLibrary, park: isSelectedWaypointPark, busStop: isSelectedWaypointBusStop))
                } catch {
                    print(error)
                    isRecommendError.toggle()
                }
            }
            
        }
        .padding(.horizontal, 40)
        .alert("경로 추천 실패", isPresented: $isRecommendError) {
            
        } message: {
            Text("위치 정보를 불러올 수 없거나\n서비스할 수 없는 지역입니다.")
        }
    }
}

extension TrekkingInformationInput {
    private var Title: some View {
        VStack {
            Text("어떤 산책을 원하시나요?")
                .textFontAndColor(font: .headline1, color: .theme.black)
            Text("정보를 입력하고, 나만의 산책 코스를 추천받아보세요")
                .textFontAndColor(font: .headline2, color: .theme.gray5)
        }
    }
    
    private var TimePicker: some View {
        VStack {
            HStack(alignment: .bottom, spacing: 16) {
                Text("시간")
                    .textFontAndColor(font: .headline3, color: .theme.black)
                Text("슬라이더를 움직여 산책 시간을 선택해주세요")
                    .textFontAndColor(font: .headline4, color: .theme.gray4)
                Spacer()
            }
            .padding(.bottom, 12)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.theme.gray1)
                VStack {
                    HStack(alignment: .bottom) {
                        Text("\(Int(trekkingTime))")
                            .textFontAndColor(font: .body4, color: .theme.green1)
                        Text("분")
                            .textFontAndColor(font: .headline5, color: .theme.gray4)
                    }
                    
                    Slider(value: $trekkingTime, in: 0...120, step: 5)
                        .tint(.theme.green1)
                    HStack {
                        Text("0분")
                        Spacer()
                        Text("2시간")
                    }
                    .textFontAndColor(font: .headline5, color: .theme.gray4)
                }
                .padding(.horizontal, 14)
                
            }
            .frame(height: 146)
        }
    }
    
    private var WaypointPicker: some View {
        VStack {
            HStack(alignment: .bottom, spacing: 16) {
                Text("경유지")
                    .textFontAndColor(font: .headline3, color: .theme.black)
                Text("꼭 들리고 싶은 곳이 있다면 선택해주세요")
                    .textFontAndColor(font: .headline4, color: .theme.gray4)
                Spacer()
            }
            .padding(.bottom, 12)
            
            VStack {
                HStack {
                    ButtonComponent(buttonType: .miniButton, content: "병원", isActive: isSelectedWaypointHospital) {
                        isSelectedWaypointHospital.toggle()
                    }
                    ButtonComponent(buttonType: .miniButton, content: "약국", isActive: isSelectedWaypointPharmacy) {
                        isSelectedWaypointPharmacy.toggle()
                    }
                    ButtonComponent(buttonType: .miniButton, content: "도서관", isActive: isSelectedWaypointLibrary) {
                        isSelectedWaypointLibrary.toggle()
                    }
                }
                
                HStack {
                    ButtonComponent(buttonType: .miniButton, content: "공원", isActive: isSelectedWaypointPark) {
                        isSelectedWaypointPark.toggle()
                    }
                    ButtonComponent(buttonType: .miniButton, content: "버스정류장", isActive: isSelectedWaypointBusStop) {
                        isSelectedWaypointBusStop.toggle()
                    }
                }
            }
            
        }
    }
}

struct TrekkingInformationInput_Previews: PreviewProvider {
    static var previews: some View {
        TrekkingInformationInput()
    }
}
