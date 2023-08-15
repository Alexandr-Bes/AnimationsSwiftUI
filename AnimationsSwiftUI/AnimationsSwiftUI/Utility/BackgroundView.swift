//
//  BackgroundView.swift
//  AnimationsSwiftUI
//
//  Created by AlexBezkopylnyi on 15.08.2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.red, Color.purple]),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
