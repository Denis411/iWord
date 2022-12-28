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
    let translationTextView = ResizableTextView(maximumHeight: 90)
    let stackViewOfTranslations = UIStackView()

    override func setUpUI() {
        addAllSubviews()
        addAllConstraints()
        configureAllSubviews()
    }

    func makeTextViewFirstResponder() {
        translationTextView.becomeFirstResponder()
    }
}

// MARK: - Set up subviews -
extension ListOfTranslationsView {
    private func addAllSubviews() {
        self.addSubview(translationTextView)
        self.addSubview(stackViewOfTranslations)
    }

    private func addAllConstraints() {
        setTranslationTextViewConstraints()
        setStackViewOfTranslationsConstraints()
    }

    private func setTranslationTextViewConstraints() {
        translationTextView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }

    private func setStackViewOfTranslationsConstraints() {
        stackViewOfTranslations.snp.makeConstraints { make in
            make.top.equalTo(translationTextView.snp.bottom).offset(20)
        }
    }

    private func configureAllSubviews() {
        configureTranslationTextView()
        configureStackViewOfTranslations()
    }

    private func configureTranslationTextView() {
        translationTextView.backgroundColor = .blue
        translationTextView.addMainActionToolBarWithButton(button: "Add")
    }

    private func configureStackViewOfTranslations() {
        stackViewOfTranslations.axis = .vertical
        stackViewOfTranslations.alignment = .leading
        stackViewOfTranslations.spacing = 10
    }
}

// MARK: - Action on UIToolBar add button tap -
extension ListOfTranslationsView: UITextViewToolBarButtonAction {
    func setOnToolBarButtonAction(sender: UITextView) {
        if sender === translationTextView {
            performOnToolBarButtonAddAction()
        }
    }

    private func performOnToolBarButtonAddAction() {
        let translationTextField = UITextField()
        translationTextField.text = self.translationTextView.text
        self.stackViewOfTranslations.addArrangedSubview(translationTextField)
        self.translationTextView.text = ""
    }
}
