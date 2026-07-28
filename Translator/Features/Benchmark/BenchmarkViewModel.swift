//
//  BenchmarkViewModel.swift
//  Translator
//
//  Created by Karol Kakol on 26/07/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class BenchmarkViewModel {
    private(set) var polishSentences = [String]()
    
    init(){
        print("Initialized BenchmarkViewModel")
    }

    let plShortUrl = Bundle.main.url(
        forResource: "pl_short",
        withExtension: "csv"
    )

    private var loadTask: Task<Void, Never>?

    //todo try different ways of importing a file
    func readPolishSentences() async {
        guard polishSentences.isEmpty else { return }
        do {
            polishSentences = try String(
                contentsOf: self.plShortUrl!,
                encoding: .utf8
            )
            .split(whereSeparator: \.isNewline)
            .dropFirst()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        } catch {
            print(error)
        }
    }
    
    deinit{
        print("Deinitialized BenchmarkViewModel")
    }
}
