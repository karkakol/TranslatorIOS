//
//  TranslationView.swift
//  Translator
//
//  Created by Karol Kakol on 26/07/2026.
//

import SwiftUI

struct TranslationView: View {
    @State private var viewModel = TranslationViewModel()

    var body: some View {
        Text(viewModel.name)
    }
}

#Preview {
    TranslationView()
}
