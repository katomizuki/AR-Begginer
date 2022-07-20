//
//  ImageTrackingARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/21.
//

import RealityKit
import ARKit

class ImageTrackingARView: ARView {
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
