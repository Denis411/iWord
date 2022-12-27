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

import Foundation

protocol LexicalUnitViewModel {

}

final class LexicalUnitViewModelImp: LexicalUnitViewModel {
    private let router: MainRouter
    private let lexicalUnitContainer: LexicalUnitContainer
    private let alertWithTextClosure: AlertWithTextClosure

    init(
        router: MainRouter,
        lexicalUnitContainer: LexicalUnitContainer,
        alertWithTextClosure: AlertWithTextClosure
    ) {
        self.router = router
        self.lexicalUnitContainer = lexicalUnitContainer
        self.alertWithTextClosure = alertWithTextClosure
    }
}
