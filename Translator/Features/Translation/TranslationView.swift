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
        VStack {
            TranslationTextField("Translate text", text: $viewModel.sourceText)
            Divider()
            TranslationTextField("Translation ...", text: $viewModel.targetText)
            Spacer()
                .frame(maxHeight: 16)
            TranslationSelectLanguageRow(
                sourceLanguge: viewModel.initialSourceLanguage,
                targetLanguage: viewModel.initialTargetLanguage,
                isSwapped: viewModel.isSwapped,
                swapLanguages: viewModel.swapLanguages
            )
            Spacer()

        }.padding(12)
    }

}

struct TranslationSelectLanguageRow: View {
    let sourceLanguge: String
    let targetLanguage: String
    let isSwapped: Bool
    let swapLanguages: () -> Void

    @Namespace private var swapSpace

    var body: some View {
        HStack {
            leadingCard
            swapButton
            trailingCard
        }
        .padding(.vertical)
    }

    @ViewBuilder
    private var leadingCard: some View {
        if !isSwapped { sourceCard } else { targetCard }
    }

    @ViewBuilder
    private var trailingCard: some View {
        if isSwapped { sourceCard } else { targetCard }
    }

    private var sourceCard: some View {
        TranslationCard(sourceLanguge)
            .matchedGeometryEffect(id: "source", in: swapSpace)
    }
    private var targetCard: some View {
        TranslationCard(targetLanguage)
            .matchedGeometryEffect(id: "target", in: swapSpace)

    }

    private var swapButton: some View {
        Button {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.75)) {
                swapLanguages()
            }
        } label: {
            Image(systemName: "arrow.left.arrow.right")
                .font(.title2)
        }.buttonStyle(.glass)
            .padding(.horizontal, 16)
    }

}

struct TranslationTextField: View {
    var placeholder: String
    var text: Binding<String>

    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self.text = text
    }

    var body: some View {
        TextField(placeholder, text: text, axis: .vertical)
            .lineLimit(3...6)
            .frame(maxWidth: .infinity)
            .padding(12)
            .font(.title2)
            .background(
                Color(.secondarySystemBackground),
                in: .rect(cornerRadius: 12)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct TranslationCard: View {
    init(_ text: String) {
        self.text = text
    }
    var text: String
    var body: some View {
        Text(text)
            .font(.title3)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(
                Color(.secondarySystemBackground),
                in: .rect(cornerRadius: 16)
            )
    }
}

#Preview {
    TranslationView()
}

#Preview {
    VStack {
        TranslationTextField("Placeholder", text: .constant(""))
        TranslationTextField("Empty text", text: .constant("Passed text"))
    }.padding()
}

#Preview {
    TranslationCard("Polish")
}
