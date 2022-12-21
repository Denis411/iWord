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
import Combine

protocol RootViewModel {
    var folderModels: CurrentValueSubject<[RootFolderCellInfo], Never> { get }
    func loadAllFolders()
    func reactToTapOnCell(at index: IndexPath)
    func deleteCellModel(at index: IndexPath)
    func addFolder()
}

final class RootFoldersViewControllerImp: UIViewController {
    private let viewModel: RootViewModel
    private var mainView: RootFolderView { view as! RootFolderView }
    private var disposedBag = Set<AnyCancellable>()
    
    override func loadView() {
        view = RootFolderView()
    }
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainViewActions()
        viewModel.loadAllFolders()
        bind()
    }

    private func setMainViewActions() {
        mainView.setOnCellTapAction { [unowned self] indexPath in
            self.viewModel.reactToTapOnCell(at: indexPath)
        }

        mainView.setOnCellDeletionAction { [unowned self] indexPath in
            self.viewModel.deleteCellModel(at: indexPath)
        }

        mainView.setOnAddFolderButtonAction { [unowned self] in
            self.viewModel.addFolder()
        }
    }

    private func bind() {
        viewModel.folderModels
            .receive(on: RunLoop.main)
            .sink { [unowned self] arrayOfFolderCells in
                self.mainView.setFolderCellInfos(arrayOfFolderCells)
            }
            .store(in: &disposedBag)
    }
}
