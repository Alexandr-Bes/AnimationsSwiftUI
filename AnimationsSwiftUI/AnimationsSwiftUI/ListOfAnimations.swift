//
//  ListOfAnimations.swift
//  AnimationsSwiftUI
//
//  Created by AlexBezkopylnyi on 07.08.2023.
//

import SwiftUI

struct ListOfAnimations: View {
    var animations: [AnimationModel] = AnimationsData
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(animations) { animation in
                    NavigationLink(destination: AnimateView(animation: animation)) {
                        Text("Basic Animations")
                    }
                    NavigationLink(destination: TransitionView()) {
                        Text("Transition Animations")
                    }
                }
            }
            .navigationBarTitle("List of Animations")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ListOfAnimations_Previews: PreviewProvider {
    static var previews: some View {
        ListOfAnimations(animations: AnimationsData)
    }
}
