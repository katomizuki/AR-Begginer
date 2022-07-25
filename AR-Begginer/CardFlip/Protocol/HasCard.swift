//
//  HasCard.swift
//  CardFlipSample
//
//  Created by ミズキ on 2022/05/24.
//

import Combine
import RealityKit
import ARKit

protocol HasCard {
    // CardComponetを追加
    var card: CardComponent { get set }
    var revealAnimationCallback: Cancellable? { get set }
    var hideAnimationCallback: Cancellable? { get set }
}

extension HasCard where Self: Entity {
    var cardID: Int {
        self.card.id
    }
    
    var isRevealed: Bool {
        get {
            self.card.isRevealed
        }
        mutating set {
            self.card.isRevealed = newValue
        }
    }
}

extension HasCard where Self: Entity {
    // カードを開いてみるメソッド
    mutating func reveal(completion: (() -> Void)? = nil) {
        print("カードをめくるよ")
        // カードをめくるをtrueにする
        card.isRevealed = true
        // 自身のtransformを変数に入れる
        var transform = self.transform
        // x軸を中心に180度回転させる。
        transform.rotation = simd_quatf(angle: .pi, axis: [1, 0, 0])
        // 動かすAnimationControllerを変数に入れる
        let myEvent = move(to: transform,
                           relativeTo: parent,
                           duration: 0.25,
                           timingFunction: .easeOut)
        self.revealAnimationCallback = self.scene?.subscribe(to: AnimationEvents.PlaybackTerminated.self,
                                                             on: self, { event in
            // Animationをセットする
            print("カードを開くアニメーションをするよ")
            guard event.playbackController == myEvent else { return }
            completion?()
        })
    }
    
    mutating func hide(completion: (() -> Void)? = nil) {
        print("カードを隠すよ")
        var cself = self
        var transform = self.transform
        // もとに戻す
        transform.rotation = simd_quatf(angle: 0, axis: [1, 0, 0])
        // AnimationControllerを変数に入れる
        let myEvent = move(to: transform, relativeTo: parent, duration: 0.25, timingFunction: .easeOut)
        self.hideAnimationCallback = self.scene?.subscribe(to: AnimationEvents.PlaybackTerminated.self,on: self, { event in
            if event.playbackController == myEvent {
                print("カードを隠すアニメーションをするよ")
                // 隠したのでisRevealedをfalseにする
                cself.isRevealed = false
                //
                cself.hideAnimationCallback = nil
                completion?()
            }
        })
    }
}
