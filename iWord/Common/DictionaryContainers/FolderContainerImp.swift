// Data of creation: 19/12/22
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

import Foundation
import Combine

typealias FolderName = String

final class FolderContainerImp: FolderContainer {
    private let errorAlert: ErrorAlert
    var folderModels = CurrentValueSubject<[Folder], Never>([])

    init(errorAlert: ErrorAlert) {
        self.errorAlert = errorAlert
    }

    func addFolder(with name: FolderName) {
        guard !doesFolderExist(folderName: name) else {
            let message = "Sorry, folder named \(name) already exists."
            errorAlert.presentAlert(with: message)
            Log.error("You tried to add a folder with taken name")
            return
        }

        let newFolder = Folder(
            folderName: name,
            numberOfItems: 0,
            progressPercentage: 0,
            dateOfCreation: Date(),
            isPinned: false,
            isForwarded: false
        )

        folderModels.value.append(newFolder)
    }

    func removeFolder(with name: FolderName) {
        let index = folderModels.value.firstIndex { $0.folderName == name }

        guard let index = index else {
            Log.error("You tried to remove a non-existing folder")
            fatalError()
        }

        folderModels.value.remove(at: index)
    }

    func loadFolderModelsFromDataBase() {
        #if DEBUG
        let fakeFolderModels = getFakeFolders()
        folderModels.value = fakeFolderModels
        #endif
//      use data base layer to load existing folder models
    }

    func saveAllChanges() {
//        use data base layer to save edited list of folder if needed
    }
}

extension FolderContainerImp {
    private func doesFolderExist(folderName: FolderName) -> Bool {
        folderModels.value.contains { folder in
            folder.folderName == folderName
        }
    }
}

struct Folder: Hashable {
    let folderName: String
    let numberOfItems: Int16
    let progressPercentage: Int8
    let dateOfCreation: Date
    let isPinned: Bool
    let isForwarded: Bool

    func hash(into hasher: inout Hasher) {
        hasher.combine(folderName)
        hasher.combine(isForwarded)
    }
}


fileprivate func getFakeFolders() -> [Folder] {
    let singleFolder = Folder(
        folderName: "None",
        numberOfItems: 0,
        progressPercentage: 0,
        dateOfCreation: Date(),
        isPinned: Bool.random(),
        isForwarded: false
    )

    return [singleFolder, singleFolder, singleFolder, singleFolder]
}
