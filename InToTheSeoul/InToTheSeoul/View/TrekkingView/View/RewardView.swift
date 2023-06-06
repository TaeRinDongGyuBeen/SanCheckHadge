//
//  RewardView.swift
//  InToTheSeoul
//
//  Created by KimTaeHyung on 2023/06/06.
//

import SwiftUI

struct RewardView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    
    @State private var points: Int = 30
    @State private var wish = false
    
    @State private var finishWish = false
    
    var body: some View {
        ZStack {
            Image("RewardHedge")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: getRect().width / 1.8)
            
            Image("RewardDescription")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 200)
            
            Text("\(points)")
                .padding(.top, 176)
                .padding(.trailing, 40)
                .foregroundColor(.white)
                .font(.system(size: 36, weight: .bold))
                
            
            //임시
            VStack {
                Spacer()
                Button(action: {
                    doAnimation()
                }, label: {
                    Text("click")
                })
            }
            .disabled(wish)
            
            EmitterView()
                .scaleEffect(wish ? 1 : 0, anchor: .top)
                .opacity(wish && !finishWish ? 1 : 0)
                .ignoresSafeArea()
                

        }
    }
    
    func doAnimation() {
        withAnimation(.spring()) {
            wish = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut(duration: 0.5)) {
                finishWish = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                finishWish = false
                wish = false
            }
        }
    }
    
}



struct RewardView_Previews: PreviewProvider {
    static var previews: some View {
        RewardView()
    }
}



//Global Function for getting size
func getRect() -> CGRect {
    return UIScreen.main.bounds
}

struct EmitterView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        //Emitter layer
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .line
        emitterLayer.emitterCells = createEmitterCells()
        
        //Size and Position
        emitterLayer.emitterSize = CGSize(width: getRect().width, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: getRect().width / 2, y: 0)
        
        view.layer.addSublayer(emitterLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func createEmitterCells() -> [CAEmitterCell] {

        
        var emitterCells: [CAEmitterCell] = []
        
        
        for index in 1...12 {
            let cell = CAEmitterCell()
            
            cell.contents = UIImage(systemName: "banknote")?.cgImage
            
            cell.color = UIColor.green.cgColor // 색상 변경
            //New particle Creation
            cell.birthRate = 3
            
            //Particle Existence
            cell.lifetimeRange = 20
            
            cell.velocity = 150
            
            cell.scale = 0.25
            
            cell.emissionLongitude = 3
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 1
            
            emitterCells.append(cell)
        }
        
        return emitterCells
    }
    
    
}
