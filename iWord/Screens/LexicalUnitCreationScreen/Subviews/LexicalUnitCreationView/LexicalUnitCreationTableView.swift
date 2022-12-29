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

struct ListOfTranslationsOfPartOfSpeech {
    var partOfSpeech: PartOfSpeech
    var translations: [String]
}

final class LexicalUnitCreationTableView: UITableView {
    private var listOfTranslations: [ListOfTranslationsOfPartOfSpeech] = []
    private var heightConstraint: NSLayoutConstraint?

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
    }
}

// MARK: - Subview configurations -
extension LexicalUnitCreationTableView {
    private func configureAllSubviews() {
        configureSelf()
        configureHeightConstraint()
    }

    private func configureSelf() {
        self.register(LexicalUnitCreationTableViewCell.self, forCellReuseIdentifier: LexicalUnitCreationTableViewCell.reusableID)
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

extension LexicalUnitCreationTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        listOfTranslations.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Some"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfTranslations[section].translations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      TODO: - Make static -
        let cell = tableView.dequeueReusableCell(withIdentifier: LexicalUnitCreationTableViewCell.reusableID, for: indexPath) as! LexicalUnitCreationTableViewCell

        setUp(cell: cell, with: indexPath)
        setOnRemoveAction(for: cell, at: indexPath)

        return cell
    }

    private func setUp(cell: LexicalUnitCreationTableViewCell, with indexPath: IndexPath) {
        cell.setTranslation(
            partOfSpeech: listOfTranslations[indexPath.section].partOfSpeech,
            translation: listOfTranslations[indexPath.section].translations[indexPath.row]
        )
    }

    private func setOnRemoveAction(for cell: LexicalUnitCreationTableViewCell, at indexPath: IndexPath) {
        cell.setOnRemoveAction { [unowned self] in
            listOfTranslations[indexPath.section].translations.remove(at: indexPath.row)

            if listOfTranslations[indexPath.section].translations.isEmpty {
                listOfTranslations.remove(at: indexPath.section)
                self.reloadData()
                return
            }

            self.reloadSections([indexPath.section], with: .fade)
        }
    }
}
