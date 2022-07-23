//
//  ImageTrackingObject.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/23.
//

import ARKit
import RealityKit
import Combine

class VirtualObject {
    var modelAnchor: AnchorEntity
    var modelEntity: ModelEntity?
    var cancellable: AnyCancellable?
    
    init(modelAnchor: AnchorEntity) {
        self.modelAnchor = modelAnchor
    }
    
    func loadModel(name: String, nameExtension: String, completion: @escaping(Bool) -> Void) {
        guard let url = Bundle.main.url(forResource: name, withExtension: nameExtension)
        else {
            completion(false)
            return
        }
        
        cancellable = Entity.loadModelAsync(contentsOf: url)
            .sink(receiveCompletion: { loadCompletion in
                if case let .failure(error) = loadCompletion {
                    print(error.localizedDescription)
                    completion(false)
                } else {
                    completion(true)
                }
            }, receiveValue: { [weak self] model in
                // モデルデータ読み込み時の処理
                self?.modelEntity = model
                self?.modelAnchor.addChild(model)
            })
        
    }
}

