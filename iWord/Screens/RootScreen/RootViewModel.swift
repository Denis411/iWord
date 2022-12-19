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

final class RootViewModelImp {
    private let router: RootRouter
    var folderModels = CurrentValueSubject<[RootFolderCellInfo], Never>([])
    
    init(router: RootRouter) {
        self.router = router
        setFakeData()
    }
}

extension RootViewModelImp: RootViewModel {
    func reactToTapOnCell(at index: IndexPath) {
        router.routeToSecondVC(animated: false)
    }

    func deleteCellModel(at index: IndexPath) {
        folderModels.value.remove(at: index.row)
    }
}

// TODO: - Remove after testing -
extension RootViewModelImp {
    private func setFakeData() {
        DispatchQueue.main.async { [unowned self] in
            sleep(4)
            let fakeData = RootFolderCellInfo(
                folderName: "some",
                numberOfItems: 3,
                progressPercentage: 3,
                dateOfCreation: Date()
            )

            self.folderModels.send([fakeData, fakeData, fakeData])
        }
    }
}
