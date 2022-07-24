//
//  PhysicsARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/24.
//

import RealityKit
import ARKit
import Combine

class PhysicsARView: ARView {
    
    var collisionBegan: Cancellable?
    var planeAnchor: AnchorEntity?
    var leftWallModel: ModelEntity?
    var rightWallModel: ModelEntity?
    var ballModel: ModelEntity?
    var playbackController: AnimationPlaybackController?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    private func setup() {
        // collisionオプションを追加する。
        
        environment.sceneUnderstanding.options = [.collision]
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        
        session.run(config, options: [.resetTracking,.removeExistingAnchors])
        session.delegate = self
        
        collisionBegan = scene.subscribe(to: CollisionEvents.Began.self, onCollisionBegan)
        
        planeAnchor = addPlane()
        
        leftWallModel = addWall(xPosition: -0.3,
                                plane: planeAnchor!)
        rightWallModel = addWall(xPosition: 0.3,
                                 plane: planeAnchor!)
        
        ballModel = addBall(plane: planeAnchor!)
    }
    
    
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhysicsARView: ARSessionDelegate {
    func sessionWasInterrupted(_ session: ARSession) {
        
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        
    }
    
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return false
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .normal:
            if let wall = leftWallModel {
                moveBallToWall(wall: wall)
            }
        default:
            break
        }
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        
    }
    
    func session(_ session: ARSession, didChange geoTrackingStatus: ARGeoTrackingStatus) {
        
    }

    func session(_ session: ARSession, didOutputCollaborationData data: ARSession.CollaborationData) {
        
    }
    
    func session(_ session: ARSession, didOutputAudioSampleBuffer audioSampleBuffer: CMSampleBuffer) {
        
    }
    
}
extension PhysicsARView {
    // 衝突した際に発火
    func onCollisionBegan(_ events: CollisionEvents.Began) {
        guard events.entityA == ballModel else {
            return
        }
        
        if events.entityB == leftWallModel {
            // 左側の壁に衝突したから右側の壁に移動するためにラップ
            if let wall = rightWallModel {
                moveBallToWall(wall: wall)
            }
        } else if events.entityB == rightWallModel {
            // 右側の壁に衝突したから左側の壁に移動するためのラップ。
            if let wall = leftWallModel {
                moveBallToWall(wall: wall)
            }
        }
    }
}

extension PhysicsARView {
    func addPlane() -> AnchorEntity {
        let planeAnchor = AnchorEntity(plane: .horizontal,
                                       classification: .any,
                                       minimumBounds: [0.6, 0.3])
        scene.addAnchor(planeAnchor)
        return planeAnchor
    }
    
    func addWall(xPosition: Float,
                 plane: AnchorEntity) -> ModelEntity {
        // ボックスを生成する
        let mesh = MeshResource.generateBox(size: [0.02, 0.3, 0.3])
        let material = SimpleMaterial(color: .white,
                                      roughness: 1.0,
                                      isMetallic: false)
        let model = ModelEntity(mesh: mesh, materials: [material])
        
        // アンカーエンティティに追加して位置を設定.
        plane.addChild(model)
        model.position = [xPosition, 0.15, 0.0]
        // コリジョンコンポーネント
        model.generateCollisionShapes(recursive: false)
        return model
    }
    
    func addBall(plane: AnchorEntity) -> ModelEntity {
        // 球を生成する
        let mesh = MeshResource.generateSphere(radius: 0.03)
        let material = SimpleMaterial(color: .blue,
                                      roughness: 1.0,
                                      isMetallic: false)
        
        let model = ModelEntity(mesh: mesh, materials: [material])
        
        // アンカーエンティティを追加、位置を調整
        plane.addChild(model)
        model.position = [0.0, 0.03, 0.0]
        
         // コリジョンコンポーネント
        model.generateCollisionShapes(recursive: false)
        return model
    }
}

extension PhysicsARView {
    func moveBallToWall(wall: ModelEntity) {
        guard let ball = ballModel,
              let plane = planeAnchor
        else {
            return
        }
        // ボールのTransformを変数に入れる
        var transform = ball.transform
        
        // x座標だけを壁の位置に変更する
        transform.translation.x = wall.position.x
        
        // 一定速度で壁まで移動する
        playbackController = ball.move(to: transform,
                                       relativeTo: plane,
                                       duration: 3,
                                       timingFunction: .linear)        
    }
}
