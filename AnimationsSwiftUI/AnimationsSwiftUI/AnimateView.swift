//
//  AnimateView.swift
//  AnimationsSwiftUI
//
//  Created by AlexBezkopylnyi on 13.05.2023.
//

import SwiftUI

struct AnimateView: View {
    @State var degrees: Double = 0
    @State var location = 0.0
    
    @State var animation: AnimationModel
    
    var currentAnimation: Animation {
        switch animation.type {
        case .linear:
            return Animation.linear(duration: animation.duration)
        case .easeIn:
            return Animation.easeIn(duration: animation.duration)
        case .easeOut:
            return Animation.easeOut(duration: animation.duration)
        case .easeInOut:
            return Animation.easeInOut(duration: animation.duration)
        case .spring:
            return Animation.spring(response: 0.8, dampingFraction: 3.0, blendDuration: 1)
        case .interpolatingSpring:
            return Animation.interpolatingSpring(mass: 1.0, stiffness: 80, damping: 10)
        }
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "paperplane.fill")
                            .imageScale(.large)
                            .foregroundColor(.yellow)
                            .rotationEffect(.degrees(degrees), anchor: .center)
                            .offset(y: -(proxy.size.height) * location * 0.8)
                            .offset(x: proxy.size.width * location * 0.8)
                            .animation(currentAnimation, value: location)
                        Spacer()
                    }
                    .padding()
                    
                    chooseAnimation()
                    animateButton()
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom)
            )
            .navigationBarTitle(animation.type.name + " Animation")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    //Animate Button
    @ViewBuilder private func animateButton() -> some View {
        HStack {
            Spacer()
            Button {
                let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                impactFeedback.impactOccurred()
                
                Task {
                    await animate(duration: animation.duration) {
                        location = location == 0 ? 1 : 0
                    }
                    
                    withAnimation {
                        degrees = degrees == 0 ? 180 : 0
                    }
                }
            } label: {
                Text("Press to Animate")
            }
            .padding([.top, .bottom], 20)
            .padding([.leading, .trailing], 50)
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(18)
            Spacer()
        }
    }
    
    //Choose Animation Type Button
    @ViewBuilder private func chooseAnimation() -> some View {
        Picker("Animation Type", selection: $animation.type) {
            Text("Linear").tag(AnimationType.linear)
            Text("Ease In").tag(AnimationType.easeIn)
            Text("Ease Out").tag(AnimationType.easeOut)
            Text("Ease In-Out").tag(AnimationType.easeInOut)
            Text("Spring").tag(AnimationType.spring)
            Text("Interpolating Spring").tag(AnimationType.interpolatingSpring)
        }
        .colorMultiply(.yellow)
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.brown))
        .padding([.leading, .trailing])
    }
}

struct AnimateView_Previews: PreviewProvider {
    static var previews: some View {
        AnimateView(animation: AnimationsData.first!)
    }
}
