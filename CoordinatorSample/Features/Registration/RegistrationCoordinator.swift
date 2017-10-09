import UIKit

class RegistrationCoordinator {
    
    weak var window: Window?
    var navigationController: NavigationWireframe?
    
    init(window: Window?) {
        self.window = window
    }
    
    func start() {
        
        let storyboard = UIStoryboard.register
        
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        let viewModel = SplashViewModel(delegate: self)
        rootViewController.viewModel = viewModel
        
        navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController?.root
        window?.makeKeyAndVisible()
    }
    
    // MARK: Build
    func buildLoginViewModel() -> LoginViewModel {
        return LoginViewModel(delegate: self)
    }
    
    func buildLoginViewController(viewModel: LoginViewModel) -> LoginViewController {
        let storyboard = UIStoryboard.register
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginViewController.viewModel = viewModel
        
        return loginViewController
    }
    
    func buildRegisterUsernameViewModel() -> RegisterUsernameViewModel {
        return RegisterUsernameViewModel(delegate: self)
    }
    
    func buildRegisterUsernameViewController(viewModel: RegisterUsernameViewModel) -> RegisterUsernameViewController {
        
        let storyboard = UIStoryboard.register
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterUsernameViewController") as! RegisterUsernameViewController
        registerViewController.viewModel = viewModel
        
        return registerViewController
    }
    
    func buildRegisterEmailViewModel() -> RegisterEmailViewModel {
        
        return RegisterEmailViewModel(delegate: self)
    }
    
    func buildRegisterEmailViewController(viewModel: RegisterEmailViewModel) -> RegisterEmailViewController {
        
        let storyboard = UIStoryboard.register
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterEmailViewController") as! RegisterEmailViewController
        registerViewController.viewModel = viewModel
        return registerViewController
    }
}

extension RegistrationCoordinator: SplashViewModelDelegate {
    
    func showLogin() {
     
        let viewModel = buildLoginViewModel()
        let loginViewController = buildLoginViewController(viewModel: viewModel)
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func showRegistration() {
        
        let viewModel = buildRegisterUsernameViewModel()
        let registerViewController = buildRegisterUsernameViewController(viewModel: viewModel)
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
        let storyboard = UIStoryboard.main
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        navigationController?.setViewControllers([mainViewController], animated: true)
    }
}

extension RegistrationCoordinator: RegisterUsernameViewModelDelegate {
    
    func handleDidRegisterWithUsername() {
        
        let viewModel = buildRegisterEmailViewModel()
        let registerViewController = buildRegisterEmailViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}
