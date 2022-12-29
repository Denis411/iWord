// Data of creation: 29/12/22
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

final class LexicalUnitCreationViewModelImp: LexicalUnitCreationViewModel {
    private(set) var newLexicalUnitModel = CurrentValueSubject<LexicalUnit, Never>(.createEmptyLexicalUnit())
}

extension LexicalUnitCreationViewModelImp {
    func addOriginalLexicalUnit(text: String) {
        newLexicalUnitModel.value.originalLexicalUnit = text
    }

    func addPrimaryTranslation(translation: PrimaryTranslation) {
        newLexicalUnitModel.value.primaryTranslation = translation
    }

    func addDescription(description: String) {
        newLexicalUnitModel.value.description = description
    }

    func addTranslationForPartOfSpeech(translations: ListOfTranslationsOfPartOfSpeech) {
        guard let index = findIndexIfExists(for: translations.partOfSpeech) else {
            newLexicalUnitModel.value.translationsForPartOfSpeech.append(translations)
            return
        }

        newLexicalUnitModel.value.translationsForPartOfSpeech[index].listOfTranslations.append(contentsOf: translations.listOfTranslations)
    }

    private func findIndexIfExists(for partOfSpeech: PartOfSpeech) -> Int? {
        for (index, element) in newLexicalUnitModel.value.translationsForPartOfSpeech.enumerated() where element.partOfSpeech == partOfSpeech {
            return index
        }

        return nil
    }

    func likeUnit() {
        newLexicalUnitModel.value.isFavorite = true
    }

    func unlikeUnit() {
        newLexicalUnitModel.value.isFavorite = false
    }

    func recordHumanVoice() {
//       open a manager for recording and return data
//       newLexicalUnitModel.value.humanVoiceRecording = recording
    }

    func playHumanVoiceRecording() {
//       use a manager for playing
    }

    func addImages(images: [Data]) {
        newLexicalUnitModel.value.images?.append(contentsOf: images)
    }

    func saveNewLexicalUnitModel(to folder: FolderName) {
//       save using a data base
    }
}

extension LexicalUnit {
    static func createEmptyLexicalUnit() -> Self {
        let emptyTranslation = PrimaryTranslation(partOfSpeech: .notSet, translation: "")

        return LexicalUnit(
            originalLexicalUnit: "",
            primaryTranslation: emptyTranslation,
            description: "",
            translationsForPartOfSpeech: [],
            isPinned: false,
            isFavorite: false,
            humanVoiceRecording: nil,
            images: nil,
            progressPercentage: 0,
            dateOfAdding: Date(),
            tries: [:]
        )
    }
}
