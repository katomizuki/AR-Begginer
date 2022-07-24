//
//  PhysicasView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/07/24.
//

import SwiftUI

struct PhysicsView: View {
    var body: some View {
        
    }
}

struct PhysicsViewContainer: UIViewRepresentable {
    typealias UIViewType = PhysicsARView
    
    func makeUIView(context: Context) -> PhysicsARView {
        let arView = PhysicsARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: PhysicsARView, context: Context) {
        
    }
}
