import UIKit

class RegistrationCoordinator {
    
    weak var window: UIWindow?
    var navigationController: UINavigationController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        
        let storyboard = UIStoryboard.register
        
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        let viewModel = SplashViewModel(delegate: self)
        rootViewController.viewModel = viewModel
        
        navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

extension RegistrationCoordinator: SplashViewModelDelegate {
    
    func showLogin() {
        let storyboard = UIStoryboard.register
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let loginViewModel = LoginViewModel(delegate: self)
        loginViewController.viewModel = loginViewModel
        
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func showRegistration() {
        let storyboard = UIStoryboard.register
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterEmailViewController") as! RegisterEmailViewController
        let registerViewModel = RegisterEmailViewModel(delegate: self)
        registerViewController.viewModel = registerViewModel
        
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

extension RegistrationCoordinator: LoginViewModelDelegate {
    
    func handleDidLogin() {
        
        let storyboard = UIStoryboard.main
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        navigationController?.setViewControllers([mainViewController], animated: true)
    }
}

extension RegistrationCoordinator: RegisterEmailViewModelDelegate {
    
    func handleDidRegisterWithEmail() {
        
        let storyboard = UIStoryboard.register
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterUsernameViewController") as! RegisterUsernameViewController
        let registerViewModel = RegisterUsernameViewModel(delegate: self)
        registerViewController.viewModel = registerViewModel
        
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

extension RegistrationCoordinator: RegisterUsernameViewModelDelegate {
    
    func handleDidRegisterWithUsername() {
        
        let storyboard = UIStoryboard.main
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        navigationController?.setViewControllers([mainViewController], animated: true)
    }
}
