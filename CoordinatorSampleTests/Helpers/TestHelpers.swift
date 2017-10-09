import UIKit
@testable import CoordinatorSample

class TestWindow: NSObject, Window {
    
    var rootViewController: UIViewController? = .none
    
    func makeKeyAndVisible() { }
}

class Wireframe: NavigationWireframe {
    
    var viewControllers: [UIViewController] = []
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        
        self.viewControllers = viewControllers
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.viewControllers.append(viewController)
    }
    
    var root: UIViewController? = .none
}

class TestWireframeFactory: NavigationWireframeFactory {
    
    var wireframe = Wireframe()
    
    func buildNavigationWireframe(with rootViewController: UIViewController) -> NavigationWireframe {
        wireframe.setViewControllers([rootViewController], animated: true)
        return wireframe
    }
}
