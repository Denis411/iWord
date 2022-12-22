// Data of creation: 21/12/22
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

typealias AlertMessage = String

protocol ErrorAlert {
    func presentAlert(with message: AlertMessage)
}

final class ErrorAlertImp: ErrorAlert {
    func presentAlert(with message: AlertMessage) {
        let alert = createAlert(with: message)
        let presentingVC = getPresentingVC()
        presentingVC?.present(alert, animated: true)
    }

    private func createAlert(with message: AlertMessage) -> UIAlertController {
        let alertVC =  UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )

        let dismissButton = UIAlertAction(title: "Ok", style: .cancel)
        alertVC.addAction(dismissButton)

        return alertVC
    }

    private func getPresentingVC() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return nil
        }

        return sceneDelegate.window?.rootViewController
    }
}
