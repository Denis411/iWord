// Data of creation: 28/12/22
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

final class LexicalUnitCreationTranslationsForPartOfSpeechCell: UITableViewCell {
    static let reusableID = "LexicalUnitTableViewCell"
//  TODO: - Ask UI/UX whether you should make it UITextField
    private let translationTextView = UILabel()
    private let removeButton = UIButton()
    private let partOfSpeechButton = ButtonWithPartOfSpeechMenu()
    private var onRemoveAction: EmptyClosure?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTranslation(translation: String) {
        self.translationTextView.text = translation
    }

    func setOnRemoveAction(_ action: @escaping EmptyClosure) {
        onRemoveAction = action
    }

    func setChangePartOfSpeechAction(_ action: @escaping (PartOfSpeech) -> Void) {
        partOfSpeechButton.setOnChoosePartOfSpeechAction(action)
    }
}

extension LexicalUnitCreationTranslationsForPartOfSpeechCell {
    private func setUpUI() {
        addAllSubviews()
        setAllConstraints()
        configureAllSubviews()
    }

    private func addAllSubviews() {
        translationTextView.numberOfLines = 0
        contentView.addSubview(translationTextView)
        contentView.addSubview(removeButton)
        contentView.addSubview(partOfSpeechButton)
    }

    private func setAllConstraints() {
        setTranslationTextFieldConstraints()
        setRemoveButtonConstraints()
        addPartOfSpeechButtonConstraints()
    }

    private func configureAllSubviews() {
        configureRemoveButton()
        configurePartOfSpeechButton()
    }
}

extension LexicalUnitCreationTranslationsForPartOfSpeechCell {
// MARK: - Subview constraints -
    private func setTranslationTextFieldConstraints() {
        translationTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
    }

    private func setRemoveButtonConstraints() {
        removeButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
            make.height.width.equalTo(20)
        }
    }

    private func addPartOfSpeechButtonConstraints() {
        partOfSpeechButton.snp.makeConstraints { make in
            make.top.equalTo(removeButton.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(10)
            make.height.width.equalTo(20)
        }
    }

// MARK: - Subview configurations -
    private func configureRemoveButton() {
        removeButton.backgroundColor = .red
        let image = UIImage(systemName: "xmark")
        removeButton.setImage(image, for: .normal)
        removeButton.addTarget(self, action: #selector(performRemoveButtonAction), for: .touchUpInside)
        removeButton.layer.cornerRadius = 5
    }

    private func configurePartOfSpeechButton() {
        partOfSpeechButton.backgroundColor = .orange
        let image = UIImage(systemName: "plus.fill")
        partOfSpeechButton.setImage(image, for: .normal)
        partOfSpeechButton.layer.cornerRadius = 5
    }
}

extension LexicalUnitCreationTranslationsForPartOfSpeechCell {
    @objc private func performRemoveButtonAction() {
        onRemoveAction?()
        self.removeFromSuperview()
    }
}
