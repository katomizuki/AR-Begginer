//
//  GameStatus.swift
//  CardFlipSample
//
//  Created by ミズキ on 2022/05/24.
//

import Foundation
enum GameStatus {
    // コーチング中
    case initCoaching
    // 平面探し中
    case planeSearching
    // ポジショニング中
    case positioning
    // プレイ中
    case playing
    // ゲーム終了
    case finished
}
