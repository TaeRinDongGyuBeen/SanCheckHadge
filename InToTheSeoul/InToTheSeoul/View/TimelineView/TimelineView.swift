//
//  TimelineView.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/05.
//

import SwiftUI

struct TimelineView: View {
    @State var workDatum = CoreDataManager.coreDM.readWorkData()
    
    var body: some View {
        if workDatum.count != 0 {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0 ..< workDatum.count) { index in
                        if index == 0 {
                            ScrollCell(isFirstCell: true, workData: workDatum[index])
                        }
                        ScrollCell(workData: workDatum[index])
                    }
                }
                
            }
            .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
            
        } else {
            Text("데이터가 없습니다.")
            Button("시험데이터 생성", action: {
                CoreDataManager.coreDM.createWorkData(date: Date(), distance: 3.2, gainPoint: 350, moveRoute: [(39.323)], checkPoint: ["강남", "홍대", "서초", "이건희집", "봉천동"], startPoint: "청와대")
            })
        }
    }
}


struct ScrollCell: View {
    // TODO: 코어데이터 매니저로 데이터를 가져와야 함.
    // 임시로 gainCoin 등의 변수를 둠.
    
    @State var gainCoin: Int = 0
    @State var isFirstCell: Bool = false
    @State var workData: WorkData
    var body: some View {
        HStack(spacing: 0) {
            Text("+\(gainCoin)")
                .textFontAndColor(.h5)
            Spacer()
            ZStack {
                VStack {
                    if isFirstCell {
                        Spacer()
                    }
                    Image(isFirstCell ? "dashLineShort" : "dashLine")
                }
                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundColor(isFirstCell ? Color.theme.green1 : Color.theme.green3)
            }
            
            Spacer()
            
            NavigationLink(destination: {
                
            }, label: {
                HStack(spacing: 0) {
                    VStack {
                        Text("오늘 날짜")
                            .frame(width: 171, alignment: .leading)
                            .textFontAndColor(.body3)
                        Spacer()
                        HStack(spacing: 0) {
                            Text("(시간)분 동안 (거리)km 산책")
                                .textFontAndColor(.h2)
                        }
                        .frame(width: 171, alignment: .leading)
                    }
                    .frame(maxHeight: 39)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 9, height: 15.5)
                        .foregroundColor(Color.theme.green1)
                }
                
            })
            .frame(width: 216, height: 76)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.gray3, lineWidth: 2)
                
            )
            .cornerRadius(20)
        }
        .frame(width: .infinity, height: 102)
        
    }
}


struct TimelineView_Previewer: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
