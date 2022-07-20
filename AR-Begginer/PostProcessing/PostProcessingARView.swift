//
//  PostProcessingARView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/21.
//

import RealityKit
import ARKit
import CoreImage

class PostProcessingARView: ARView {
    
    private var ciContext: CIContext!
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupConfig()
        setupPostProcessing()
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConfig() {
        let config = ARWorldTrackingConfiguration()
        session.run(config)
    }
    
    private func setupPostProcessing() {
        renderCallbacks.prepareWithDevice = setupCoreImage(device:)
        renderCallbacks.postProcess = postProcessingWithCoreImage(context:)
    }
    
    private func setupCoreImage(device: MTLDevice) {
        ciContext = CIContext(mtlDevice: device)
    }
    
    private func postProcessingWithCoreImage(context: ARView.PostProcessContext) {
        guard let filter = CIFilter(name: "CIComicEffect") else { return }
        guard let inputImage = CIImage(mtlTexture: context.sourceColorTexture) else { return }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter.outputImage else { return }
        let destination = CIRenderDestination(mtlTexture: context.targetColorTexture,
                                              commandBuffer: context.commandBuffer)
        
        destination.isFlipped = false
        _ = try? ciContext.startTask(toRender: outputImage,
                                     to: destination)
    }
    
    
    
}
