//
//  Extensions.swift
//  AnimationsSwiftUI
//
//  Created by AlexBezkopylnyi on 07.08.2023.
//

import SwiftUI

extension View {
    func animate(duration: CGFloat, _ execute: @escaping () -> Void) async {
        await withCheckedContinuation { continuation in
            withAnimation(.linear(duration: duration)) {
                execute()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                continuation.resume()
            }
        }
    }
}
