// Data of creation: 1/1/23
// Create by Denis Ulianov aka Денис Александрович Ульянов
// Using Swift 5.0
// Running on macOS 12.5
//
// Copyrights
//
// I do not allow any person to use this piece of software
// for any purposes. 
// This project and source code may use libraries or frameworks that are
// released under various Open-Source licenses. Use of those libraries and
// frameworks are governed by their own individual licenses.

import Foundation
import UIKit

struct LexicalUnit: Equatable, Hashable {
    var originalLexicalUnit: String
    var primaryTranslation: PrimaryTranslation
    var description: String
    var translationsForPartOfSpeech: [ListOfTranslationsOfPartOfSpeech]
    var examples: [Example]
    var isPinned: Bool
    var isFavorite: Bool
    var humanVoiceRecording: Data?
    var images: [UIImage]?
    var progressPercentage: UInt8
    var dateOfAdding: Date
    var tries: [Exercise: TryResults]

    static func == (lhs: LexicalUnit, rhs: LexicalUnit) -> Bool {
        lhs.originalLexicalUnit == rhs.originalLexicalUnit
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(originalLexicalUnit)
    }
}

struct PrimaryTranslation {
    let partOfSpeech: PartOfSpeech
    let translation: String
}

struct ListOfTranslationsOfPartOfSpeech {
    var partOfSpeech: PartOfSpeech
    var listOfTranslations: [String]
}

enum PartOfSpeech: String, CaseIterable {
    case pronoun
    case preposition
    case conjunction
    case noun
    case verb
    case adverb
    case adjective
    case collocation
    case idiom
    case justSentence = "Just sentence"
    case notSet = "Part of speech is not set"
}

struct Example {
    var origin: String
    var translation: String
}

enum Exercise: Hashable {
    case reading
    case typing
    case listening
    case speaking
    case crossword
}

enum TryResults {
    case success(times: Int)
    case failure(times: Int)
}
