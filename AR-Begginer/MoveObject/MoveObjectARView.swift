//
//  MoveObjectARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/19.
//

import SwiftUI
import RealityKit
import ARKit

class MoveObjectARView: ARView {
    
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupCanMoveObject()
    }
    
    func setupCanMoveObject() {
        let anchorEntity = AnchorEntity(world: [0, 0, -1])
        let material = SimpleMaterial(color: .blue,
                                      isMetallic: true)
        let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.2, 0.2, 0.2),
                                                 cornerRadius:  0.03),
                              materials: [material])
        box.generateCollisionShapes(recursive: true)
        installGestures(.all,
                        for: box)
        anchorEntity.addChild(box)
        scene.anchors.append(anchorEntity)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
