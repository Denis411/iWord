

import Foundation
import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->LexicalUnitScreenComponent") { component in
        return LexicalUnitScreenDependenciesfecbfdfd5a0d1bb2a628Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->LexicalUnitCreationComponent") { component in
        return LexicalUnitCreationDependency7e421c941884b7104910Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->RootScreenComponent") { component in
        return RootScreenDependenciesac0a88b3c4e283ae5de9Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    
}

// MARK: - Providers

private class LexicalUnitScreenDependenciesfecbfdfd5a0d1bb2a628BaseProvider: LexicalUnitScreenDependencies {
    var errorAlert: ErrorAlert {
        return rootComponent.errorAlert
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->LexicalUnitScreenComponent
private class LexicalUnitScreenDependenciesfecbfdfd5a0d1bb2a628Provider: LexicalUnitScreenDependenciesfecbfdfd5a0d1bb2a628BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(rootComponent: component.parent as! RootComponent)
    }
}
private class LexicalUnitCreationDependency7e421c941884b7104910BaseProvider: LexicalUnitCreationDependency {
    var errorAlert: ErrorAlert {
        return rootComponent.errorAlert
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->LexicalUnitCreationComponent
private class LexicalUnitCreationDependency7e421c941884b7104910Provider: LexicalUnitCreationDependency7e421c941884b7104910BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(rootComponent: component.parent as! RootComponent)
    }
}
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
    var router: MainRouter {
        return rootComponent.router
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
