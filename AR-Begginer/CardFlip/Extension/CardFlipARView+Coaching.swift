//
//  CardFlipARView+Coaching.swift
//  CardFlipSample
//
//  Created by ミズキ on 2022/05/25.
//

import Foundation
import ARKit
extension CardFlipARView: ARCoachingOverlayViewDelegate  {
    
    // CoachingView周りのセットアップ
    func setupCoaching() {
        print("setupCoachingが呼ばれたよ")
        // Delegateをセット
        self.coachingOverlay.delegate = self
        // ARviewの自身のsessionをCoachingのSessionにセットする
        self.coachingOverlay.session = self.session
        self.coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.coachingOverlay.goal = .horizontalPlane
        
        self.addSubview(self.coachingOverlay)
    }
    
    // 終了したらよぶ
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        print("coachingが終わったよ")
        self.addFlipTable()
    }
}
