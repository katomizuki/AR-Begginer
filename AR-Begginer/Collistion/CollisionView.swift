//
//  ARShootingView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI

struct CollisionView: View {
    var body: some View {
        CollisionViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct CollisionViewContainer: UIViewRepresentable {
    typealias UIViewType = CollistionARView
    func makeUIView(context: Context) -> CollistionARView {
        let arView = CollistionARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: CollistionARView, context: Context) {
        
    }
}
