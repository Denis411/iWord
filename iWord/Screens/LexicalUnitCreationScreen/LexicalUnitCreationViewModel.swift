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
        let translationsToAdd = translations.listOfTranslations
        let partOfSpeech = translations.partOfSpeech

        addTranslations(translations: translationsToAdd, for: partOfSpeech)
    }

    func removeTranslationForPartOfSpeech(at indexPath: IndexPath) {
        let indexOfPartOfSpeech = indexPath.section
        let indexOfTranslation = indexPath.row

        newLexicalUnitModel.value.translationsForPartOfSpeech[indexOfPartOfSpeech].listOfTranslations.remove(at: indexOfTranslation)

        removePartOfSpeechIfEmpty(at: indexOfPartOfSpeech)
    }

    func changePartOfSpeechForTranslation(at indexPath: IndexPath, newPartOfSpeech: PartOfSpeech) {
        defer {
            let indexOfPartOfSpeech = indexPath.section
            //      remove translation from old place
            self.removeTranslationForPartOfSpeech(at: indexPath)
            //      remove part of speech if it has no translation
            self.removePartOfSpeechIfEmpty(at: indexOfPartOfSpeech)
        }

        //      cash translation
        let translationToRelocate = getTranslationForPartOfSpeech(at: indexPath)
        addTranslations(translations: [translationToRelocate], for: newPartOfSpeech)
    }

    private func getTranslationForPartOfSpeech(at index: IndexPath) -> String {
        let indexOfPartOfSpeech = index.section
        let indexOfTranslation = index.row
        let translation = newLexicalUnitModel.value.translationsForPartOfSpeech[indexOfPartOfSpeech].listOfTranslations[indexOfTranslation]
        return translation
    }

    private func addTranslations(translations: [String], for partOfSpeech: PartOfSpeech) {
        if let index = findIndexIfExists(for: partOfSpeech) {
            newLexicalUnitModel.value.translationsForPartOfSpeech[index].listOfTranslations.append(contentsOf: translations)

        } else {
            let newPartOfSpeech = ListOfTranslationsOfPartOfSpeech(
                partOfSpeech: partOfSpeech, listOfTranslations: translations
            )

            newLexicalUnitModel.value.translationsForPartOfSpeech.append(newPartOfSpeech)
        }
    }

    private func findIndexIfExists(for partOfSpeech: PartOfSpeech) -> Int? {
        for (index, element) in newLexicalUnitModel.value.translationsForPartOfSpeech.enumerated() where element.partOfSpeech == partOfSpeech {
            return index
        }

        return nil
    }

    private func removePartOfSpeechIfEmpty(at index: Int) {
        if newLexicalUnitModel.value.translationsForPartOfSpeech[index].listOfTranslations.isEmpty {
            newLexicalUnitModel.value.translationsForPartOfSpeech.remove(at: index)
        }
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
