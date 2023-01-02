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

final class LexicalUnitCreationView: UIScrollView {
    private let containerView = UIView()
    private let primaryTranslationTextViewWithTitle = ResizableTexFieldWithTitle(title: "Primary translation")
    private let audioButtonsStackView = UIStackView()
    private let recordAudioButton = LexicalUnitCreationAudioButton()
    private let playAudioButton = LexicalUnitCreationAudioButton()
    private let lexicalDescriptionTextViewWithTitle = ResizableTexFieldWithTitle(title: "Description")
    private let listOfTranslations = ListOfTranslationsView()
    private let exampleView = LexicalUnitCreationExampleView()

    init() {
        super.init(frame: .zero)
        setUpUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpUI() {
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

    func setOnAddTranslationForPartOfSpeechAction(action: @escaping SecondaryTranslationClosure) {
        listOfTranslations.setonAddTranslationForPartOfSpeechAction(action)
    }

    func removeTranslationForPartOfSpeech(action: @escaping ClosureWithIndexPath) {
        listOfTranslations.setOnRemoveTranslationForPartOfSpeech(action)
    }

    func setOnChangePartOfSpeechForCellAction(action: @escaping (IndexPath, PartOfSpeech) -> Void) {
        listOfTranslations.setOnChangePartOfSpeechForCellAction(action)
    }

// MARK: - ExampleView actions

    func setOnAddExampleActions(action: @escaping EmptyClosure) {
        exampleView.setOnAddExampleActions(action)
    }

    func updateArrayOfExamples(examples: [Example]) {
        exampleView.updateArrayOfExamples(examples)
    }

    func removeExampleAction(action: @escaping ClosureWithIndexPath) {
        exampleView.setOnRemoveExampleAction(action: action)
    }
}

extension LexicalUnitCreationView {
    private func addAllSubviews() {
        self.addSubview(containerView)
        containerView.addSubview(primaryTranslationTextViewWithTitle)
        containerView.addSubview(audioButtonsStackView)
        audioButtonsStackView.addArrangedSubview(recordAudioButton)
        audioButtonsStackView.addArrangedSubview(playAudioButton)
        containerView.addSubview(lexicalDescriptionTextViewWithTitle)
        containerView.addSubview(listOfTranslations)
        containerView.addSubview(exampleView)
    }

    private func setAllConstraints() {
        addContainerViewConstraints()
        setResizableTextViewConstraints()
        setAudioButtonsStackViewConstraints()
        setLexicalDescriptionConstraints()
        setListOfTranslationsConstraints()
        setExampleView()
    }

    private func configureAllSubviews() {
        configureSelf()
        configureAudioButtonsStackView()
        configureRecordAudioButton()
        configurePlayAudioButton()
        configurePrimaryTranslationTextView()
        configureLexicalDescriptionConstraints()
    }
}


extension LexicalUnitCreationView {
// MARK: - Constraints -
    private func addContainerViewConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.bottom.top.equalToSuperview()
            make.width.equalTo(self.snp.width)
        }

        containerView.backgroundColor = .orange
    }

    private func setResizableTextViewConstraints() {
        primaryTranslationTextViewWithTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
    }

    private func setAudioButtonsStackViewConstraints() {
        audioButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(primaryTranslationTextViewWithTitle.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    private func setLexicalDescriptionConstraints() {
        lexicalDescriptionTextViewWithTitle.snp.makeConstraints { make in
            make.top.equalTo(audioButtonsStackView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
    }

    private func setListOfTranslationsConstraints() {
        listOfTranslations.snp.makeConstraints { make in
            make.top.equalTo(lexicalDescriptionTextViewWithTitle.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
    }

    private func setExampleView() {
        exampleView.snp.makeConstraints { make in
            make.top.equalTo(listOfTranslations.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
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
        primaryTranslationTextViewWithTitle.addMainActionToolBarWithButton(button: "Next")
    }

    private func configureLexicalDescriptionConstraints() {
        lexicalDescriptionTextViewWithTitle.addMainActionToolBarWithButton(button: "Next")
    }
}

extension LexicalUnitCreationView: UITextViewToolBarButtonAction {
    func setOnToolBarButtonAction(sender: UITextView) {
        switch sender {
        case primaryTranslationTextViewWithTitle.resizableTextView:
            finishEditingPrimaryTranslationTextView()
        case lexicalDescriptionTextViewWithTitle.resizableTextView:
            finishEditingLexicalDescriptionTextView()
        default:
            return
        }
    }

    private func finishEditingPrimaryTranslationTextView() {
        lexicalDescriptionTextViewWithTitle.resizableTextView.becomeFirstResponder()
    }

    private func finishEditingLexicalDescriptionTextView() {
        listOfTranslations.makeTextViewFirstResponder()
    }
}
