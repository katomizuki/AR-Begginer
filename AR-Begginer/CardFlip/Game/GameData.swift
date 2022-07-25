//
//  GameData.swift
//  CardFlipSample
//
//  Created by ミズキ on 2022/05/24.
//

import ARKit
import Combine
import RealityKit

struct GameData {
    // 盤面の数
    var dimensions: SIMD2<Int> = [4, 4]
    // 見つかったカードの数
    var cardsFound: Int = 0
    // 全ての数
    var totalCards: Int {
        dimensions[0] * dimensions[1]
    }
}
