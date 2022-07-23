//
//  FaceTrackingARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/21.
//

import ARKit
import RealityKit
import Combine

class FaceTrackingARView: ARView {
    
    var eventAddEntity: Cancellable?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    private func setup() {
        let config = ARFaceTrackingConfiguration()
        config.maximumNumberOfTrackedFaces = ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces
        
        session.run(config)
    }
    
    private func setupSubscribe() {
        eventAddEntity = scene.subscribe(to: SceneEvents.DidAddEntity.self, onAddEntity)
    }
    
    private func onAddEntity(_ events: SceneEvents.DidAddEntity) {
        guard let entity = asFaceEntity(events.entity) else {
            return
        }
        let material = SimpleMaterial(color: .white, roughness: 0.0, isMetallic: true)
        entity.model?.materials = [material]
    }
    
    //
    func asFaceEntity(_ entity: Entity) -> HasModel? {
        // シーン認識のコンポーネントを持っているかどうか モデルコンポーネントを持っているかどうか
        // そのエンティティの種類が顔になっているかどうか
        if entity.components.has(SceneUnderstandingComponent.self) && entity.components.has(ModelComponent.self) &&
            (entity.components[SceneUnderstandingComponent.self] as? SceneUnderstandingComponent)?.entityType == .face {
            return entity as? HasModel
        }
        return nil
    }
    
    
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
