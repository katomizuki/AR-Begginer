//
//  ContentView.swift
//  CardFlipSample
//
//  Created by ミズキ on 2022/05/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> CardFlipARView {
        let arView = CardFlipARView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        arView.session.run(config)
        arView.setupCoaching()
        arView.setupGestures()
        arView.session.delegate = arView
        print("CardFlipARViewを返すよ！")
        return arView
    }
    
    func updateUIView(_ uiView: CardFlipARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
