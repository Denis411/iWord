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

    func removeTranslationForPartOfSpeech(at indexPath: IndexPath) {
        let translationsForPartOfSpeechIndex = indexPath.section
        let concreteTranslationIndex = indexPath.row

        newLexicalUnitModel.value.translationsForPartOfSpeech[translationsForPartOfSpeechIndex].listOfTranslations.remove(at: concreteTranslationIndex)

        removeTranslationForPartOfSpeechIfNeeded(at: translationsForPartOfSpeechIndex)
    }

    func changePartOfSpeechForTranslation(at indexPath: IndexPath) {
//       user router to open a screen where you can choose a new part of speech, after that update value of subject
        let newPartOfSpeech = PartOfSpeech.noun
        let translationsForPartOfSpeechIndex = indexPath.section
        let indexOfTranslationToChange = indexPath.row

        let translationToRelocate = newLexicalUnitModel.value.translationsForPartOfSpeech[translationsForPartOfSpeechIndex].listOfTranslations[indexOfTranslationToChange]
//      remove from old place
        newLexicalUnitModel.value.translationsForPartOfSpeech[translationsForPartOfSpeechIndex].listOfTranslations.remove(at: indexOfTranslationToChange)

        guard let index = findIndexIfExists(for: newPartOfSpeech) else {
            let newElement = ListOfTranslationsOfPartOfSpeech(
                partOfSpeech: newPartOfSpeech, listOfTranslations: [translationToRelocate]
            )

            newLexicalUnitModel.value.translationsForPartOfSpeech.append(newElement)
            removeTranslationForPartOfSpeechIfNeeded(at: translationsForPartOfSpeechIndex)
            return
        }

        newLexicalUnitModel.value.translationsForPartOfSpeech[index].listOfTranslations.append(translationToRelocate)
        removeTranslationForPartOfSpeechIfNeeded(at: translationsForPartOfSpeechIndex)
    }

    private func findIndexIfExists(for partOfSpeech: PartOfSpeech) -> Int? {
        for (index, element) in newLexicalUnitModel.value.translationsForPartOfSpeech.enumerated() where element.partOfSpeech == partOfSpeech {
            return index
        }

        return nil
    }

    private func removeTranslationForPartOfSpeechIfNeeded(at index: Int) {
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
