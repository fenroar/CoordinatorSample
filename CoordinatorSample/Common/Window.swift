import UIKit

protocol Window: class {
    var rootViewController: UIViewController? { get set }
    func makeKeyAndVisible()
}

extension UIWindow: Window { }
