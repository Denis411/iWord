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

final class LexicalUnitCreationTranslationForPartOfSpeechTableView: UITableView {
    private var listOfTranslations: [ListOfTranslationsOfPartOfSpeech] = []
    private var heightConstraint: NSLayoutConstraint?
    private var onRemoveTranslationForPartOfSpeech: ClosureWithIndexPath?
    private var onChangePartOfSpeechForCellAction: ((IndexPath, PartOfSpeech) -> Void)?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureAllSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        heightConstraint?.constant = contentSize.height
    }

    func updateListOfTranslations(translations: [ListOfTranslationsOfPartOfSpeech]) {
        self.listOfTranslations = translations
        self.reloadData()
    }

    func setOnRemoveTranslationForPartOfSpeech(_ action: @escaping ClosureWithIndexPath) {
        self.onRemoveTranslationForPartOfSpeech = action
    }

    func setOnChangePartOfSpeechForCellAction(_ action: @escaping (IndexPath, PartOfSpeech) -> Void) {
        self.onChangePartOfSpeechForCellAction = action
    }

}

// MARK: - Subview configurations -
extension LexicalUnitCreationTranslationForPartOfSpeechTableView {
    private func configureAllSubviews() {
        configureSelf()
        configureHeightConstraint()
    }

    private func configureSelf() {
        self.register(LexicalUnitCreationTranslationsForPartOfSpeechCell.self, forCellReuseIdentifier: LexicalUnitCreationTranslationsForPartOfSpeechCell.reusableID)
        self.delegate = self
        self.dataSource = self
        self.isScrollEnabled = false
        self.estimatedRowHeight = 100
        self.rowHeight = UITableView.automaticDimension
    }

    private func configureHeightConstraint() {
        self.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = heightAnchor.constraint(equalToConstant: self.contentSize.height)
        heightConstraint?.priority = UILayoutPriority(1000)
        heightConstraint?.isActive = true
    }
}

extension LexicalUnitCreationTranslationForPartOfSpeechTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        listOfTranslations.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        listOfTranslations[section].partOfSpeech.rawValue.capitalized
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfTranslations[section].listOfTranslations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      TODO: - Make static -
        let cell = tableView.dequeueReusableCell(withIdentifier: LexicalUnitCreationTranslationsForPartOfSpeechCell.reusableID, for: indexPath) as! LexicalUnitCreationTranslationsForPartOfSpeechCell

        setUp(cell: cell, with: indexPath)
        setOnRemoveAction(for: cell, at: indexPath)
        setOnChangePartOfSpeechAction(for: cell, at: indexPath)
        return cell
    }

    private func setUp(cell: LexicalUnitCreationTranslationsForPartOfSpeechCell, with indexPath: IndexPath) {
        cell.setTranslation(
            translation: listOfTranslations[indexPath.section].listOfTranslations[indexPath.row]
        )
    }

    private func setOnRemoveAction(for cell: LexicalUnitCreationTranslationsForPartOfSpeechCell, at indexPath: IndexPath) {
        cell.setOnRemoveAction { [unowned self] in
            self.onRemoveTranslationForPartOfSpeech?(indexPath)
        }
    }

    private func setOnChangePartOfSpeechAction(for cell: LexicalUnitCreationTranslationsForPartOfSpeechCell, at indexPath: IndexPath) {
        cell.setChangePartOfSpeechAction { [unowned self] partOfSpeech in
            self.onChangePartOfSpeechForCellAction?(indexPath, partOfSpeech)
        }
    }
}
