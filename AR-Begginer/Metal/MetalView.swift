//
//  MetalView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI
struct MetalView: View {
    var body: some View {
        MetalViewContanier().edgesIgnoringSafeArea(.all)
    }
}

struct MetalViewContanier: UIViewRepresentable {
    typealias UIViewType = MetalARView
    
    func makeUIView(context: Context) -> MetalARView {
        let arView = MetalARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: MetalARView, context: Context) {
        
    }
    
    
}
