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

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var router: Router { get }
    
    func present(animated: Bool, onDismissed: EmptyClosure?)
    func dismiss(animaged: Bool)
    
    func presentChild(_ child: Coordinator, animated: Bool, onDismissed: EmptyClosure?)
    func presentChild(_ child: Coordinator, animated: Bool)
}

extension Coordinator {
    func dismiss(animated: Bool) {
        router.dismiss(animated: animated)
    }
    
    func presentChild(_ child: Coordinator, animated: Bool, onDismissed: EmptyClosure?) {
        children.append(child)
        child.present(animated: animated) { [weak self, weak child] in
            guard let self = self,
                  let child = child else {
                return
            }
            self.removeChild(child)
            onDismissed?()
        }
         
    }
    
    func presentChild(_ child: Coordinator, animated: Bool) {
        self.presentChild(child, animated: animated, onDismissed: nil )
    }
    
    private func removeChild(_ child: Coordinator) {
        guard let index = children.firstIndex(where: { $0 === child} ) else { 
            return
        }
        
        children.remove(at: index)
    }
}
