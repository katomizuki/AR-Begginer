//
//  StackObjectARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/19.
//

import SwiftUI
import RealityKit
import ARKit

class StackObjectARView: ARView {
    
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupTapGesture()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapARView))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapARView(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: self)
        guard let rayResult = ray(through: tapLocation) else { return }
        let results = scene.raycast(origin: rayResult.origin,
                                   direction: rayResult.direction)
        
        if let firstResult = results.first {
            var position = firstResult.position
            position.y += 0.3 / 2
            placeCube(at: position)
        } else {
            let results = raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any)
            
            if let firstResult = results.first {
                let position = simd_make_float3(firstResult.worldTransform.columns.3)
                placeCube(at: position)
            }
        }
    }
    
    private func placeCube(at position: simd_float3) {
        let mesh = MeshResource.generateBox(size: 0.15)
        let material = SimpleMaterial(color: .purple, isMetallic: false)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
        modelEntity.generateCollisionShapes(recursive: true)
        let anchorEntity = AnchorEntity(world: position)
        anchorEntity.addChild(modelEntity)
        scene.anchors.append(anchorEntity)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
