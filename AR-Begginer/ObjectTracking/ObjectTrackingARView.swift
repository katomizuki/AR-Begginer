//
//  ObjectTrackingARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/21.
//

import RealityKit
import ARKit

class ObjectTrackingARView: ARView {
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    private func setup() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        if let objects = ARReferenceObject.referenceObjects(inGroupNamed: "AR Resources", bundle: nil) {
            config.detectionObjects = objects
        }
        session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
