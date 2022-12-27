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

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let rootComponent = RootComponent()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setRootViewController(for: scene)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

fileprivate extension SceneDelegate {
    func setRootViewController(for scene: UIScene) {
        guard let mainScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: mainScene)
        window?.rootViewController = createNavigationController()
        window?.makeKeyAndVisible()
    }
    
    func createNavigationController() -> UINavigationController {
        let rootViewController = rootComponent.lexicalUnitCreationComponent.lexicalUnitCreationViewController
        let navController = rootComponent.navigationController
        navController.pushViewController(rootViewController, animated: true)
        navController.isNavigationBarHidden = true
        navController.isToolbarHidden = true
        return navController
    }
}
