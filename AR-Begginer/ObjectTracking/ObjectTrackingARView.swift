//
//  ObjectTrackingARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/21.
//

import RealityKit
import ARKit

class ObjectTrackingARView: ARView {
    
    var labelObject: VirtualObject?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    private func setup() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        if let objects = ARReferenceObject.referenceObjects(inGroupNamed: "AR Resources", bundle: nil) {
            config.detectionObjects = objects
        }
        session.delegate = self
        session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ObjectTrackingARView: ARSessionDelegate {
    func sessionWasInterrupted(_ session: ARSession) {
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        
    }
    
    // リローカライズ
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return false
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            // ARObjectAnchorかどうかを確認する。
            guard let objAnchor = anchor as? ARObjectAnchor
            else {
                continue
            }
            guard let name = objAnchor.name else {
                continue
            }
            
            guard let detectedObj = DetectedObject(rawValue: name) else {
                continue
            }
            // 発見された時に発火させる。
            switch detectedObj {
            case .pouch:
                pouchIsDetected(objectAnchor: objAnchor)
                break
            }
            
            
        }
    }
}

extension ObjectTrackingARView {
    
    // 認識された時の処理
    func pouchIsDetected(objectAnchor: ARObjectAnchor) {
        // ラベルを表示する位置を計算する。y軸に少し足す。
        let objPos = objectAnchor.transform.columns.3
        let objBounds = objectAnchor.referenceObject.extent
        let anchorPos = SIMD3(x: objPos.x,
                              y: objPos.y + objBounds.y / 2 + 0.03,
                              z: objPos.z)
        // ラベルアンカーの作成
        let labelAnchor = AnchorEntity(world: anchorPos)
        // ラベルの正面をカメラの方に向ける。　カメラの正面を追いかける。
        var orientation = cameraTransform.rotation
        
        orientation.vector.x = 0
        // ラベルアンカーの回転角をカメラの角度に合わせる。これがないとtextが傾いてしまう。
        labelAnchor.orientation = orientation
        
        
        // 仮想コンテナにラベルアンカーを入れる。
        labelObject = VirtualObject(modelAnchor: labelAnchor)
        // addTextModelで先ほどのラベルアンカーにモデルエンティティ（テキストの）を追加する
        labelObject?.addTextModel("Pouch",
                                  extrusionDepth: 0.02,
                                  fontSize: 0.05,
                                  color: .red)
        // それをシーンに追加する。
        scene.addAnchor(labelAnchor)
    }
}
