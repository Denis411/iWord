// Data of creation: 4/1/23
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

typealias SecondaryTranslationClosure = (String, PartOfSpeech) -> Void

final class OptionalListOfTranslationsView: LabelWithOptionalSubview {
    private let verticalStack = UIStackView()
    private let inputTextField = ResizableTextView(maximumHeight: 90)
    private let tableView = LexicalUnitCreationTableView()

    // TODO: - Relocate all textfield actions to superview -
    private var onAddSecondaryTranslation: SecondaryTranslationClosure?

    override init() {
        super.init()
        setUpUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setonAddTranslationForPartOfSpeechAction(_ action: @escaping SecondaryTranslationClosure) {
        self.onAddSecondaryTranslation = action
    }

    func setOnRemoveTranslationForPartOfSpeech(_ action: @escaping ClosureWithIndexPath) {
        self.tableView.setOnRemoveTranslationForPartOfSpeech(action)
    }

    func makeTextViewFirstResponder() {
        inputTextField.becomeFirstResponder()
    }

    func updateListOfTranslations(translations: [ListOfTranslationsOfPartOfSpeech]) {
        tableView.updateListOfTranslations(translations: translations)
    }

    func setOnChangePartOfSpeechForCellAction(_ action: @escaping (IndexPath, PartOfSpeech) -> Void) {
        self.tableView.setOnChangePartOfSpeechForCellAction(action)
    }
}

extension OptionalListOfTranslationsView {
    private func setUpUI() {
        addAllSubviews()
        configureAllSubviews()
    }

    private func addAllSubviews() {
        verticalStack.addArrangedSubview(inputTextField)
        verticalStack.addArrangedSubview(tableView)
        self.addInternalView(view: verticalStack)
    }

    private func configureAllSubviews() {
        configureSelf()
        configureVerticalStack()
        configureTranslationTextView()
    }

    private func configureSelf() {
        self.setTitle(text: "Secondary translations")
    }

    private func configureVerticalStack() {
        verticalStack.axis = .vertical
        verticalStack.spacing = 10
        verticalStack.distribution = .fill
    }

    private func configureTranslationTextView() {
        inputTextField.addMainActionToolBarWithButton(button: "Add")
    }
}

// MARK: - Action on UIToolBar add button tap -
extension OptionalListOfTranslationsView: UITextViewToolBarButtonAction {
    func setOnToolBarButtonAction(sender: UITextView) {
        if sender === inputTextField {
            let enteredTranslation = sender.text ?? ""
            onAddSecondaryTranslation?(enteredTranslation, .notSet)
        }
    }
}
