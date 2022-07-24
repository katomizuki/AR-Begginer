//
//  CollistionARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/24.
//

import ARKit
import RealityKit
import Combine

class CollistionARView: ARView {
    
    var planeAnchor: AnchorEntity?
    var eventUpdate: Cancellable?
    var virtualObjects: [VirtualObject] = []
    var pressedObject: VirtualObject?
    
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    private func setup() {
        session.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapARView))
        addGestureRecognizer(tapGesture)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressARView))
        addGestureRecognizer(longPress)
        
        let config = ARWorldTrackingConfiguration()
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        // 環境テクスチャーマッピング
        config.environmentTexturing = .automatic
        
        // 水平面を検出する
        config.planeDetection = [.horizontal]
        
        // 平面を追加する
        planeAnchor = addPlaneEntity()
        
        // たまを二つ追加する
        virtualObjects.append(addVirtualObject(name: "Sphere",
                                               nameExtension: "usdz",
                                               position: [-0.015, 0.4, 0.0],
                                               plane: planeAnchor!))
        virtualObjects.append(addVirtualObject(name: "Sphere",
                                               nameExtension: "usdz",
                                               position: [0.015, 0.4, 0.0],
                                               plane: planeAnchor!))
        // フレーム更新のイベントを受け取る。
        eventUpdate = scene.subscribe(to: SceneEvents.Update.self, onUpdateFrame(_:))
        
    }
    
    @objc private func didTapARView(_ tap: UIGestureRecognizer) {
        // ジェスチャー完了時のみ処理したい
        guard tap.state == .ended else { return }
        // タップされたモデルエンティティを調べる ARViewの場所を変数に入れる(CGPoint)
        let location = tap.location(in: self)
        // タップした結果を入れる
        let results = hitTest(location)
        
        let tappedObj: [VirtualObject] = virtualObjects.filter { obj in
            results.contains { hit in
                hit.entity == obj.modelEntity
            }
        }
        
        tappedObj.forEach { obj in
            tapVirtualObject(obj)
        }
    }
    
    // 仮想コンテンツのタップ処理
    func tapVirtualObject(_ obj: VirtualObject) {
        // 衝撃の大きさ
        var impulse: SIMD3<Float> = [0.0, 0.0, -0.5]
        
        // カメラの向きになるように回転する
        let cameraOrientation = cameraTransform.rotation
        impulse = cameraOrientation.act(impulse)
        
        // モデルに衝撃を与える
        obj.modelEntity?.applyLinearImpulse(impulse, relativeTo: nil)
        
        // 衝撃による回転の大きさ
        var torque: SIMD3<Float> = [-0.2, 0.0, 0.0]
        
        // カメラの向きとなるように回転する
        torque = cameraOrientation.act(torque)
        
        // 回転する衝撃を与える
        obj.modelEntity?.applyAngularImpulse(torque, relativeTo: nil)
    }
    
    @objc private func didLongPressARView(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            // 押されたモデルエンティティを調べる
            let location = gesture.location(in: self)
            let results = hitTest(location)
            
            // 押されたオブジェクトを取得する
            pressedObject = virtualObjects.first(where: { obj in
                results.contains { hit in
                    hit.entity == obj.modelEntity
                }
            })
        } else if gesture.state == .ended {
            pressedObject = nil
        }
    }
    
    func onUpdateFrame(_ events: SceneEvents.Update) {
        // 加える衝撃の大きさ
        var impulse: SIMD3<Float> = [0.0, 0.0, -0.5]
        //  カメラの向きになるように回転する
        let cameraOrientation = cameraTransform.rotation
        impulse = cameraOrientation.act(impulse)
        
        // モデルにちからを加える
        pressedObject?.modelEntity?.addForce(impulse,
                                             relativeTo: nil)
        
        // 衝撃による回転の大きさ
        var torque: SIMD3<Float> = [-0.2, 0.0, 0.0]
        
        // カメラの向きになるように回転する
        torque = cameraOrientation.act(torque)
        
        pressedObject?.modelEntity?.addTorque(torque,
                                              relativeTo: nil)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CollistionARView: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
    }
    
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return false
    }
    
}

extension CollistionARView {
    func addPlaneEntity() -> AnchorEntity {
        let anchor = AnchorEntity(plane: .horizontal,
                                  classification: .any,
                                  minimumBounds: [0.4, 0.4])
        let mesh = MeshResource.generatePlane(width: 0.4, depth: 0.4)
        // 実際の平面をそのまま表示してオクルージョンだけ行う
        let material = OcclusionMaterial(receivesDynamicLighting: true)
        
        // modelを作成
        let model = ModelEntity(mesh: mesh, materials: [material])
        
        // 物理情報を設定
        model.physicsBody = PhysicsBodyComponent(massProperties: .default,
                                                 material: .default,
                                                 mode: .static)
        // コリジョンを設定
        model.generateCollisionShapes(recursive: false)
        
        // アンカーエンティティに追加
        anchor.addChild(model)
        return anchor
    }
    
    func addVirtualObject(name: String,
                          nameExtension: String,
                          position: SIMD3<Float>,
                          plane: AnchorEntity) -> VirtualObject {
        // AnchorEntityを引数に入れてインスタンス化する
        let obj = VirtualObject(modelAnchor: plane)
        obj.loadModel(name: name, nameExtension: nameExtension) { successed in
            guard successed else {
                return
            }
            // 物理情報を設定する
            let model = obj.modelEntity
            model?.physicsBody = PhysicsBodyComponent(massProperties: .default,
                                                      material: .default,
                                                      mode: .dynamic)
            // コリジョンを設定する
            model?.generateCollisionShapes(recursive: true)
            
            // 位置を調整する
            model?.position = position
        }
        return obj
    }
    
    
}
