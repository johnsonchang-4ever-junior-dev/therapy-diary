//
//  ContentView.swift
//  a1-s4115492
//
//  Created by Johnson Chang on 2026/8/29.
//

import SwiftUI

struct ContentView: View {

    @State private var showLogo = true

    var body: some View {
        if showLogo {
            LogoMark()
                .frame(maxWidth: 300)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .task {
                    // Wait for 3 seconds
                    try? await Task.sleep(for: .seconds(3))
                    showLogo = false
                }
        } else {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
