//
//  MetalARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/21.
//
import ARKit
import RealityKit

class EnviromentTextureARView: ARView {
    
    var planeAnchor: AnchorEntity?
    var boxModel: ModelEntity?
    var postObject: VirtualObject?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setup()
        
    }
    
    private func setup() {
        environment.sceneUnderstanding.options = [.occlusion, .physics, .receivesLighting]
        let config = ARWorldTrackingConfiguration()
        
        // シーンの再構築を有効化する
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        session.delegate = self
        
        // 水平面を検出する
        config.planeDetection = [.horizontal]
        
        // 環境テクスチャマッピング（仮想コンテンツが環境光で反射する時に周囲の環境が写り込むようにするやつ
        config.environmentTexturing = .automatic
        
        
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            config.frameSemantics.insert(.personSegmentationWithDepth)
        }

        // configを入れてrunする
        session.run(config, options: [.removeExistingAnchors, .resetTracking])
        
        // セッションを開始。
        planeAnchor = AnchorEntity(plane: .horizontal)
        scene.addAnchor(planeAnchor!)
        
        // box
        addBox()
        // post
        addPost()
    }
    
    private func addBox() {
        let mesh = MeshResource.generateBox(size: 0.05, cornerRadius: 0.01)
        // 物理ベースレンダリングをインスタンス化してそれぞれのプロパティに必要な情報を追加する。
        var material = PhysicallyBasedMaterial()
        material.baseColor = PhysicallyBasedMaterial.BaseColor(tint: .white)
        material.metallic = PhysicallyBasedMaterial.Metallic(floatLiteral: 1.0)
        let boxModel = ModelEntity(mesh: mesh, materials: [material])
        // boxModeに追加する。
        self.boxModel = boxModel
        
        boxModel.position = [0.0, 0.01, 0.0]
        boxModel.orientation = simd_quatf(angle: .pi / 4.0, axis: [0.0, 1.0, 0.0])
    }
    
    private func addPost() {
        let obj = VirtualObject(modelAnchor: planeAnchor!)
        postObject = obj
        obj.loadModel(name: "Post", nameExtension: "usdz") { [weak self] isOk in
            guard isOk else { return }
            let model = self?.postObject?.modelEntity
            model?.position = [-0.05, 0.0, 0.1]
            model?.setScale([0.7, 0.7, 0.7], relativeTo: model)
        }
        
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EnviromentTextureARView: ARSessionDelegate {
    func sessionWasInterrupted(_ session: ARSession) {
        
    }
    
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return false
    }
}
