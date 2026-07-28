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
        ScrollView{
            Text("Polish sentences").font(.title)
            LazyVStack{
                ForEach(viewModel.polishSentences.enumerated(), id: \.offset ){ index, item in
                    Text("\(index): \(item)").font(.caption2)
                }
            }
        }.task {
            await viewModel.readPolishSentences()
        }
    }
}

#Preview {
    BenchmarkView()
}
