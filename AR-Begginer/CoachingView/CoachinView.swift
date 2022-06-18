//
//  CoachinView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI

struct CoachingView: View {
    var body: some View {
        CoachingARViewContainer().ignoresSafeArea()
    }
}

struct CoachingARViewContainer: UIViewRepresentable {
    typealias UIViewType = CoachingARView
    func makeUIView(context: Context) -> CoachingARView {
        let arView = CoachingARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: CoachingARView, context: Context) {
    }
    
}
