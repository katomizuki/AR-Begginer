//
//  PutObjectView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.


import SwiftUI
import RealityKit
import ARKit

struct PutObjectView: View {
    var body: some View {
        PutObjectARViewARViewContainer()
            .ignoresSafeArea(.all)
    }
}



struct PutObjectARViewARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> PutObjectARView {
        
        let arView = PutObjectARView(frame: .zero)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: PutObjectARView, context: Context) {}
    
}
