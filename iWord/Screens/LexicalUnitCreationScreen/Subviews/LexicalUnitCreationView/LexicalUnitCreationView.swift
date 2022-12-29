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

final class LexicalUnitCreationView: CommonView {
    private let primaryTranslationTextView = ResizableTextView(maximumHeight: 90)
    private let audioButtonsStackView = UIStackView()
    private let recordAudioButton = LexicalUnitCreationAudioButton()
    private let playAudioButton = LexicalUnitCreationAudioButton()
    private let lexicalDescriptionTextView = ResizableTextView(maximumHeight: 90)
    private let listOfTranslations = ListOfTranslationsView()

    override func setUpUI() {
        addAllSubviews()
        setAllConstraints()
        configureAllSubviews()
    }

    func setActionForRecordAudioButton(_ action: @escaping EmptyClosure) {
        recordAudioButton.setAction(action)
    }

    func setActionForPlayAudioButton(_ action: @escaping EmptyClosure) {
        playAudioButton.setAction(action)
    }

    func updateListOfTranslations(translations: [ListOfTranslationsOfPartOfSpeech]) {
        listOfTranslations.updateListOfTranslations(translations: translations)
    }
}

extension LexicalUnitCreationView {
    private func addAllSubviews() {
        self.addSubview(primaryTranslationTextView)
        self.addSubview(audioButtonsStackView)
        self.audioButtonsStackView.addArrangedSubview(recordAudioButton)
        self.audioButtonsStackView.addArrangedSubview(playAudioButton)
        self.addSubview(lexicalDescriptionTextView)
        self.addSubview(listOfTranslations)
    }

    private func setAllConstraints() {
        setResizableTextViewConstraints()
        setAudioButtonsStackViewConstraints()
        setLexicalDescriptionConstraints()
        setListOfTranslationsConstraints()
    }

    private func configureAllSubviews() {
        configureAudioButtonsStackView()
        configureRecordAudioButton()
        configurePlayAudioButton()
        configureSelf()
        configurePrimaryTranslationTextView()
        configureLexicalDescriptionConstraints()
    }
}


extension LexicalUnitCreationView {
// MARK: - Constraints -
    private func setResizableTextViewConstraints() {
        primaryTranslationTextView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
    }

    private func setAudioButtonsStackViewConstraints() {
        audioButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(primaryTranslationTextView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    private func setLexicalDescriptionConstraints() {
        lexicalDescriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(audioButtonsStackView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
    }

    private func setListOfTranslationsConstraints() {
        listOfTranslations.snp.makeConstraints { make in
            make.top.equalTo(lexicalDescriptionTextView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
    }

// MARK: - Subview configurations -
    private func configureAudioButtonsStackView() {
        audioButtonsStackView.axis = .horizontal
        audioButtonsStackView.spacing = 20
        audioButtonsStackView.distribution = .fillEqually
    }

    private func configureRecordAudioButton() {
        let image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate)
        recordAudioButton.imageView?.tintColor = .red
        recordAudioButton.setImage(image, for: .normal)
    }

    private func configurePlayAudioButton() {
        let image = UIImage(systemName: "play.fill")?.withRenderingMode(.alwaysTemplate)
        playAudioButton.imageView?.tintColor = .green
        playAudioButton.setImage(image, for: .normal)
    }

    private func configureSelf() {
        self.backgroundColor = .gray
        self.insetsLayoutMarginsFromSafeArea = true
    }

    private func configurePrimaryTranslationTextView() {
        primaryTranslationTextView.addMainActionToolBarWithButton(button: "Next")
    }

    private func configureLexicalDescriptionConstraints() {
        lexicalDescriptionTextView.addMainActionToolBarWithButton(button: "Next")
    }
}

extension LexicalUnitCreationView: UITextViewToolBarButtonAction {
    func setOnToolBarButtonAction(sender: UITextView) {
        switch sender {
        case primaryTranslationTextView:
            finishEditingPrimaryTranslationTextView()
        case lexicalDescriptionTextView:
            finishEditingLexicalDescriptionTextView()
        default:
            return
        }
    }

    private func finishEditingPrimaryTranslationTextView() {
        lexicalDescriptionTextView.becomeFirstResponder()
    }

    private func finishEditingLexicalDescriptionTextView() {
        listOfTranslations.makeTextViewFirstResponder()
    }
}
