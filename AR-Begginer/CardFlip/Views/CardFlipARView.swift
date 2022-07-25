//
//  CardFlipARView.swift
//  CardFlipSample
//
//  Created by ミズキ on 2022/05/24.
//

import ARKit
import Combine
import RealityKit

class CardFlipARView: ARView, ARSessionDelegate {
    let coachingOverlay = ARCoachingOverlayView()
    var tableAdded = false
    
    var status: GameStatus = .initCoaching {
        didSet {
            switch oldValue {
            case .positioning:
                changedFromPositioningStatus()
            default:
                break
            }
            switch status {
            case .positioning:
                setToPositioningStatus()
            default:
                break
            }
        }
    }
    
    var canTap = true
    var installedGestures: [EntityGestureRecognizer] = []
    var waitForAnchor: Cancellable?
    var touchStartedOn: FlipCard? = nil
    var currentFlipped: FlipCard? = nil
    var flipTable: FlipTable? = nil
    var confirmButton: ARButton?
    var gameData = GameData()
    
    // FlipTableを加えるメソッド
    func addFlipTable() {
        print("テーブルを追加するよ")
        // flipTableをインスタンス化
        if let flipTable = try? FlipTable(dimensions: gameData.dimensions) {
            if tableAdded {
                return
            }
            self.flipTable = flipTable
            // カードテーブルに加えられるをtrue
            self.tableAdded = true
            // minimumBoundsを設定。
            flipTable.minimumBounds = [0.5, 0.5]
            // 平面を探している状態にする
            self.status = .planeSearching
            
            // flipTableのAnchor状態が変わったらeventを発火させる。
            self.waitForAnchor = self.scene.subscribe(to: SceneEvents.AnchoredStateChanged.self, on: flipTable, { event in
                // AnchorEntityを持っているかどうか
                if event.isAnchored {
                    // ポジショニング状態にする
                    self.status = .positioning
                    print("positionの状態にするよ！")
                    DispatchQueue.main.async {
                        // Cancellableをキャンセル。
                        self.waitForAnchor?.cancel()
                        self.waitForAnchor = nil
                    }
                }
            })
            // flipTableを置く
            print("flipTableを実際にaddしたよ！")
            self.scene.anchors.append(flipTable)
        } else {
            print("couldnt make flip table")
        }
    }
    
    // カードが見つかったら
    func cardFound() {
        print("カードが見つかったよ")
        // カードが見つかったら2を足す
        self.gameData.cardsFound += 2
            // 全て見つかったらゲーム終了
        if self.gameData.cardsFound == self.gameData.totalCards {
             gameComplete()
        } else {
            // フリップしたカードをnilにしてタップできる状態にする。
            self.currentFlipped = nil
            self.canTap = true
        }
    }
    
    // ゲームが終わったら
    func gameComplete() {
        print("ゲーム終わったよ")
        // flipTableにWinnerという文字を書く。
        self.status = .finished
        let materials = [SimpleMaterial(color: .yellow,
                                       isMetallic: true)]
        let text = MeshResource.generateText("Winner",
                                             extrusionDepth: 0.1,
                                             font: .systemFont(ofSize: 0.5),
                                             containerFrame:
                                                CGRect(origin: .zero,
                                                       size: CGSize(width: 2,
                                                                    height: 1)),
                                             alignment: .center,
                                             lineBreakMode: .byWordWrapping)
        let finText = ModelEntity(mesh: text,
                                  materials: materials)
        finText.position.y = 1
        self.flipTable?.addChild(finText)
    }
}
