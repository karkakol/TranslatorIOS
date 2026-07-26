//
//  BenchmarkView.swift
//  Translator
//
//  Created by Karol Kakol on 26/07/2026.
//

import SwiftUI

struct BenchmarkView: View {
    @State private var viewModel = BenchmarkViewModel()

    var body: some View {
        Text(viewModel.name)
    }
}

#Preview {
    BenchmarkView()
}
