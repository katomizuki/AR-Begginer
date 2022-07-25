//
//  CardComponent.swift
//  CardFlipSample
//
//  Created by ミズキ on 2022/05/24.
//

import ARKit
import Foundation
import RealityKit

// CardComponentをComponentとCodableを準きょしている構造体。idとisRevealedでカードが開いている状態かどうか調べる。
struct CardComponent: Component, Codable {
    var isRevealed = false
    var id: Int
}
