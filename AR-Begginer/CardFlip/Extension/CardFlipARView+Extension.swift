//
//  CardFlipARView+Extension.swift
//  CardFlipSample
//
//  Created by ミズキ on 2022/05/25.
//

import RealityKit

extension CardFlipARView {
    // 場所ステータスを変える。
    func changedFromPositioningStatus() {
        print("changeFromPositioningStatuが呼ばれたよ")
        // ポジションのステタースのremoveFromParentを行う。 collisionをnilにすることで衝突しないようにする
        self.flipTable?.collision = nil
        self.confirmButton?.removeFromParent()
        self.installedGestures = self.installedGestures.filter({
            recogniser -> Bool in
            recogniser.isEnabled = false
            return false
        })
    }
    
    func setToPositioningStatus() {
        print("setToPositioningStatusが呼ばれたよ")
        // flipTable
        guard let table = self.flipTable else { return }
        // flipTAbleにBoxのCollisionComponentを追加する
        table.collision = CollisionComponent(shapes:
                                                [.generateBox(size: [4,
                                                                     0.4,
                                                                     4])])
        // installGestureの配列に全てのジェスチャーが認識可能な
        self.installedGestures.append(contentsOf:
                                        self.installGestures([.all],
                                                             for: table))
        //
        let transform = Transform(scale: [1,
                                          1,
                                          1],
                                  rotation: simd_quatf(angle: 0,
                                                       axis: [1,
                                                              0,
                                                              0]),
                                  translation: [-0.5,
                                                 1.0,
                                                 0])
        let greenMaterial = SimpleMaterial(color: .green,
                                           isMetallic: false)
        //  ModelComponentをインスタンス化。
        let modelComponent = ModelComponent(mesh: .generateSphere(radius: 0.4),
                                            materials: [greenMaterial])
        // タップしたらステータスをプレイ中にする
        let arButton = ARButton(transform: transform,
                                model: modelComponent,
                                tapAction: {
            self.status = .playing
        })
        // confirmButtonがなければARButtonを入れてあげて
        let confirmButton = self.confirmButton ?? arButton
        self.confirmButton = confirmButton
        // flipTableに追加する。
        self.flipTable?.addChild(confirmButton)
        
        
    }
}
