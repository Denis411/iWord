// Data of creation: 1/12/22
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

protocol Coordinator {
    var childrenCoordinators: [Coordinator] { get }
    var navController: UINavigationController { get }
    
    func start()
}

extension Coordinator {
    func popToRootViewController(animated: Bool) {
        navController.popToRootViewController(animated: animated)
    }
    
    func popViewController(animated: Bool) {
        navController.popViewController(animated: animated)
    }
}
