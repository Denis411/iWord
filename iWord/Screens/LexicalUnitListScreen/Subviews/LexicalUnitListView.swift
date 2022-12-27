// Data of creation: 26/12/22
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

enum Section {
    case pinned
    case regular
}

final class LexicalUnitListView: CommonView {
    private let tableView = UITableView()
    private var addLexicalUnitButton = AddItemButton()
    //  TODO: - Use in a separated class if the file longer than 300 lines -
    private lazy var tableViewDiffableDataSource: UITableViewDiffableDataSource<Section,LexicalUnitCellInfo> = {
        createDiffableDataSource()
    }()

    private var onDeleteUnitAction: ((IndexPath) -> Void)?
    private var onAddLexicalUnitAction: EmptyClosure?

    override func setUpUI() {
        addAllSubviews()
        addAllConstraints()
        configureAllSubviews()
    }
}

// set actions
extension LexicalUnitListView {
    func setOnDeleteUnitAction(_ action: @escaping (IndexPath) -> Void) {
        self.onDeleteUnitAction = action
    }

    func setOnAddLexicalUnitAction(_ action: @escaping EmptyClosure) {
        self.onAddLexicalUnitAction = action
    }
}


extension LexicalUnitListView {
    private func addAllSubviews() {
        self.addSubview(tableView)
        self.addSubview(addLexicalUnitButton)
    }

    private func addAllConstraints() {
        addTableViewConstraints()
        addLexicalUnitButton.addConstraints()
    }

    private func addTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

    private func configureAllSubviews() {
        configureTableView()
        configureInitialDiffableSnapshot()
        confitureAddLexicalUnitButton()
    }

    private func configureTableView() {
        tableView.register(LexicalUnitTableViewCell.self,
                           forCellReuseIdentifier: LexicalUnitTableViewCell.reusableID)
        tableView.backgroundColor = .gray
        tableView.delegate = self
        tableView.dataSource = tableViewDiffableDataSource
    }

    private func confitureAddLexicalUnitButton() {
        addLexicalUnitButton.setAction { [unowned self] in
            self.onAddLexicalUnitAction?()
        }
    }
}

// UITableView
extension LexicalUnitListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextualAction = UIContextualAction(style: .normal, title: "Delete") { [unowned self] _ , view, completionHandler in
            self.onDeleteUnitAction?(indexPath)
            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [contextualAction])
    }
}

// MARK: - DiffableDataSource -
extension LexicalUnitListView {
    private func createDiffableDataSource() -> UITableViewDiffableDataSource<Section, LexicalUnitCellInfo> {
        let diffableDataSource = UITableViewDiffableDataSource<Section, LexicalUnitCellInfo>(tableView: tableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LexicalUnitTableViewCell.reusableID) as? LexicalUnitTableViewCell else {
                return UITableViewCell()
            }

            let lexicalUnit = itemIdentifier
            cell.setUpCellData(with: lexicalUnit)
            return cell
        }

        return diffableDataSource
    }

//  TODO: - DELETE AFTER TESTING -
    private func configureInitialDiffableSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, LexicalUnitCellInfo>()
        snapshot.appendSections([.regular])
        snapshot.appendItems([], toSection: .regular)
        tableViewDiffableDataSource.apply(snapshot)
    }

    func updateCellInfo(with models: [LexicalUnitCellInfo]) {
        guard !models.isEmpty else {
            Log.info("No models to update snapshot")
            return
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, LexicalUnitCellInfo>()
        let tupleOfPinnedAndRegularModels = separatePinedModels(from: models)

        if tupleOfPinnedAndRegularModels.pinned == [] {
            snapshot.appendSections([.regular])
            snapshot.appendItems(tupleOfPinnedAndRegularModels.regular, toSection: .regular)
            tableViewDiffableDataSource.apply(snapshot)
            return
        }

        snapshot.appendSections([.pinned, .regular])
        snapshot.appendItems(tupleOfPinnedAndRegularModels.pinned, toSection: .pinned)
        snapshot.appendItems(tupleOfPinnedAndRegularModels.regular, toSection: .regular)

        tableViewDiffableDataSource.apply(snapshot)
    }

    private func separatePinedModels(from models: [LexicalUnitCellInfo]) -> (pinned: [LexicalUnitCellInfo], regular: [LexicalUnitCellInfo]) {
        var pinnedModels = [LexicalUnitCellInfo]()
        var regularModels = [LexicalUnitCellInfo]()

        for model in models {
            switch model.isPinned {
            case true:
                pinnedModels.append(model)
            case false:
                regularModels.append(model)
            }
        }

        return (pinnedModels, regularModels)
    }
}
