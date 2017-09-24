import UIKit

extension UIStoryboard {

    static let register: UIStoryboard = {
        return UIStoryboard(name: "Registration", bundle: .none)
    }()
    
    static let main: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: .none)
    }()
}
