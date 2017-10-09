import UIKit

protocol NavigationWireframe {
    
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    
    var root: UIViewController? { get }
}

extension UINavigationController: NavigationWireframe {

    var root: UIViewController? {
        return self
    }
}
