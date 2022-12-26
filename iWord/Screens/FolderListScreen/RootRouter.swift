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

final class RootRouterImp: RootRouter {
    private let navigationController: UINavigationController
    private let secondVC: UIViewController
    private let thirdVC: UIViewController
    
    init(navigationController: UINavigationController,
         secondVC: UIViewController,
         thirdVC: UIViewController) {
        self.navigationController = navigationController
        self.secondVC = secondVC
        self.thirdVC = thirdVC
    }
    
    func routeToSecondVC(animated: Bool) {
        navigationController.pushViewController(secondVC, animated: animated)
    }
    
    func routeToThirdVC(animated: Bool) {
        navigationController.pushViewController(thirdVC, animated: animated)
    }
    
    func dismissCurrentViewController(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
}
