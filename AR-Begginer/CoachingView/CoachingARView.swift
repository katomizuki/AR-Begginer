//
//  CoachingARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/19.
//

import RealityKit
import ARKit
import SwiftUI

class CoachingARView: ARView {
    private let coachingView = ARCoachingOverlayView()
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupSession()
        setupCoachingView()
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSession() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.vertical]
        session.run(config)
    }
    
    private func setupCoachingView() {
        coachingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(coachingView)
        NSLayoutConstraint.activate([
            coachingView.topAnchor.constraint(equalTo: topAnchor),
            coachingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coachingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coachingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        coachingView.activatesAutomatically = true
        coachingView.session = session
        coachingView.delegate = self
        coachingView.goal = .verticalPlane
    }
}
extension CoachingARView: ARCoachingOverlayViewDelegate {
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        print("コーチングが表示される前に呼ばれる")
    }
    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        print("コーチングの非表示が完了したら呼ばれる")
    }
    
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
        print("セッションをリセットしてリローカライズされると呼ばれる。")
    }
}
