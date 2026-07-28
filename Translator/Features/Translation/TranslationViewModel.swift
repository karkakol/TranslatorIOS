//
//  TranslationViewModel.swift
//  Translator
//
//  Created by Karol Kakol on 26/07/2026.
//

import Foundation
import Observation
import Translation

@MainActor
@Observable
final class TranslationViewModel {
    var name = "TranslationViewModel"
    var sourceText = "" {
        didSet {
            debounceTranslate()
        }
    }
    var targetText = ""
    var initialSourceLanguage = Locale.Language(identifier: "pl")
    var initialTargetLanguage = Locale.Language(identifier: "en")
    var sourceLanguage = Locale.Language(identifier: "pl")
    var targetLanguage = Locale.Language(identifier: "en")
    var configuration: TranslationSession.Configuration?

    private var translateTask: Task<Void, Never>?

    var isSwapped: Bool {
        sourceLanguage != initialSourceLanguage
    }

    func swapLanguages() {
        swap(&sourceLanguage, &targetLanguage)
        (sourceText, targetText) = (targetText, sourceText)
    }

    func debounceTranslate() {
        translateTask?.cancel()

        if sourceText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            debugPrint("Source text is empty")
            targetText = ""
            return
        }

        translateTask = Task { [weak self] in
            do {
                try await Task.sleep(for: .milliseconds(300))
            } catch {
                return
            }
            await self?.translate()
        }
    }

    func translate() async {
        let newConfig = TranslationSession.Configuration(
            source: sourceLanguage,
            target: targetLanguage
        )

        if configuration == newConfig {
            configuration?.invalidate()
        } else {
            configuration = newConfig
        }
    }

    func performTranslation(using session: TranslationSession) async {
        do {
            let response = try await session.translate(sourceText)
            targetText = response.targetText
        } catch {
            targetText = error.localizedDescription
        }
    }
}
