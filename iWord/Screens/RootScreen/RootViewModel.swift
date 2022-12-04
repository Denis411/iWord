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

import Foundation
import UIKit

protocol RootRouter {
    func routeToSecondVC(animated: Bool)
    func routeToThirdVC(animated: Bool)
    func dismissCurrectViewController(animated: Bool)
}

protocol RootViewController: UIViewController {
    
}

final class RootViewModelImp: RootViewModel {
    private let router: RootRouter
    private unowned var view: RootViewController?
    
    init(router: RootRouter) {
        self.router = router
    }
    
    func setView(_ view: RootViewController) {
        self.view = view
    }
}
