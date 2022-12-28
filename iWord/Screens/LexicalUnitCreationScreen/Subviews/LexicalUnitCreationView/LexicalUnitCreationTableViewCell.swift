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
    private let translationTextView = ResizableTextView(maximumHeight: 1000)
    private let removeButton = UIButton()
    private var onRemoveAction: EmptyClosure?

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
}

extension LexicalUnitCreationTableViewCell {
    private func setUpUI() {
        addAllSubviews()
        setAllConstraints()
        configureAllSubviews()
    }

    private func addAllSubviews() {
        contentView.addSubview(translationTextView)
        contentView.addSubview(removeButton)
    }

    private func setAllConstraints() {
        setTranslationTextFieldConstraints()
        setRemoveButtonConstraints()
    }

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

    private func configureAllSubviews() {
        configureRemoveButton()
    }

    private func configureRemoveButton() {
        removeButton.backgroundColor = .red
        let image = UIImage(systemName: "xmark")
        removeButton.setImage(image, for: .normal)
        removeButton.addTarget(self, action: #selector(performRemoveButtonAction), for: .touchUpInside)
        removeButton.layer.cornerRadius = 5
    }
}

extension LexicalUnitCreationTableViewCell {
    @objc private func performRemoveButtonAction() {
        onRemoveAction?()
        self.removeFromSuperview()
    }
}
