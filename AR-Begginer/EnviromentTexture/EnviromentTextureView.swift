//
//  MetalView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI
struct EnviromentTextureView: View {
    var body: some View {
        EnviromentTextureViewContanier().edgesIgnoringSafeArea(.all)
    }
}

struct EnviromentTextureViewContanier: UIViewRepresentable {
    typealias UIViewType = EnviromentTextureARView
    
    func makeUIView(context: Context) -> EnviromentTextureARView {
        let arView = EnviromentTextureARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: EnviromentTextureARView, context: Context) {
        
    }
    
    
}
