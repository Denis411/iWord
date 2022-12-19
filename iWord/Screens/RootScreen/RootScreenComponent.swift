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

import NeedleFoundation

protocol RootScreenDependencies: Dependency {
    var navigationController: UINavigationController { get }
    var secondVC: UIViewController { get }
    var thirdVC: UIViewController { get }
}

final class RootScreenComponent: Component<RootScreenDependencies> {
    var viewModel: RootViewModel {
        RootViewModelImp(router: router)
    }
    
    var router: RootRouter {
        RootRouterImp(navigationController: dependency.navigationController,
                      secondVC: dependency.secondVC,
                      thirdVC: dependency.thirdVC)
    }
    
    var rootViewController: UIViewController {
        RootFoldersViewControllerImp(viewModel: viewModel)
    }
}
