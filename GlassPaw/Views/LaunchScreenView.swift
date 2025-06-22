//
//  LaunchScreenView.swift
//  GlassPaw
//
//  Created by Kevin Montemayor on 6/20/25.
//

import SwiftUI

@available(iOS 26.0, *)
struct LaunchScreenView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Image("GlassPawBackgroundDark")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                Image("GlassPawBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
