// Data of creation: 29/11/22
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

protocol RootViewModel {
    func setView(_ view: RootViewController)
}

final class RootFoldersViewControllerImp: UIViewController, RootViewController {
    private let viewModel: RootViewModel
    private let tableView = UITableView()
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performOnViewDidLoad()
    }
    
    private func performOnViewDidLoad() {
        view.backgroundColor = .orange
        
        tableView.frame = view.frame
        tableView.backgroundColor = .gray
        view.addSubview(tableView)
        
        tableView.register(FolderTableViewCell.self, forCellReuseIdentifier: FolderTableViewCell.reusableID)
        
        viewModel.setView(self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension RootFoldersViewControllerImp: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FolderTableViewCell.reusableID, for: indexPath) as! FolderTableViewCell
        cell.setCellData(folderName: "100000", numberOfItems: 2, progressPercentage: 100)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
}
