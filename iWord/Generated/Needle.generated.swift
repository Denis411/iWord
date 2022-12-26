

import Foundation
import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->RootScreenComponent") { component in
        return RootScreenDependenciesac0a88b3c4e283ae5de9Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    
}

// MARK: - Providers

private class RootScreenDependenciesac0a88b3c4e283ae5de9BaseProvider: RootScreenDependencies {
    var alertWithTextClosure: AlertWithTextClosure {
        return rootComponent.alertWithTextClosure
    }
    var errorAlert: ErrorAlert {
        return rootComponent.errorAlert
    }
    var navigationController: UINavigationController {
        return rootComponent.navigationController
    }
    var secondVC: UIViewController {
        return rootComponent.secondVC
    }
    var thirdVC: UIViewController {
        return rootComponent.thirdVC
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->RootScreenComponent
private class RootScreenDependenciesac0a88b3c4e283ae5de9Provider: RootScreenDependenciesac0a88b3c4e283ae5de9BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(rootComponent: component.parent as! RootComponent)
    }
}
