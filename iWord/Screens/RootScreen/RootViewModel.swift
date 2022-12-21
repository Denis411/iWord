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

protocol RootRouter {
    func routeToSecondVC(animated: Bool)
    func routeToThirdVC(animated: Bool)
    func dismissCurrentViewController(animated: Bool)
}

protocol FolderContainer {
    func addFolder(with name: FolderName)
    func removeFolder(with name: FolderName)
    func getAllFolders() -> [Folder]
    func saveAllChanges()
}

final class RootViewModelImp {
    private let router: RootRouter
    private let folderContainer: FolderContainer
    var folderModels = CurrentValueSubject<[RootFolderCellInfo], Never>([])
    
    init(
        router: RootRouter,
        folderContainer: FolderContainer
    ) {
        self.router = router
        self.folderContainer = folderContainer
    }
}

extension RootViewModelImp: RootViewModel {
    func loadAllFolders() {
        let allFolder = folderContainer.getAllFolders()
        let allFolderModels = allFolder.map { $0.toRootFolderCellInfo() }
        folderModels.send(allFolderModels)
    }

    func reactToTapOnCell(at index: IndexPath) {
        router.routeToSecondVC(animated: false)
    }

    func deleteCellModel(at index: IndexPath) {
        folderModels.value.remove(at: index.row)
    }

    func addFolder() {
        let name = "New folder"
        folderContainer.addFolder(with: name)
    }

    func saveAllChanges() {
        folderContainer.saveAllChanges()
    }
}

extension Folder {
    func toRootFolderCellInfo() -> RootFolderCellInfo {
        RootFolderCellInfo(
            folderName: self.folderName,
            numberOfItems: self.numberOfItems,
            progressPercentage: self.progressPercentage,
            dateOfCreation: self.dateOfCreation
        )
    }
}
