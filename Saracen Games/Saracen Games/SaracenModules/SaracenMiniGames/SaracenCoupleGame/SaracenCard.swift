//
//  Card.swift
//  Saracen Games
//
//  Created by Dias Atudinov on 07.05.2025.
//


import Foundation

struct SaracenCard: Identifiable {
    let id = UUID()
    let type: String
    var isFaceUp = false
    var isMatched = false
}
