// Data of creation: 27/12/22
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

protocol LexicalUnitScreenDependencies: Dependency {
//    var router: MainRouter { get }
    var errorAlert: ErrorAlert { get }
}

final class LexicalUnitScreenComponent: Component<LexicalUnitScreenDependencies> {
    var lexicalUnitListViewController: LexicalUnitListViewController {
        LexicalUnitListViewController(viewModel: lexicalViewModel)
    }

    private var lexicalViewModel: LexicalUnitViewModel {
        LexicalUnitViewModelImp(
//            router: dependency.router,
            lexicalUnitContainer: lexicalUnitContainer
        )
    }

    private var lexicalUnitContainer: LexicalUnitContainer {
        LexicalUnitContainerImp(errorAlert: dependency.errorAlert)
    }
}
