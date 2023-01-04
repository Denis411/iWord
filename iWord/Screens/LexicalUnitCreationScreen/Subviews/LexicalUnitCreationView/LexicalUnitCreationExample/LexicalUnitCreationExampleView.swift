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

final class LexicalUnitCreationExampleView: CommonView {
    private let tableView = UITableView()
    private var heightConstraint: NSLayoutConstraint?

    private var examples: [Example] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private var onRemoveExampleAction: ClosureWithIndexPath?

    override func setUpUI() {
        addAllSubviews()
        addAllConstraints()
        configureAllSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.heightConstraint?.constant = tableView.contentSize.height
    }

    func updateArrayOfExamples(_ examples: [Example]) {
        self.examples = examples
    }

    func setOnRemoveExampleAction(_ action: @escaping ClosureWithIndexPath) {
        self.onRemoveExampleAction = action
    }
}

extension LexicalUnitCreationExampleView {
    private func addAllSubviews() {
        self.addSubview(tableView)
    }

    private func addAllConstraints() {
        addTableViewConstraints()
        addHeightConstraint()
    }

    private func configureAllSubviews() {
        configureTableView()
    }

// MARK: - Constraints -

    private func addTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }

    private func addHeightConstraint() {
        let selfHeight = tableView.contentSize.height
        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: selfHeight)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightConstraint?.priority = UILayoutPriority(1000)
        self.heightConstraint?.isActive = true
    }

// MARK: - Configuration -

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LexicalUnitExampleTableViewCell.self, forCellReuseIdentifier: LexicalUnitExampleTableViewCell.reusableID)
        tableView.isScrollEnabled = false
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onRemoveExampleAction?(indexPath)
    }
}
