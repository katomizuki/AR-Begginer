//
//  ImageTrackingView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI

struct ImageTrackingView: View {
    var body: some View {
        ImageTrackingViewContainer().edgesIgnoringSafeArea(.all)
    }
}
struct ImageTrackingViewContainer: UIViewRepresentable {
    typealias UIViewType = ImageTrackingARView
    
    func makeUIView(context: Context) -> ImageTrackingARView {
        let arView = ImageTrackingARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: ImageTrackingARView, context: Context) {
        
    }
}
