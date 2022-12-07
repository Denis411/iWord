// Data of creation: 7/12/22
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
import Combine

final class AlertWithTextSubject {
    var enteredText = PassthroughSubject<String,Never>()
    
    func showAlert(on viewController: UIViewController) {
        let alert = createAleft()
        viewController.present(alert, animated: true)
    }
    
    private func createAleft() -> UIAlertController {
        let alert = UIAlertController(title: "Enter Name For New Folder", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Folder name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let createAction = UIAlertAction(title: "Create", style: .default) { [unowned self] action in
            guard let name = alert.textFields?.first?.text else {
                return
            }
            
            self.enteredText.send(name)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(createAction)
        
        return alert
    }
}
