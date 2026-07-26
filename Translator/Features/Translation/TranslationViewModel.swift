//
//  TranslationViewModel.swift
//  Translator
//
//  Created by Karol Kakol on 26/07/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class TranslationViewModel {
    var name = "TranslationViewModel"
    var sourceText = ""
    var targetText = ""
    var sourceLanguage = "Polish"
    var targetLanguage = "English"
    var initialSourceLanguage = "Polish"
    var initialTargetLanguage = "English"

    var isSwapped: Bool {
        sourceLanguage != initialSourceLanguage
    }

    func swapLanguages() {
        swap(&sourceLanguage, &targetLanguage)
    }
}
