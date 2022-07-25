//
//  CardFlipView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI
import ARKit
import RealityKit

struct CardFlipView: View {
    var body: some View {
        CardFlipARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct CardFlipARViewContainer: UIViewRepresentable {
    typealias UIViewType = CardFlipARView
    func makeUIView(context: Context) -> CardFlipARView {
        let arView = CardFlipARView(frame: .zero)
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        arView.session.run(config)
        arView.setupCoaching()
        arView.setupGestures()
        arView.session.delegate = arView
        return arView
    }
    
    func updateUIView(_ uiView: CardFlipARView, context: Context) {
        
    }
}
