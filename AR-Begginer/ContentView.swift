//
//  ContentView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/10.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ListView()
    }
}

struct ListView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        PutObjectView()
                    } label: {
                        Text("PutObject")
                    }
                    
                    NavigationLink {
                        StackObjectView()
                    } label: {
                        Text("StackObject")
                    }
                    
                    NavigationLink {
                        MoveObject()
                    } label: {
                        Text("MoveObject")
                    }
                    
                    NavigationLink {
                        ManyMaterialView()
                    } label: {
                        Text("ManyMaterial")
                    }
                } header: {
                    Text("基本")
                }
                
                Section {
                    
                    NavigationLink {
                        RealityComposerView()
                    } label: {
                        Text("RealityComposer")
                    }
                    
                    NavigationLink {
                        CoachingView()
                    } label: {
                        Text("Coaching")
                    }
                } header: {
                    Text("その他")
                }
                
                Section {
                    NavigationLink {
                        ImageTrackingView()
                    } label: {
                        Text("ImageTracking")
                    }
                    
                    NavigationLink {
                        FaceTracking()
                    } label: {
                        Text("FaceTracking")
                    }
                    
                    NavigationLink {
                        BodyTrackingView()
                    } label: {
                        Text("BodyTracking")
                    }
                    
                    NavigationLink {
                        ObjectTrackingView()
                    } label: {
                        Text("ObjectTracking")
                    }
                } header: {
                    Text("トラッキング系")
                }
                
                Section {
                    NavigationLink {
                        PostProcessingView()
                    } label: {
                        Text("PostProcessing")
                    }
                    
                    NavigationLink {
                        MetalView()
                    } label: {
                        Text("MetalView")
                    }
                } header: {
                    Text("Metalなど")
                }

                Section {
                
                    NavigationLink {
                        ARShootingView()
                    } label: {
                        Text("ARShooting")
                    }
                    
                    NavigationLink {
                        CardFlipView()
                    } label: {
                        Text("CardFlip")
                    }
                } header: {
                    Text("アプリ")
                }
            }.navigationBarHidden(true)
                .navigationTitle("RealityKit Beginner app")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}


struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
