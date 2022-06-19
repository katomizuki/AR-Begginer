//
//  Bones.swift
//  AR-Begginer
//
//  Created by ミズキ on 2022/06/20.
//

import Foundation
enum Bones: CaseIterable {
    case leftShoulderJoint
    case leftArmJoint
    case leftForearmJoint
    
    var name: String {
        return "\(self.jointFromName)-\(self.jointToName)"
    }
    
    var jointFromName: String {
        switch self {
        case .leftShoulderJoint:
            return "left_shoulder_1_joint"
        case .leftArmJoint:
            return "left_arm_joint"
        case .leftForearmJoint:
            return "left_forearm_joint"
        }
    }
    
    var jointToName: String {
        switch self {
        case .leftArmJoint:
            return "left_arm_joint"
        case .leftForearmJoint:
            return "left_forearm_joint"
        case .leftShoulderJoint:
            return "left_hand_joint"
            
        }
    }
}
