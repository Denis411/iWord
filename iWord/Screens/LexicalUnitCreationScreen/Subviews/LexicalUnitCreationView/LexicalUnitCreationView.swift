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
    private let originalLexicalUnitTextViewWithTitle = ResizableTexFieldWithTitle(title: "Original unit")
    private let primaryTranslationTextViewWithTitle = ResizableTexFieldWithTitle(title: "Primary translation")
    private let optionalAudioView = OptionalLexicalUnitAudioView()
    private let optionalDescriptionView = OptionalLexicalUnitDescriptionView()
    private let optionalListOfTranslations = OptionalTranslationForPartOfSpeechView()
    private let optionalExampleView = OptionalLexicalUnitCreationExampleView()
    private let optionalPictureCollectionView = OptionalLexicalUnitPicturesView()

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
        optionalAudioView.setActionForRecordAudioButton(action)
    }

    func setActionForPlayAudioButton(_ action: @escaping EmptyClosure) {
        optionalAudioView.setActionForPlayAudioButton(action)
    }

    func updateListOfTranslations(translations: [ListOfTranslationsOfPartOfSpeech]) {
        optionalListOfTranslations.updateListOfTranslations(translations: translations)
    }

    func setOnAddTranslationForPartOfSpeechAction(action: @escaping SecondaryTranslationClosure) {
        optionalListOfTranslations.setonAddTranslationForPartOfSpeechAction(action)
    }

    func removeTranslationForPartOfSpeech(action: @escaping ClosureWithIndexPath) {
        optionalListOfTranslations.setOnRemoveTranslationForPartOfSpeech(action)
    }

    func setOnChangePartOfSpeechForCellAction(action: @escaping (IndexPath, PartOfSpeech) -> Void) {
        optionalListOfTranslations.setOnChangePartOfSpeechForCellAction(action)
    }

// MARK: - ExampleView actions -

    func setOnAddExampleActions(_ action: @escaping (Example) -> Void) {
        optionalExampleView.setOnAddExampleActions(action)
    }

    func updateArrayOfExamples(_ examples: [Example]) {
        optionalExampleView.updateArrayOfExamples(examples)
    }

    func removeExampleAction(_ action: @escaping ClosureWithIndexPath) {
        optionalExampleView.setOnRemoveExampleAction(action)
    }

// MARK: - Optional actions -
    func setImages(_ images: [UIImage]) {
        optionalPictureCollectionView.setImages(images)
    }

    func setOnRemoveImageActionAtIndexPath(_ action: @escaping ClosureWithIndexPath) {
        optionalPictureCollectionView.setOnRemoveImageActionAtIndexPath(action)
    }

    func setOnAddNewPictureAction(_ action: @escaping EmptyClosure) {
        optionalPictureCollectionView.setOnAddNewPictureAction(action)
    }
}

extension LexicalUnitCreationView {
    private func addAllSubviews() {
        self.addSubview(containerView)
        containerView.addSubview(originalLexicalUnitTextViewWithTitle)
        containerView.addSubview(primaryTranslationTextViewWithTitle)
        containerView.addSubview(optionalAudioView)
        containerView.addSubview(optionalDescriptionView)
        containerView.addSubview(optionalListOfTranslations)
        containerView.addSubview(optionalExampleView)
        containerView.addSubview(optionalPictureCollectionView)
    }

    private func setAllConstraints() {
        addContainerViewConstraints()
        setOriginalLexicalUnitTextViewWithTitleConstraints()
        setPrimaryTranslationTextViewWithTitleConstraints()
        setOptionalAudioViewConstraints()
        setLexicalDescriptionConstraints()
        setListOfTranslationsConstraints()
        setExampleView()
        setPictureCollectionViewConstraints()
    }

    private func configureAllSubviews() {
        configureSelf()
        configureOriginalLexicalUnitTextViewWithTitle()
        configurePrimaryTranslationTextView()
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

    private func setOriginalLexicalUnitTextViewWithTitleConstraints() {
        originalLexicalUnitTextViewWithTitle.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
    }

//  TODO: - rename to setPrimaryTranslationTextViewWithTitleConstraints -
    private func setPrimaryTranslationTextViewWithTitleConstraints() {
        primaryTranslationTextViewWithTitle.snp.makeConstraints { make in
            make.top.equalTo(originalLexicalUnitTextViewWithTitle.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }

    private func setOptionalAudioViewConstraints() {
        optionalAudioView.snp.makeConstraints { make in
            make.top.equalTo(primaryTranslationTextViewWithTitle.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }

    private func setLexicalDescriptionConstraints() {
        optionalDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(optionalAudioView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
    }

    private func setListOfTranslationsConstraints() {
        optionalListOfTranslations.snp.makeConstraints { make in
            make.top.equalTo(optionalDescriptionView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
    }

    private func setExampleView() {
        optionalExampleView.snp.makeConstraints { make in
            make.top.equalTo(optionalListOfTranslations.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
    }

    private func setPictureCollectionViewConstraints() {
        optionalPictureCollectionView.snp.makeConstraints { make in
            make.top.equalTo(optionalExampleView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().priority(1000)
        }
    }

// MARK: - Subview configurations -
    private func configureSelf() {
        self.backgroundColor = .gray
        self.insetsLayoutMarginsFromSafeArea = true
    }

    private func configureOriginalLexicalUnitTextViewWithTitle() {
        originalLexicalUnitTextViewWithTitle.addMainActionToolBarWithButton(button: "Next")
    }

    private func configurePrimaryTranslationTextView() {
        primaryTranslationTextViewWithTitle.addMainActionToolBarWithButton(button: "Next")
    }
}

extension LexicalUnitCreationView: UITextViewToolBarButtonAction {
    func setOnToolBarButtonAction(sender: UITextView) {
        switch sender {
        case originalLexicalUnitTextViewWithTitle.getTextFieldReference():
            finishEditingOriginalLexicalUnit()
        case primaryTranslationTextViewWithTitle.getTextFieldReference():
            finishEditingPrimaryTranslation()
        case optionalDescriptionView.getTextFieldReference():
            finishEditingLexicalDescription()
        default:
            return
        }
    }

    private func finishEditingOriginalLexicalUnit() {
        primaryTranslationTextViewWithTitle.makeTextViewFirstResponder()
    }

    private func finishEditingPrimaryTranslation() {
        optionalDescriptionView.makeTextViewFirstResponder()
    }

    private func finishEditingLexicalDescription() {
        optionalListOfTranslations.makeTextViewFirstResponder()
    }
}
