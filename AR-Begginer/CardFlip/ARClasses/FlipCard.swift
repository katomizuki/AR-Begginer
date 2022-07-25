//
//  FlipCard.swift
//  CardFlipSample
//
//  Created by ミズキ on 2022/05/24.
//

import RealityKit
import UIKit
import Combine



// 色をMaterial変換するExtension
fileprivate extension UIColor {
    func toMaterial(isMetallic: Bool = false) -> Material {
        return SimpleMaterial(color: self, isMetallic: isMetallic)
    }
}

class FlipCard: Entity, HasModel, HasCollision, HasCard {
    var revealAnimationCallback: Cancellable?
    var hideAnimationCallback: Cancellable?
    
    var card: CardComponent {
        get {
            // 取得する場合はcomponentsのCardcomponentsを取り出す。 ?? Cardcomponentのid(: -1)を変えす
            components[CardComponent] ?? CardComponent(id: -1)
        }
        set {
            // cardに何かセットされたらCardComponentのとこに入れてあげる。
            components[CardComponent] = newValue
        }
    }
    
    init(color: UIColor, id: Int) {
        super.init()
        // インスタンス化 idを入れる
        self.card = CardComponent(id: id)
        // PlaneのModelEntityを追加。colorのmaterialを設定
        let coloredFace = ModelEntity(mesh: MeshResource.generatePlane(width: 1, depth: 1),
            materials: [color.toMaterial()])
        // 平面の回転軸
        coloredFace.orientation = simd_quatf(angle: .pi, axis: [1, 0, 0])
        coloredFace.position.y = -0.101
        self.addChild(coloredFace)
        // 灰色の箱を追加する。
        self.model = ModelComponent(mesh: .generateBox(size: [1, 0.2, 1]), materials: [UIColor.gray.toMaterial()])
        // collisioncomponentを追加する。
        self.collision = CollisionComponent(shapes: [ShapeResource.generateBox(size: [1, 0.2, 1])])
    }
    
    required init() {
        fatalError()
    }
    
    func matches(with match: FlipCard) -> Bool {
        print("マッチしているかどうか確かめるよ！")
        // matchesしているかどうか確かめる。　idで確かめる。
        return self.cardID == match.cardID
    }
}
