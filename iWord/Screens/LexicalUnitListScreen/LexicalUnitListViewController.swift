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
import Combine

class LexicalUnitListViewController: UIViewController {
    private var mainView: LexicalUnitListView { view as! LexicalUnitListView }
    private var viewModel: LexicalUnitViewModel
    private var disposedBag = Set<AnyCancellable>()

    init(viewModel: LexicalUnitViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = LexicalUnitListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setMainViewActions()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationController()
    }

    func loadUnitsFromDataBase(for folder: FolderName) {
        viewModel.loadUnitsFromDataBase(for: folder)
        self.title = folder
    }

    private func setMainViewActions() {
        mainView.setOnDeleteUnitAction { [unowned self] indexPath in
            self.viewModel.deleteLexicalUnit(at: indexPath)
        }
    }

    private func bind() {
        viewModel.unitModels
            .receive(on: RunLoop.main)
            .sink { [unowned self] lexicalUnitModels in
//              TODO: - Transformation should be in VM
                let lexicalUnitCellInfo = lexicalUnitModels.map { $0.toLexicalUnitCellInfo() }
                self.mainView.updateCellInfo(with: lexicalUnitCellInfo)
            }
            .store(in: &disposedBag)
    }
}

// MARK: - NavController logic -
extension LexicalUnitListViewController {
    private func setNavigationController() {
        self.navigationController?.isNavigationBarHidden = false
    }
}


fileprivate extension LexicalUnit {
    func toLexicalUnitCellInfo() -> LexicalUnitCellInfo {
        LexicalUnitCellInfo(
            image: nil,
            progressPercentage: self.progressPercentage,
            originalLexicalUnit: self.originalLexicalUnit,
            primaryTranslation: self.primaryTranslation,
            translations: self.translations,
            isPinned: self.isPinned)
    }
}
