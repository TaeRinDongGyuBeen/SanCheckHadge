//
//  LoadingView.swift
//  InToTheSeoul
//
//  Created by 정승균 on 2023/06/05.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        VStack {
            Text("\(CoreDataManager.coreDM.readUser()[0].username ?? "태린동규빈")님만의 산책 코스를 찾고 있으니,\n조금만 기다려주세요!")
                .multilineTextAlignment(.center)
                .textFontAndColor(.body1)
                .padding(.bottom, 37)
            
            Image("loadingHedge")
                .frame(width: 117, height: 127)
                .padding(.bottom, 77)
            
            ActivityIndicator(isAnimating: .constant(true), style: .large)
                
            
            
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(Color.theme.white)
    }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        
        let indicator = UIActivityIndicatorView(style: style)
        
        indicator.color = UIColor(Color.theme.green1)
        
        return indicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
