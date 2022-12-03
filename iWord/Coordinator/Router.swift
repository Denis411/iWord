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

typealias EmptyClosure = () -> Void

 protocol Router: AnyObject {
    func presentViewController(_ vc: UIViewController, animated: Bool)
    func presentViewController(_ vc: UIViewController, animated: Bool, onDismissed: EmptyClosure?)
    func dismiss(animated: Bool)
}

extension Router {
    func presentViewController(_ vc: UIViewController, animated: Bool) {
        presentViewController(vc, animated: animated, onDismissed: nil)
    }
}
