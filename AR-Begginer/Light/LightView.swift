//
//  LightView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/21.
//

import SwiftUI
import RealityKit

struct LightView: View {
    var body: some View {
            VStack {
                LightARViewContainer()
                    .ignoresSafeArea(.all)
            }
        }
}

struct LightARViewContainer: UIViewRepresentable {
    typealias UIViewType = LightARView
    
    func makeUIView(context: Context) -> LightARView {
        let arView = LightARView(frame: .zero)
        let boxMesh = MeshResource.generateBox(size: [0.1,0.1,0.1])
        let boxEntity = ModelEntity(mesh: boxMesh)
        let anchorEntity = AnchorEntity(world: [0.2,0.2,0.2])
        anchorEntity.addChild(boxEntity)
        arView.scene.addAnchor(anchorEntity)
        return arView
    }
    
    func updateUIView(_ uiView: LightARView, context: Context) {
        
    }
}
