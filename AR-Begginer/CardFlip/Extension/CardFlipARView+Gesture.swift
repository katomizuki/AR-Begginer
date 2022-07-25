//
//  CardFlipARView+Gesture.swift
//  CardFlipSample
//
//  Created by ミズキ on 2022/05/25.
//

import SwiftUI

extension CardFlipARView {
    
    func setupGestures() {
        print("setupGestureｓが呼ばれたよ")
        // Gestureをセットアップ
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap(_ recognizer: UITapGestureRecognizer) {
        print("タップしたよ")
        // タップしたらポジショニングのステータスだったら。play中だったら。。
        switch self.status {
        case .positioning:
            print("postioningを通ったよ")
            tapWhenPositioning(recognizer)
        case .playing:
            print("playingを通ったよ")
            cardFlipAction(recognizer)
        default:
            print("何もおきらなかったよ")
            return
        }
    }
    
    // ポジショニング中だったら。
    func tapWhenPositioning(_ sender: UITapGestureRecognizer? = nil) {
        print("tapWhenPositioningが呼ばれたよ")
        // タップした場所とタップが可能かどうか確かめる。
        guard let touchInView = sender?.location(in: self),
              self.canTap else { return }
        // ボタンをタップしたところがARButton可動化チェック
        guard let arButton = self.entity(at: touchInView) as? ARButton else {
            print("ARButtonじゃないところタップしているよ！")
            return }
        // arButtonのタップアクションを発火させる。
        arButton.tapAction?()
    }
    
    func cardFlipAction(_ sender: UITapGestureRecognizer? = nil) {
        print("cardFlipActionが呼ばれたよ")
        // タップした場所を取ってくる。またタップできる状態が大事。
        guard let touchInView = sender?.location(in: self),
              self.canTap else { return }
        // タップした場所のFlipCardを取ってくる
        guard var flipCard = self.entity(at: touchInView) as? FlipCard else { return }
        // flipCardがまだ開かれていない状態だったら
        if !flipCard.isRevealed {
            print("カードをめくるよ!")
            // タップできない状態にする
            self.canTap = false
            // カードをめくるメソッドの実行
            flipCard.reveal()
            
            // currentFlippedがnilだったらキャッシュしておいたカードのこと要は一枚目
            if self.currentFlipped == nil {
                //　今Flipしたカードを入れる。
                self.currentFlipped = flipCard
                // タップできるかどうかをtrueにする
                self.canTap = true
                // フリップカードが現在にも入っているかつ色が合わなかった時
            } else if var currentlyFlipped = self.currentFlipped,
                      !currentlyFlipped.matches(with: flipCard) {
                //
                let timeout = self.flipTable?.flipBackTimeout ?? 0.5
                // not a match
                DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
                    // カードを隠すメソッドの実行
                    flipCard.hide()
                    // もう一つのカードも隠す
                    currentlyFlipped.hide(completion: {
                        // タップできる状態をtrueにする
                        self.canTap = true
                        // キャッシュしていたカードをnilにする
                        self.currentFlipped = nil
                    })
                }
            } else {
                // カードが見つかったらScoreを増やす。
                cardFound()
            }
        }
    }
}
