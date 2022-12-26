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
    private var addFolderButton = UIButton()

    private var onCellTapAction: ((IndexPath) -> Void)?
    private var onCellDeletionAction: ((IndexPath) -> Void)?
    private var onAddFolderButtonAction: (() -> Void)?

    override func setUpUI() {
        addSubviews()
        setAllConstraints()
        configureAllViews()
    }

    func setFolderCellInfos(_ cellInfos: [Folder]) {
        self.folderCellInfos = cellInfos
        tableView.reloadData()
    }
}

// MARK: - Action setting -
extension RootFolderView {
    func setOnCellTapAction(_ action: @escaping (IndexPath) -> Void) {
        self.onCellTapAction = action
    }

    func setOnCellDeletionAction(_ action: @escaping (IndexPath) -> Void) {
        self.onCellDeletionAction = action
    }

    func setOnAddFolderButtonAction(_ action: @escaping () -> Void) {
        self.onAddFolderButtonAction = action
    }
}

extension RootFolderView {
    private func addSubviews() {
        self.addSubview(tableView)
        self.addSubview(addFolderButton)
    }
    
    private func setAllConstraints() {
        setTableViewConstraints()
        setAddFolderButtonConstraints()
    }
    
    private func setTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setAddFolderButtonConstraints() {
        addFolderButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    private func configureAllViews() {
        configureTableView()
        configureAddFolderButton()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FolderTableViewCell.self, forCellReuseIdentifier: FolderTableViewCell.reusableID)
        
        tableView.backgroundColor = .gray
    }

    private func configureAddFolderButton() {
        addFolderButton.backgroundColor = .red
        addFolderButton.layer.cornerRadius = 5
        addFolderButton.addTarget(self, action: #selector(addFolderAction), for: .touchUpInside)
        let image = UIImage(systemName: "plus")
        addFolderButton.setImage(image, for: .normal)
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

// Button actions
extension RootFolderView {
    @objc func addFolderAction(_sender: UIButton) {
        onAddFolderButtonAction?()
    }
}
