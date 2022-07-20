//
//  PostProcessingView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI

struct PostProcessingView: View {
    var body: some View {
        VStack {
            PostProcessingViewContainer().edgesIgnoringSafeArea(.all)
        }
    }
}

struct PostProcessingViewContainer: UIViewRepresentable {
    typealias UIViewType = PostProcessingARView
    
    func makeUIView(context: Context) -> PostProcessingARView {
        let arView = PostProcessingARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: PostProcessingARView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator {
        var parent: PostProcessingViewContainer
        init(_ parent: PostProcessingViewContainer) {
            self.parent = parent
        }
    }
}
