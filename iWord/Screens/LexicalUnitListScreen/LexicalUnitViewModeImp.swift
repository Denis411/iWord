// Data of creation: 27/12/22
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

protocol LexicalUnitViewModel {
    var unitModels: CurrentValueSubject<[LexicalUnit], Never> { get }
    func loadUnitsFromDataBase(for folder: FolderName)
    func deleteLexicalUnit(at index: IndexPath)
    func appendLexicalUnit()
}

final class LexicalUnitViewModelImp {
//    private let router: MainRouter
    private let lexicalUnitContainer: LexicalUnitContainer
    var unitModels: CurrentValueSubject<[LexicalUnit], Never> {
        lexicalUnitContainer.lexicalUnitModels
    }

    init(
//        router: MainRouter,
        lexicalUnitContainer: LexicalUnitContainer
    ) {
//        self.router = router
        self.lexicalUnitContainer = lexicalUnitContainer
    }
}

extension LexicalUnitViewModelImp: LexicalUnitViewModel {
    func loadUnitsFromDataBase(for folder: FolderName) {
        lexicalUnitContainer.loadUnitsFromDataBase(for: folder)
    }

    func deleteLexicalUnit(at index: IndexPath) {
        lexicalUnitContainer.deleteUnitModel(at: index.row)
    }

    func appendLexicalUnit() {
        let primaryTranslation = PrimaryTranslation(partOfSpeech: .noun, translation: "Primary translation")

        let newLexicalUnit = LexicalUnit(
            originalLexicalUnit: "Original work",
            primaryTranslation: primaryTranslation,
            description: "Description",
            translations: [.noun: ["None"]],
            isPinned: false,
            isFavorite: false,
            humanVoiceRecording: nil,
            images: nil,
            progressPercentage: 0,
            dateOfAdding: Date(),
            tries: [.reading: .success(times: 0)]
        )

        lexicalUnitContainer.appendUnitModel(unit: newLexicalUnit)
    }
}
