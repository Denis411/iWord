// Data of creation: 29/11/22
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
import NeedleFoundation
import UIKit

final class RootComponent: BootstrapComponent {
    var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        navigationController.isToolbarHidden = true
        return navigationController
    }()
}

// MARK: - Alerts -
extension RootComponent {
    var alertWithTextClosure: AlertWithTextClosure {
        AlertWithTextClosureImp()
    }

    var errorAlert: ErrorAlert {
        shared {
            ErrorAlertImp()
        }
    }
}

// MARK: - ViewControllers and navigation -
extension RootComponent {
    var rootScreenComponent: RootScreenComponent {
        RootScreenComponent(parent: self)
    }
    
    var secondVC: UIViewController {
        UIViewController()
    }
    
    var thirdVC: UIViewController {
        UIViewController()
    }
}