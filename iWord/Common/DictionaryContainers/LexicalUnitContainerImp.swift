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
import Combine

protocol LexicalUnitContainer {
    var lexicalUnitModels: CurrentValueSubject<[LexicalUnit], Never> { get }
    func loadUnitsFromDataBase(for folder: FolderName)
    func deleteUnitModel(at index: Int)
    func deleteUnitModels(at indexes: [Int])
    func appendUnitModel(unit: LexicalUnit)
    func saveAllChanges()
}

final class LexicalUnitContainerImp: LexicalUnitContainer {
    private let errorAlert: ErrorAlert
    private var workingFolderName: FolderName = ""
    var lexicalUnitModels = CurrentValueSubject<[LexicalUnit], Never>([])

    init(errorAlert: ErrorAlert) {
        self.errorAlert = errorAlert
    }

    func loadUnitsFromDataBase(for folder: FolderName) {
        workingFolderName = folder
        #if DEBUG
        let fakeUnitModels = getFakeLexicalUnitModels()
        lexicalUnitModels.value = fakeUnitModels
        return
        #endif
        lexicalUnitModels.value = []
    }

    func deleteUnitModel(at index: Int) {
        lexicalUnitModels.value.remove(at: index)
    }

    func deleteUnitModels(at indexes: [Int]) {
        indexes.forEach { [unowned self] index in
            self.deleteUnitModel(at: index)
        }
    }

    func appendUnitModel(unit: LexicalUnit) {
        let doesUnitAlreadyExist = doesLexicalUnitExist(unit)
        if doesUnitAlreadyExist {
            Log.warning("Lexical unit cannot be added cuz it already exists")
            errorAlert.presentAlert(with: "Lexical unit cannot be added cuz it already exists")
            return
        }
        lexicalUnitModels.value.append(unit)
    }

    func saveAllChanges() {
//        use data base layer to save edited list of units if needed
//        this class is supposed to be used as a CoreData container so changes are not saved automatically
    }
}

extension LexicalUnitContainerImp {
    private func doesLexicalUnitExist(_ unit: LexicalUnit) -> Bool {
        lexicalUnitModels.value.contains { lexicalUnit in
            lexicalUnit == unit
        }
    }
}

struct LexicalUnit: Equatable, Hashable {
    let originalLexicalUnit: String
    let primaryTranslation: PrimaryTranslation
    let translations: [PartOfSpeech: [String]]
    let isPinned: Bool
    let isFavorite: Bool
    let humanVoiceRecording: Data?
    let images: [Data]?
    let progressPercentage: UInt8
    let dateOfAdding: Date
    let tries: [Exercise: TryResults]

    static func == (lhs: LexicalUnit, rhs: LexicalUnit) -> Bool {
        lhs.originalLexicalUnit == rhs.originalLexicalUnit
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(originalLexicalUnit)
    }
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

// TODO: - Add dates to times before publishing to AppStore -
enum TryResults {
    case success(times: Int)
    case failure(times: Int)
}

fileprivate func getFakeLexicalUnitModels() -> [LexicalUnit] {
    let primaryTranslation = PrimaryTranslation(partOfSpeech: .noun, translation: "猫")
    let translations: [PartOfSpeech : [String]] = [ .noun : ["猫", "恶妇"]]
    let tries: [Exercise : TryResults] = [.reading : .success(times: 5)]
    
    let singleLexicalUnitModel = LexicalUnit(
        originalLexicalUnit: "Cat",
        primaryTranslation: primaryTranslation,
        translations: translations,
        isPinned: Bool.random(),
        isFavorite: Bool.random(),
        humanVoiceRecording: nil,
        images: nil,
        progressPercentage: 0,
        dateOfAdding: Date(),
        tries: tries
    )

    return [singleLexicalUnitModel]
}
