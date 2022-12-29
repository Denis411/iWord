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

final class LexicalUnitCreationTableViewCell: UITableViewCell {
    static let reusableID = "LexicalUnitTableViewCell"
    private var partOfSpeech: PartOfSpeech = .notSet
    private var translation: String = ""
//  TODO: - Ask UI/UX whether you should make it UITextField
    private let translationTextView = UILabel()
    private let removeButton = UIButton()
    private let partOfSpeechButton = UIButton()
    private var onRemoveAction: EmptyClosure?
    private var onChangePartOfSpeechAction: EmptyClosure?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTranslation(partOfSpeech: PartOfSpeech, translation: String) {
        self.partOfSpeech = partOfSpeech
        self.translation = translation
        self.translationTextView.text = translation
    }

    func setOnRemoveAction(_ action: @escaping EmptyClosure) {
        onRemoveAction = action
    }

    func setChangePartOfSpeechAction(_ action: @escaping EmptyClosure) {
        self.onChangePartOfSpeechAction = action
    }
}

extension LexicalUnitCreationTableViewCell {
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

extension LexicalUnitCreationTableViewCell {
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
        partOfSpeechButton.addTarget(self, action: #selector(performChangePartOfSpeechAction), for: .touchUpInside)
        partOfSpeechButton.layer.cornerRadius = 5
    }
}

extension LexicalUnitCreationTableViewCell {
    @objc private func performRemoveButtonAction() {
        onRemoveAction?()
        self.removeFromSuperview()
    }

    @objc private func performChangePartOfSpeechAction() {
        onChangePartOfSpeechAction?()
    }
}
