//
//  RealityComposerView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI
import RealityKit
import ARKit

struct RealityComposerView: View {
    var body: some View {
        RealityComposerViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct RealityComposerViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let ballon = try! Experience.loadBallon()
        arView.scene.anchors.append(ballon)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
}
