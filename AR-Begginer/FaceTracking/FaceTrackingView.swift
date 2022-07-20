//
//  FaceTrackingView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI

struct FaceTracking: View {
    var body: some View {
        FaceTrackingContainerView().edgesIgnoringSafeArea(.all)
    }
}
struct FaceTrackingContainerView: UIViewRepresentable {
    typealias UIViewType = FaceTrackingARView
    
    func makeUIView(context: Context) -> FaceTrackingARView {
        let arView = FaceTrackingARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: FaceTrackingARView, context: Context) {
        
    }
}
