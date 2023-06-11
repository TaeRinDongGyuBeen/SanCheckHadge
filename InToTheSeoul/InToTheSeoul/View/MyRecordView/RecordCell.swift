//
//  File.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/07.
//

import Foundation
import SwiftUI

struct RecordCell: View {
    // TODO: 코어데이터 매니저로 데이터를 가져와야 함.

    @State var isLastCell: Bool = false
    @State var workData: WorkData
    let index: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                VStack(spacing: 0) {
                    Image(isLastCell ? "miniDashLineShort" : "miniDashLineLong")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 3)
                    if isLastCell {
                        Spacer()
                    }
                }
                Image(isLastCell ? "StartPointMarker" : "CheckPointMarker")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
            }
            
            Text(workData.checkPoint?[index] ?? "")
                .textFontAndColor(.body3)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}


struct recordCell_preview: PreviewProvider {
    @State static var workData = WorkData()
    static var previews: some View {
        RecordCell(workData: workData, index: 1)
    }
}
