//
//  TransitionView.swift
//  AnimationsSwiftUI
//
//  Created by AlexBezkopylnyi on 08.08.2023.
//

import SwiftUI

struct TransitionView: View {
    @State private var showImage = true
    @State private var progress: Double = 0.0
    @State private var buttonText = "Hide image"
    
    private let circleSize: CGFloat = 100.0
    private let imageSize: CGFloat = 40.0

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                GeometryReader { proxy in
                    VStack {
                        activityIndicator()
                        
                        if showImage {
                            transitionImage(height: proxy.size.height)
                        }
                    }
                }
                
                Spacer()
                
                animateButton()
            }
        }
    }

    
    //Activity
    @ViewBuilder private func activityIndicator() -> some View {
        HStack {
            Spacer()
            CircleProgressIndicator(progress: progress)
                .frame(width: circleSize, height: circleSize)
            Spacer()
        }
    }
    
    // Transition Image
    @ViewBuilder private func transitionImage(height: CGFloat) -> some View {
        Image("transitionImage")
            .resizable()
            .renderingMode(.template)
            .frame(width: imageSize, height: imageSize)
            .foregroundColor(Color(hue: 0.74, saturation: 0.847, brightness: 0.957))
            .transition(.falling(yOffset: (height / 3)))
            .modifier(RotateAndAppearModifier())
    }
    
    //Animate Button
    @ViewBuilder private func animateButton() -> some View {
        HStack {
            Spacer()
            AnimateButton(text: buttonText) {
                Task {
                    await animate(duration: 3) {
                        progress = 1.0
                    }

                    withAnimation {
                        showImage.toggle()
                        buttonText = "Success!"
                    }
                }
            }
            .disabled(!showImage)
            
            Spacer()
        }
    }
}


struct TransitionView_Previews: PreviewProvider {
    static var previews: some View {
        TransitionView()
    }
}



struct FallingTransition: ViewModifier {
    @State private var isAnimating = false
    var yOffset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .offset(y: isAnimating ? yOffset : 0)
            .animation(.interpolatingSpring(stiffness: 1, damping: 1).delay(0.5), value: isAnimating)
            .onAppear {
                self.isAnimating = true
            }
    }
}

extension AnyTransition {
    static func falling(yOffset: CGFloat) -> AnyTransition {
        let transition = AnyTransition.modifier(active: FallingTransition(yOffset: yOffset),
                                                identity: FallingTransition(yOffset: yOffset))
        return .asymmetric(insertion: transition, removal: transition)
    }
}


struct RotateAndAppearModifier: ViewModifier {
    @State private var rotationAngle: Double = 0
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(rotationAngle))
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatCount(3, autoreverses: false)) {
                    self.rotationAngle = 360
                }
            }
    }
}

