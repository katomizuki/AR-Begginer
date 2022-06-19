//
//  MoveObjectView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/18.
//

import SwiftUI

struct MoveObject: View {
    var body: some View {
        MoveObjectARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct MoveObjectARViewContainer: UIViewRepresentable {
    typealias UIViewType = MoveObjectARView
    func makeUIView(context: Context) -> MoveObjectARView {
        let arView = MoveObjectARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: MoveObjectARView, context: Context) {
    }
    
}
