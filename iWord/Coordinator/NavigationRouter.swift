// Data of creation: 3/12/22
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

class NavigationRouter: NSObject {
    private var navigationController: UINavigationController
    private var routerRootViewController: UIViewController?
    private var onDismissForViewController: [UIViewController: EmptyClosure?] = [:]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.routerRootViewController = navigationController.viewControllers.first
        super.init()
    }
}

extension NavigationRouter: Router {
    func presentViewController(_ vc: UIViewController, animated: Bool, onDismissed: EmptyClosure?) {
        onDismissForViewController[vc] = onDismissed
        navigationController.pushViewController(vc, animated: animated )
    }
    
    func dismiss(animated: Bool) {
        guard let routerRootViewController = routerRootViewController else {
            navigationController.popToRootViewController(animated: animated)
            return
        }
        
        navigationController.popToViewController(routerRootViewController, animated: animated)
        performOnDismissed(for: routerRootViewController)
    }
}

extension NavigationRouter {
    private func performOnDismissed(for viewController: UIViewController) {
        guard let onDismissAction = onDismissForViewController[viewController],
              let onDismissAction = onDismissAction else {
            return
        }
        
        onDismissAction()
        onDismissForViewController[viewController] = .none
    }
}  
