//
//  BodyTrackingView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI
import RealityKit

struct BodyTrackingView: View {
    var body: some View {
        BodyTrackingViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

struct BodyTrackingViewContainer: UIViewRepresentable {
    typealias UIViewType = BodyTrackingARView
    func makeUIView(context: Context) -> BodyTrackingARView {
        let arView = BodyTrackingARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: BodyTrackingARView, context: Context) {
        
    }
    
    
}
