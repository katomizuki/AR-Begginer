//
//  BodyTrackingARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/23.
//

import RealityKit
import ARKit
import Combine

class BodyTrackingARView: ARView {
    
    var bodyTrackedEntity: BodyTrackedEntity?
    let characterOffset: SIMD3<Float> = [-1.0, 0, 0]
    let characterAnchor = AnchorEntity()
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setup()
        loadModel()
    }
    
    private func setup() {
        let config = ARBodyTrackingConfiguration()
        // ここでチェックを入れる。
        guard ARBodyTrackingConfiguration.isSupported else {
            fatalError()
        }
        session.delegate = self
        session.run(config)
    }
    
    private func loadModel() {
        // AnyCancellableで購読をキャンセルするときに使用する。sinkでAnyCancellableが返却されるので勝手にサブスクライブが破棄されないように事前に用意する必要がある。
        var cancellable: AnyCancellable? = nil
        cancellable = Entity.loadBodyTrackedAsync(named: "charcter/robot")
            .sink(receiveCompletion: { loadCompletion in
                if case let .failure(error) = loadCompletion {
                    print(error.localizedDescription)
                    // cancelをしこれ以上サブスクライブするのを停止する。
                    cancellable?.cancel()
                }
            }, receiveValue: { entity in
                // 大きさを指定して
                entity.scale = [1.0, 1.0, 1.0]
                // ボディトラックエンティティに追加する
                self.bodyTrackedEntity = entity
                cancellable?.cancel()
            })
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension BodyTrackingARView: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        // anchorsをforループで回しつつ ARBodyAnchorにキャストできるものはする。
        for anchor in anchors {
            guard let bodyAnchor = anchor as? ARBodyAnchor else { continue }
            // ボディアンカーのTransformのカラムから位置を取ってきて
            let bodyPosition = simd_make_float3(bodyAnchor.transform.columns.3)
            bodyTrackedEntity?.position = bodyPosition + characterOffset
            //　親を中心とした相対的な回転。　ワールド座標を参照したい場合は引数にnilを渡す。
            characterAnchor.orientation = Transform(matrix: bodyAnchor.transform).rotation
            
            if let character = bodyTrackedEntity, character.parent == nil {
                characterAnchor.addChild(character)
            }
        }
    }
}
