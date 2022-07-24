//
//  PhysicsARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/24.
//

import RealityKit
import ARKit

class PhysicsARView: ARView {
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
