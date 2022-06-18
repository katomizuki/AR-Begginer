//
//  PutObjectARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/19.
//

import RealityKit
import SwiftUI
class PutObjectARView: ARView {
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupBox()
        setupText()
        setupPlane()
        setupSphere()
    }
    
    private func setupBox() {
        // Create Anchor
        let anchor = AnchorEntity()
        anchor.position = simd_make_float3(0, -0.5, -1)
        // Create Box Model Entity
        let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.2, 0.2, 0.2),
                                                 cornerRadius:  0.03))
        // Box Material
        let simpleMaterial = SimpleMaterial(color: .purple, isMetallic: false)
        box.model?.materials = [simpleMaterial]
        box.transform = Transform(pitch: 0, yaw: 1, roll: 0)
        anchor.addChild(box)
        
        scene.anchors.append(anchor)
    }
    
    private func setupText() {
        let textAnchor = AnchorEntity()
        textAnchor.position = simd_make_float3(0, -0.5, -2)
        let text = ModelEntity(mesh: .generateText("Reality",
                                                   font: .systemFont(ofSize: 0.1,
                                                                     weight: .bold),
                                                   containerFrame: .zero,
                                                   alignment: .center))
        text.transform = Transform(pitch: 0, yaw: 0.3, roll: 0)
        textAnchor.addChild(text)
        scene.anchors.append(textAnchor)
    }
    
    private func setupSphere() {
        let sphereEntity = AnchorEntity()
        sphereEntity.position = simd_make_float3(0, 0.5, -3)
        let simpleMaterial = SimpleMaterial(color: .blue, isMetallic: false)
        let spere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [simpleMaterial])
        sphereEntity.addChild(spere)
        scene.anchors.append(sphereEntity)
    }
    
    private func setupPlane() {
        let anchorEntity = AnchorEntity(world: [0, 2, -4])
        let plane = ModelEntity(mesh: .generatePlane(width: 1, height: 1))
        let planeMaterial = SimpleMaterial(color: .yellow, isMetallic: false)
        plane.model?.materials = [planeMaterial]
        plane.transform = Transform(pitch: 0, yaw: 1, roll: 0)
        anchorEntity.addChild(plane)
        scene.anchors.append(anchorEntity)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
