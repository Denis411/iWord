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

final class ListOfTranslationsView: CommonView {
    private let translationTextView = ResizableTextView(maximumHeight: 90)
    private let tableView = LexicalUnitCreationTableView()
    private var onAddTranslationForPartOfSpeech: ((ListOfTranslationsOfPartOfSpeech) -> Void)?
    private var onRemoveTranslationForPartOfSpeech: ((IndexPath) -> Void)?

    override func setUpUI() {
        addAllSubviews()
        addAllConstraints()
        configureAllSubviews()
    }

    func makeTextViewFirstResponder() {
        translationTextView.becomeFirstResponder()
    }

    func updateListOfTranslations(translations: [ListOfTranslationsOfPartOfSpeech]) {
        tableView.updateListOfTranslations(translations: translations)
    }

    func setonAddTranslationForPartOfSpeechAction(_ action: @escaping (ListOfTranslationsOfPartOfSpeech) -> Void) {
        self.onAddTranslationForPartOfSpeech = action
    }

    func setOnRemoveTranslationForPartOfSpeech(_ action: @escaping (IndexPath) -> Void) {
        self.tableView.setOnRemoveTranslationForPartOfSpeech(action)
    }

    func setOnChangePartOfSpeechForCellAction(_ action: @escaping (IndexPath) -> Void) {
        self.tableView.setOnChangePartOfSpeechForCellAction(action)
    }
}

extension ListOfTranslationsView {
    private func addAllSubviews() {
        self.addSubview(translationTextView)
        self.addSubview(tableView)
    }

    private func addAllConstraints() {
        setTranslationTextViewConstraints()
        addTableViewTranslationConstraints()
    }

    private func configureAllSubviews() {
        configureTranslationTextView()
    }
}

extension ListOfTranslationsView {
    private func setTranslationTextViewConstraints() {
        translationTextView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }

    private func addTableViewTranslationConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(translationTextView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func configureTranslationTextView() {
        translationTextView.backgroundColor = .blue
        translationTextView.addMainActionToolBarWithButton(button: "Add")
    }
}

// MARK: - Action on UIToolBar add button tap -
extension ListOfTranslationsView: UITextViewToolBarButtonAction {
    func setOnToolBarButtonAction(sender: UITextView) {
        if sender === translationTextView {
            let translation = ListOfTranslationsOfPartOfSpeech(partOfSpeech: .notSet, listOfTranslations: [sender.text])
            onAddTranslationForPartOfSpeech?(translation)
        }
    }
}
