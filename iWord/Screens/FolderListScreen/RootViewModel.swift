// Data of creation: 4/12/22
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

protocol MainRouter {
    func routeToLexicalUnitListViewController(for folder: FolderName, animated: Bool)
    func routeToThirdVC(animated: Bool)
    func dismissCurrentViewController(animated: Bool)
}

protocol FolderContainer {
    var folderModels: CurrentValueSubject<[Folder], Never> { get }
    func addFolder(with name: FolderName)
    func removeFolder(with name: FolderName)
    func saveAllChanges()
    func loadFolderModelsFromDataBase()
}

final class RootViewModelImp {
    private let router: MainRouter
    private let folderContainer: FolderContainer
    private let alertWithTextClosure: AlertWithTextClosure
    var folderModels: CurrentValueSubject<[Folder], Never> {
        folderContainer.folderModels
    }
    
    init(
        router: MainRouter,
        folderContainer: FolderContainer,
        alertWithTextClosure: AlertWithTextClosure
    ) {
        self.router = router
        self.folderContainer = folderContainer
        self.alertWithTextClosure = alertWithTextClosure
    }
}

extension RootViewModelImp: RootViewModel {
    func loadAllFolders() {
        folderContainer.loadFolderModelsFromDataBase()
    }

    func reactToTapOnCell(at index: IndexPath) {
        let folderName = folderModels.value[index.row].folderName
        router.routeToLexicalUnitListViewController(for: folderName, animated: true)
    }

    func deleteCellModel(at index: IndexPath) {
        folderModels.value.remove(at: index.row)
    }

    func addFolder() {
        alertWithTextClosure.showAlert { [unowned self] enteredText in
            guard let enteredText = enteredText else {
                return
            }

            self.folderContainer.addFolder(with: enteredText)
        }
    }

    func saveAllChanges() {
        folderContainer.saveAllChanges()
    }
}
