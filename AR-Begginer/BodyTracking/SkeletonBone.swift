//
//  SkeletonBone.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/20.
//

import RealityKit

struct SkeletonBone {
    var fromJoint: SkeletonJoint
    var toJoint: SkeletonJoint
    
    var centerPosition: SIMD3<Float> {
        [(fromJoint.position.x + toJoint.position.x) / 2, (fromJoint.position.y + toJoint.position.y) / 2, (fromJoint.position.z + toJoint.position.z) / 2]
    }
}
