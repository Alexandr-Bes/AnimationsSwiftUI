//
//  AnimationModel.swift
//  AnimationsSwiftUI
//
//  Created by AlexBezkopylnyi on 07.08.2023.
//

import Foundation

enum AnimationType {
    case linear
    case easeIn
    case easeOut
    case easeInOut
    case spring
    case interpolatingSpring
    
    var name: String {
        switch self {
        case .linear:
            return "Linear"
        case .easeIn:
            return "Ease In"
        case .easeOut:
            return "Ease Out"
        case .easeInOut:
            return "Ease In-Out"
        case .spring:
            return "Spring"
        case .interpolatingSpring:
            return "Interpolating Spring"
        }
    }
}

struct AnimationModel: Identifiable {
    let id = UUID()
    var type: AnimationType
    var duration: Double
}

let AnimationsData = [
    AnimationModel(type: .linear, duration: 2.0)
]
