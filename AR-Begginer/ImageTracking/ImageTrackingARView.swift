//
//  ImageTrackingARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/21.
//

import RealityKit
import ARKit

class ImageTrackingARView: ARView {
    
    var book: VirtualObject?
    var dog: VirtualObject?
    var bookAnchor: AnchorEntity?
    var dogAnchor: AnchorEntity?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupConfig()
    }
    
    private func setupConfig() {
        let config = ARImageTrackingConfiguration()
        // ここでトラッキングしたい画像を設定する
        config.trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)!
        
        config.maximumNumberOfTrackedImages = 2
        
        // removeExistingAnchors->以前のAnchorを削除する, resetTracking -> デバイスの位置を過去のセッションから削除する
        session.delegate = self
        session.run(config, options: [.removeExistingAnchors, .resetTracking])
    }
    
    
    
    
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dogTracking(imageAnchor: ARImageAnchor) {
        // 作成済みのアンカーがあったら削除
        self.dogAnchor?.removeFromParent()
        // ImageAnchorからAnchorEntityを作成しドッグアンカーに追加する
        self.dogAnchor = AnchorEntity(anchor: imageAnchor)
        scene.addAnchor(dogAnchor!)
        
        // モデルアンカーから既存の追加ずみのモデルがあれば削除する
        dog?.modelAnchor.removeFromParent()
        
        // 画像を上に出現させるためのTransformを用意。
        var transform = Transform(matrix: imageAnchor.transform)
        transform.translation.y += 0.1
        // そのTransformで場所を設定してAnchorEntityを設定。
        let modelAnchor = AnchorEntity(world: transform.matrix)
        // オブジェクトを設定。
        dog = VirtualObject(modelAnchor: modelAnchor)
        
        dog?.loadModel(name: "Dog", nameExtension: "usdz", completion: { [weak self] isSuccessed in
            if isSuccessed {
                self?.scene.addAnchor(modelAnchor)
            }
        })
    }
    
    private func bookTracking(imageAnchor: ARImageAnchor) {
        self.bookAnchor?.removeFromParent()
        self.bookAnchor = AnchorEntity(anchor: imageAnchor)
        
        scene.addAnchor(bookAnchor!)
        
        book?.modelAnchor.removeFromParent()
        
        var transform = Transform(matrix: imageAnchor.transform)
        transform.translation.y += 0.1
        
        let modelAnchor = AnchorEntity(world: transform.matrix)
        book = VirtualObject(modelAnchor: modelAnchor)
        
        book?.loadModel(name: "Book", nameExtension: "usdz", completion: { [weak self] isSuccessed in
            if isSuccessed {
                self?.scene.addAnchor(modelAnchor)
            }
        })
    }
    
    func bookUpdate() {
        if let bookAnchor = bookAnchor {
            book?.modelAnchor.setPosition([0,0.1,0], relativeTo: bookAnchor)
        }
    }
    
    func dogUpdate() {
        if let dogAnchor = dogAnchor {
            dog?.modelAnchor.setPosition([0,0.1,0], relativeTo: dogAnchor)
        }
    }
    
    
}
// ARSessionDelegateでSesisoの状態を検知する
extension ImageTrackingARView: ARSessionDelegate {
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
    
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let imageAnchor = anchor as? ARImageAnchor else { continue }
            guard let imageName = imageAnchor.name else { continue }
            guard let trackingImage = TrackingImage(rawValue: imageName) else { continue }
            switch trackingImage {
            case .book:
                bookUpdate()
                break
            case .dog:
                dogUpdate()
                break
            }
        }
    }
    
    // セッションエラーの検知
    func session(_ session: ARSession, didFailWithError error: Error) {
        
    }
    
    // Anchorが追加された時を検知
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let imageAnchor = anchor as? ARImageAnchor else { continue }
            guard let imageName = imageAnchor.name else { continue }
            guard let trackingImage = TrackingImage(rawValue: imageName) else { continue }
            switch trackingImage {
            case .book:
                bookTracking(imageAnchor: imageAnchor)
                break
            case .dog:
                dogTracking(imageAnchor: imageAnchor)
                break
            }
        }
    }
    
    // ARsession中止時の処理
    func sessionWasInterrupted(_ session: ARSession) {
        
    }
    
    // ARSession再開時の処理
    func sessionInterruptionEnded(_ session: ARSession) {
        
    }
    
    // カメラのトラッキング精度が変更されたときの処理。
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .normal:
            break
        case .notAvailable:
            break
        case .limited(let reason):
            // 制限されている理由がenumで入ってくる。
            print(reason)
        }
    }
    
    // リローカライズの実行判定（配置済みのコンテンがあった場合、リーロカライズするか否か
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return false
    }
}
