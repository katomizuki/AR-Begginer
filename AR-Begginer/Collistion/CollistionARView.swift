//
//  CollistionARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/24.
//

import ARKit
import RealityKit

class CollistionARView: ARView {
    
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    private func setup() {
        
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
