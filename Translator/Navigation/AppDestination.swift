//
//  AppDestination.swift
//  Translator
//
//  Created by Karol Kakol on 26/07/2026.
//

import SwiftUI

enum AppScreen: String, CaseIterable, Identifiable{
    case translator, benchmark
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .translator: "Translator"
        case .benchmark: "Benchmark"
        }
    }
    
    var systemImage: String {
        switch self{
        case .translator: "character.bubble"
        case .benchmark: "speedometer"
        }
    }
}
