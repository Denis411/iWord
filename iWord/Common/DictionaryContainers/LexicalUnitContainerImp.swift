// Data of creation: 21/12/22
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

protocol LexicalUnitContainer {
    func getAllUnitsInFolder(with name: FolderName) -> [LexicalUnit]
    func deleteUnitsInFolder(in folder: FolderName, units: [LexicalUnit])
    func addUnitToFolder(to folder: FolderName, unit: LexicalUnit)
}

final class LexicalUnitContainerImp: LexicalUnitContainer {
    private var lexicalUnits: [LexicalUnit] = []

    func getAllUnitsInFolder(with name: FolderName) -> [LexicalUnit] {
        return []
    }

    func deleteUnitsInFolder(in folder: FolderName, units: [LexicalUnit]) {

    }

    func addUnitToFolder(to folder: FolderName, unit: LexicalUnit) {

    }
}

struct LexicalUnit {
    let originalLexicalUnit: String
    let translations: [PartOfSpeech: [String]]
    let isPinned: Bool
    let humanVoiceRecording: Data?
    let images: [Data]?
    let progressPercentage: UInt8
    let dateOfAdding: Date
    let tries: [Exercise: TryResults]
}

enum PartOfSpeech {
    case pronoun
    case preposition
    case conjunction
    case noun
    case verb
    case adverb
    case adjective
    case collocation
    case idiom
    case justSentence
    case notSet
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
