//
//  StackObjectView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI

struct StackObjectView: View {
    var body: some View {
        StackObjectARViewContainer().ignoresSafeArea()
    }
}

struct StackObjectARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> StackObjectARView {
        
        let arView = StackObjectARView(frame: .zero)
        return arView
        
    }
    
    func updateUIView(_ uiView: StackObjectARView, context: Context) {}
    
}
