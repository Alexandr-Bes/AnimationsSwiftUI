//
//  CircleProgressIndicator.swift
//  AnimationsSwiftUI
//
//  Created by AlexBezkopylnyi on 15.08.2023.
//

import SwiftUI

struct CircleProgressIndicator: View {
    var progress: Double
    var duration: Double = 3
    
    private let gradient = LinearGradient(gradient: Gradient(colors: [.yellow, .blue]),
                                          startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        Circle()
            .trim(from: CGFloat(min(progress, 1.0)), to: 1.0)
            .stroke(gradient, lineWidth: 5)
            .rotationEffect(.degrees(-90))
            .animation(.linear(duration: duration), value: progress)
    }
}

struct CircleProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressIndicator(progress: 1.0)
    }
}
