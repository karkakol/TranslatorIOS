//
//  Navigator.swift
//  Translator
//
//  Created by Karol Kakol on 26/07/2026.
//

import SwiftUI

struct Navigator: View {
    @State private var selection: AppScreen? = .translator
    
    var body: some View {
        NavigationSplitView {
            List(AppScreen.allCases, selection: $selection){ screen in
                Label(screen.title, systemImage: screen.systemImage).tag(screen)
            }
            .navigationTitle("Translator")
            .listStyle(.sidebar)
        } detail: {
            if let selection {
                detailView(for: selection)
                    .navigationTitle(selection.title).navigationBarTitleDisplayMode(.inline)
            } else {
                ContentUnavailableView("Nothing Selected", systemImage: "sidebar.left")
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
    
    @ViewBuilder
    private func detailView(for screen: AppScreen) -> some View {
        switch screen {
        case .translator: TranslationView()
        case .benchmark: BenchmarkView()
        }
    }
    
}

#Preview {
    Navigator()
}
