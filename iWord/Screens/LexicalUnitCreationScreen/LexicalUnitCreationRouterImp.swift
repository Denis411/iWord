// Data of creation: 5/1/23
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

protocol LexicalUnitCreationRouter {
    var navigationController: UINavigationController { get }
    func openAddImageOptionsSheet(with completionHandler: @escaping ClosureWithUIImage)
}

final class LexicalUnitCreationRouterImp: LexicalUnitCreationRouter {
    private(set) var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func openAddImageOptionsSheet(with completionHandler: @escaping ClosureWithUIImage) {
        let addImagesOptionsSheet = AddImageOptionsSheet(with: completionHandler)
        navigationController.present(addImagesOptionsSheet, animated: true)
    }
}
