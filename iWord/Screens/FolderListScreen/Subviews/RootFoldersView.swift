// Data of creation: 8/12/22
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

final class RootFolderView: CommonView {
    private let tableView = UITableView()
    private var folderCellInfos: [Folder] = []
    private var addFolderButton = AddItemButton()

    private var onCellTapAction: ClosureWithIndexPath?
    private var onCellDeletionAction: ClosureWithIndexPath?

    override func setUpUI() {
        addSubviews()
        setAllConstraints()
        configureAllViews()
    }

    func setOnCellTapAction(_ action: @escaping ClosureWithIndexPath) {
        self.onCellTapAction = action
    }

    func setOnCellDeletionAction(_ action: @escaping ClosureWithIndexPath) {
        self.onCellDeletionAction = action
    }

    func setOnAddFolderButtonAction(_ action: @escaping EmptyClosure) {
        addFolderButton.setAction(action)
    }

    func setFolderCellInfos(_ cellInfos: [Folder]) {
        self.folderCellInfos = cellInfos
        tableView.reloadData()
    }
}

extension RootFolderView {
    private func addSubviews() {
        self.addSubview(tableView)
        self.addSubview(addFolderButton)
    }

    private func setAllConstraints() {
        setTableViewConstraints()
        addFolderButton.addConstraints()
    }

    private func configureAllViews() {
        configureTableView()
    }
}

extension RootFolderView {
    private func setTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FolderTableViewCell.self, forCellReuseIdentifier: FolderTableViewCell.reusableID)
        
        tableView.backgroundColor = .gray
    }
}

extension RootFolderView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FolderTableViewCell.reusableID, for: indexPath) as! FolderTableViewCell
        
        let cellInfo = folderCellInfos[indexPath.row]
        cell.setCellData(with: cellInfo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        folderCellInfos.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onCellTapAction?(indexPath)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextualAction = UIContextualAction(style: .normal, title: "Delete") { [unowned self] contextualAction, view, completionHandler in
            self.onCellDeletionAction?(indexPath)
            completionHandler(true)
        }

        contextualAction.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [contextualAction])
    }
}
