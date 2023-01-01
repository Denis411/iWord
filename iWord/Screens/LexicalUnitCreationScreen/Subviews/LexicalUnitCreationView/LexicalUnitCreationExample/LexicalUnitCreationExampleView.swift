// Data of creation: 1/1/23
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

typealias LexicalUnitExample = (original: String, translation: String)

let GAP_BETWEEN_TITLE_AND_TABLEVIEW: CGFloat = 10.0

final class LexicalUnitCreationExampleView: CommonView {
    private let title = UILabel()
    private let addExampleButton = UIButton()
    private let tableView = UITableView()
    private var heightConstraint: NSLayoutConstraint?

    private var examples: [LexicalUnitExample] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private var onAddExampleAction: EmptyClosure?

    override func setUpUI() {
        addAllSubviews()
        addAllConstraints()
        configureAllSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.heightConstraint?.constant = title.bounds.height + GAP_BETWEEN_TITLE_AND_TABLEVIEW + tableView.contentSize.height
    }

    func setOnAddExampleActions(_ action: @escaping EmptyClosure) {
        self.onAddExampleAction = action
    }

    func addArrayOfExamples(_ examples: [LexicalUnitExample]) {
        self.examples.append(contentsOf: examples)
    }

    func addExample(_ example: LexicalUnitExample) {
        self.examples.append(example)
    }

    func removeExample(at index: Int) {
        self.examples.remove(at: index)
    }
}

extension LexicalUnitCreationExampleView {
    private func addAllSubviews() {
        self.addSubview(addExampleButton)
        self.addSubview(title)
        self.addSubview(tableView)
    }

    private func addAllConstraints() {
        addExampleButtonConstraints()
        addTitleConstraints()
        addTableViewConstraints()
        addHeightConstraint()
    }

    private func addExampleButtonConstraints() {
        addExampleButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.edges.equalTo(40)
        }
    }

    private func addTitleConstraints() {
        title.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.equalTo(addExampleButton.snp.left)
        }
    }

    private func addTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(GAP_BETWEEN_TITLE_AND_TABLEVIEW)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func addHeightConstraint() {
        let selfHeight = title.bounds.height + GAP_BETWEEN_TITLE_AND_TABLEVIEW + tableView.contentSize.height
        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: selfHeight)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightConstraint?.priority = UILayoutPriority(1000)
        self.heightConstraint?.isActive = true
    }

    private func configureAllSubviews() {
        configureAddExampleButton()
        configureTitle()
        configureTableView()
    }

    private func configureAddExampleButton() {
        addExampleButton.backgroundColor = .blue
        addExampleButton.addTarget(self, action: #selector(performOnAddExampleAction), for: .touchUpInside)
    }

    private func configureTitle() {
        title.font = .systemFont(ofSize: 20)
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LexicalUnitExampleTableViewCell.self, forCellReuseIdentifier: LexicalUnitExampleTableViewCell.reusableID)
    }
}

// MARK: - Selectors -
extension LexicalUnitCreationExampleView {
    @objc private func performOnAddExampleAction() {
        onAddExampleAction?()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate -
extension LexicalUnitCreationExampleView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        examples.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LexicalUnitExampleTableViewCell()
        cell.setCellData(with: examples[indexPath.row])
        return cell
    }
}

