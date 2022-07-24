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

extension VirtualObject {
    func addTextModel(_ text: String,
                      extrusionDepth: Float,
                      fontSize: CGFloat,
                      color: UIColor) {
        let textMesh = MeshResource.generateText(text, extrusionDepth: extrusionDepth,
                                                 font: .systemFont(ofSize: fontSize),
                                                 containerFrame: .zero,
                                                 alignment: .center,
                                                 lineBreakMode: .byTruncatingTail)
        let textMaterial = SimpleMaterial(color: color, isMetallic: false)
        let textModel = ModelEntity(mesh: textMesh, materials: [textMaterial])
        modelEntity = textModel
        
        modelAnchor.addChild(textModel)
        // textの真ん中を取ってくる、元々、テキストメッシュは左下が原点（0,0,0)なので、親のModelEntityと中心がずれてしまう。そのため、中心を一旦変数に入れつつ、その分ズラスト揃う
        let center = textMesh.bounds.center
        textModel.position = [-center.x, -center.y, -center.z]
        
        
    }
}
