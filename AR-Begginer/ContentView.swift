//
//  ContentView.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/10.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
       
        ListView()
            .onAppear {
                check()
            }
    }
    
    private func check() {
        print(!ARGeoTrackingConfiguration.isSupported)
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
                    
                    NavigationLink {
                        LightView()
                    } label: {
                        Text("Light")
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
                        EnviromentTextureView()
                    } label: {
                        Text("環境テクスチャマッピング")
                    }
                    NavigationLink {
                        EnviromentTextureView()
                    } label: {
                        Text("コリジョン")
                    }
                } header: {
                    Text("それ以外")
                }

                Section {
                    NavigationLink {
                        CardFlipView()
                    } label: {
                        Text("CardFlip")
                    }
                } header: {
                    Text("アプリ")
                }
            }.navigationBarHidden(false)
                .navigationTitle("RealityKit Beginner app")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
