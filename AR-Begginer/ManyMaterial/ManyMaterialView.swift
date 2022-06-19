//
//  ManyMaterialView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI

struct ManyMaterialView: View {
    var body: some View {
        ManyMaterialARViewContanier().edgesIgnoringSafeArea(.all)
    }
}

struct ManyMaterialARViewContanier: UIViewRepresentable {
    typealias UIViewType = ManyMaterialARView
    func makeUIView(context: Context) -> ManyMaterialARView {
        let arView = ManyMaterialARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: ManyMaterialARView, context: Context) {
        
    }
}
