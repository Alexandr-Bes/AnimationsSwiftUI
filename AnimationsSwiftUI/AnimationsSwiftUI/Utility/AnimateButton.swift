//
//  AnimateButton.swift
//  AnimationsSwiftUI
//
//  Created by AlexBezkopylnyi on 14.08.2023.
//

import SwiftUI

struct AnimateButton: View {
    var text: String = "Press to Animate"
    var onSelect: ()->()
    
    var body: some View {
        Button {
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
            
            onSelect()
        } label: {
            Text(text)
                .padding([.top, .bottom], 20)
                .padding([.leading, .trailing], 50)
                .background(.red)
                .foregroundColor(.white)
                .cornerRadius(18)
        }
    }
}

struct AnimateButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimateButton { }
    }
}
