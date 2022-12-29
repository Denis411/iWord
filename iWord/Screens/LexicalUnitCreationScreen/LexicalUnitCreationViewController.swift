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

import UIKit
import Combine

protocol LexicalUnitCreationViewModel {
    var newLexicalUnitModel: CurrentValueSubject<LexicalUnit, Never> { get }
    func addOriginalLexicalUnit(text: String)
    func addPrimaryTranslation(translation: PrimaryTranslation)
    func addDescription(description: String)
    func addTranslationForPartOfSpeech(translations: ListOfTranslationsOfPartOfSpeech)
    func removeTranslationForPartOfSpeech(at indexPath: IndexPath)
    func changePartOfSpeechForTranslation(at indexPath: IndexPath)
    func likeUnit()
    func unlikeUnit()
    func recordHumanVoice()
    func playHumanVoiceRecording()
    func addImages(images: [Data])
    func saveNewLexicalUnitModel(to folder: FolderName)
}

class LexicalUnitCreationViewController: UIViewController {
    var mainView: LexicalUnitCreationView { view as! LexicalUnitCreationView }
    let viewModel: LexicalUnitCreationViewModel
    private var disposedBag = Set<AnyCancellable>()

    init(viewModel: LexicalUnitCreationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = LexicalUnitCreationView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setMainViewActions()
        bind()
    }
}

extension LexicalUnitCreationViewController {
    private func bind() {
        bindListOfTranslations()
    }

    private func bindListOfTranslations() {
        viewModel.newLexicalUnitModel
            .receive(on: RunLoop.main)
            .sink { [unowned self] lexicalUnit in
                let translations = lexicalUnit.translationsForPartOfSpeech
                self.mainView.updateListOfTranslations(translations: translations)
            }
            .store(in: &disposedBag)
    }
}

// MARK: - MainView actions -
extension LexicalUnitCreationViewController {
    private func setMainViewActions() {
        setActionForPlayingHumanVoice()
        setActionForRecordingHumanVoice()
        setActionForAddingTranslationForPartOfSpeechAction()
        setRemoveTranslationForPartOfSpeech()
        setOnChangePartOfSpeechForCellAction()
    }

    private func setActionForPlayingHumanVoice() {
        mainView.setActionForPlayAudioButton { [unowned self] in
            self.viewModel.playHumanVoiceRecording()
        }
    }

    private func setActionForRecordingHumanVoice() {
        mainView.setActionForRecordAudioButton { [unowned self] in
            self.viewModel.recordHumanVoice()
        }
    }

    private func setActionForAddingTranslationForPartOfSpeechAction() {
        mainView.setOnAddTranslationForPartOfSpeechAction { [unowned self] listOfTranslations in
            self.viewModel.addTranslationForPartOfSpeech(translations: listOfTranslations)
        }
    }

    private func setRemoveTranslationForPartOfSpeech() {
        mainView.removeTranslationForPartOfSpeech { [unowned self] indexPath in
            self.viewModel.removeTranslationForPartOfSpeech(at: indexPath)
        }
    }

    private func setOnChangePartOfSpeechForCellAction() {
        mainView.setOnChangePartOfSpeechForCellAction { [unowned self] indexPath in
            self.viewModel.changePartOfSpeechForTranslation(at: indexPath)
        }
    }
}
