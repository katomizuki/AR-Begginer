//
//  ManyMaterialARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/19.
//

import RealityKit
import ARKit
import AVFoundation

class ManyMaterialARView: ARView {
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupSimpleMaterial()
        setupImageMaterial()
        setupUnlitMaterial()
        setupVideoMaterial()
    }

    
    private func setupSimpleMaterial() {
        // Create Anchor
        let anchor = AnchorEntity()
        anchor.position = simd_make_float3(0, -0.5, -1)
        // Create Box Model Entity
        let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.2, 0.2, 0.2),
                                                 cornerRadius:  0.03))
        // Box Material
        var simpleMaterial = SimpleMaterial(color: .purple,isMetallic: true)
        simpleMaterial.metallic = 1
        box.model?.materials = [simpleMaterial]
        box.transform = Transform(pitch: 0, yaw: 1, roll: 0)
        anchor.addChild(box)
        
        scene.anchors.append(anchor)
    }

    private func setupUnlitMaterial() {
        let anchor = AnchorEntity()
        anchor.position = simd_make_float3(0, -0.5, -1.5)
        let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.2, 0.2, 0.2),
                                                 cornerRadius:  0.03))
        let unlitMaterial = UnlitMaterial(color: .systemCyan)
        box.model?.materials = [unlitMaterial]
        box.transform = Transform(pitch: 0, yaw: 0.3, roll: 0)
        anchor.addChild(box)
        scene.anchors.append(anchor)
    }

    
    private func setupImageMaterial() {
        let anchorEntity = AnchorEntity(world: [0, -0.5, -4])
        let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.3, 0.3, 0.3),
                                                 cornerRadius:  0.03))
        if let texture = try? TextureResource.load(named: "colors") {
            var imageMaterial = UnlitMaterial()
            imageMaterial.baseColor = MaterialColorParameter.texture(texture)
            box.model?.materials = [imageMaterial]
            box.transform = Transform(pitch: 0, yaw: 1, roll: 0)
            anchorEntity.addChild(box)
            scene.anchors.append(anchorEntity)
        }
    }
    
    private func setupVideoMaterial() {
        let anchorEntity = AnchorEntity(world: [0, -1, -1])
        let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.5, 0.5, 0.2)))
        let videoURL = Bundle.main.url(forResource: "videoMaterial", withExtension: "mp4")!
            print(videoURL)
            let asset = AVURLAsset(url: videoURL)
            let playerItem = AVPlayerItem(asset: asset)
            let player = AVPlayer(playerItem: playerItem)
            let videoMaterial = VideoMaterial(avPlayer: player)
            box.model?.materials = [videoMaterial]
            player.play()
            anchorEntity.addChild(box)
            scene.anchors.append(anchorEntity)
    }

    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
