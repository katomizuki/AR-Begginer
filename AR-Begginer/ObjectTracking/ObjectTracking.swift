//
//  ObjectTracking.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI
struct ObjectTrackingView: View {
    var body: some View {
        ObjectTrackingARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ObjectTrackingARViewContainer: UIViewRepresentable {
    typealias UIViewType = ObjectTrackingARView
    
    func makeUIView(context: Context) -> ObjectTrackingARView {
        let arView = ObjectTrackingARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: ObjectTrackingARView, context: Context) {
        
    }
}
