//
//  LightView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/21.
//

import SwiftUI

struct LightView: View {
    var body: some View {
        VStack {
            LightARViewContainer()
                .ignoresSafeArea(.all)
        }
    }
}

struct LightARViewContainer: UIViewRepresentable {
    typealias UIViewType = LightARView
    
    func makeUIView(context: Context) -> LightARView {
        let arView = LightARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: LightARView, context: Context) {
        
    }
}
