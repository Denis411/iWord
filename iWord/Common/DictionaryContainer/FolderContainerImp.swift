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

typealias FolderName = String

final class FolderContainerImp: FolderContainer {
    private var folders: Set<Folder> = []

    func addFolder(with name: FolderName) {
        guard !doesFolderExist(folderName: name) else {
            fatalError()
        }

        let newFolder = Folder(
            folderName: name,
            numberOfItems: 0,
            progressPercentage: 0,
            dateOfCreation: Date(),
            isPinned: false
        )

        folders.insert(newFolder)
    }

    func removeFolder(with name: FolderName) {
        guard doesFolderExist(folderName: name) else {
            fatalError()
        }

        folders.forEach { folder in
            if folder.folderName == name {
                folders.remove(folder)
                return
            }
        }
    }

    func getAllFolders() -> [Folder] {
        #if DEBUG
        return getFakeFolders()
        #endif
        return Array(folders)
    }

    func saveAllChanges() {
//        use data base layer to save edited list of folder if needed
    }
}

extension FolderContainerImp {
    private func doesFolderExist(folderName: FolderName) -> Bool {
        folders.contains { folder in
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

    func hash(into hasher: inout Hasher) {
        hasher.combine(folderName)
    }
}


fileprivate func getFakeFolders() -> [Folder] {
    let singleFolder = Folder(
        folderName: "None",
        numberOfItems: 0,
        progressPercentage: 0,
        dateOfCreation: Date(),
        isPinned: Bool.random()
    )

    return [singleFolder, singleFolder, singleFolder, singleFolder]
}
