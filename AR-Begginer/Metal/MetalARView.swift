//
//  MetalARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/21.
//
import ARKit
import RealityKit

class MetalARView: ARView {
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupMetal()
        
    }
    
    private func setupMetal() {
        
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
