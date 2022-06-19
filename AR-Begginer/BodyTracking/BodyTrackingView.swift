//
//  BodyTrackingView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI
import RealityKit

struct BodyTrackingView: View {
    var body: some View {
        BodyTrackingViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

struct BodyTrackingViewContainer: UIViewRepresentable {
    typealias UIViewType = ARView
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    
}
