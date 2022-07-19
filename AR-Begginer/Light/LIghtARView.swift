//
//  LIghtARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/20.
//

import SwiftUI
import RealityKit

class LightARView: ARView {
    
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupSpotLight()
        setupPointLight()
        setupDirectionLight()
    }
    
    private func setupSpotLight() {
        let lightAnchor = AnchorEntity(plane: .horizontal)
        let lightEntity = SpotLight()
        // 光の色
        lightEntity.light.color = .blue
        // 光の強さ
        lightEntity.light.intensity = 3000
        // どの場所から（from) どの場所へ（to) nilを入れるとtoとfromがワールド座標系になる。
        // 具体的なAnchorを入れるとオブジェクト座標系になる。
        lightEntity.look(at: [0,0,0], from: [0,0.05,0.3], relativeTo: lightAnchor)
        // 影をつけるにはSpotLightComponentのShadow()をつける必要がある。
        lightEntity.shadow = SpotLightComponent.Shadow()
        // スポットライトの内角
        lightEntity.light.innerAngleInDegrees = 45
        // スポットライトの外角
        lightEntity.light.outerAngleInDegrees = 60
        // 光がなくなっていく半径をどれくらいにするか。大きければパフォーマンスが悪化しそう。
        lightEntity.light.attenuationRadius = 10
        // AnchorにEntityを追加してあげる
        lightAnchor.addChild(lightEntity)
        // シーンにアンカーを追加してあげる。
        scene.addAnchor(lightAnchor)
    }
    
    private func setupDirectionLight() {
        let anchorEntity = AnchorEntity(plane: .horizontal)
        // 円錐形に照らすライト
        let lightEntity = DirectionalLight()
        lightEntity.light.color = .orange
        lightEntity.light.intensity = 1000
        lightEntity.light.isRealWorldProxy = true
        lightEntity.shadow?.maximumDistance = 10
        lightEntity.shadow?.depthBias = 5
        
        anchorEntity.addChild(lightEntity)
        scene.anchors.append(anchorEntity)
        
    }
    
    private func setupPointLight() {
        
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
