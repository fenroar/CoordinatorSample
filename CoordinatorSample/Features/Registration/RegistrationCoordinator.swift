import UIKit

typealias RegistrationCoordinatorDelegate = SplashViewModelDelegate & LoginViewModelDelegate & RegisterEmailViewModelDelegate & RegisterUsernameViewModelDelegate

struct RegistrationDependency {
    var wireframeFactory: NavigationWireframeFactory
    var viewModelFactory: RegistrationFactory
}

class RegistrationCoordinator {
    
    weak var window: Window?
    var navigationController: NavigationWireframe?
    var dependency: RegistrationDependency
    
    init(window: Window?, dependency: RegistrationDependency) {
        self.window = window
        self.dependency = dependency
    }
    
    func start() {
        let rootViewModel = dependency.viewModelFactory.buildSplashViewModel(delegate: self)
        let rootViewController = buildSplashViewController(viewModel: rootViewModel)
        navigationController = dependency.wireframeFactory.buildNavigationWireframe(with: rootViewController)
        window?.rootViewController = navigationController?.root
        window?.makeKeyAndVisible()
    }
    
    // MARK: Build
    func buildSplashViewController(viewModel: SplashViewModel) -> SplashViewController {
        let storyboard = UIStoryboard.register
        let splashViewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        splashViewController.viewModel = viewModel
        
        return splashViewController
    }
    
    func buildLoginViewController(viewModel: LoginViewModel) -> LoginViewController {
        let storyboard = UIStoryboard.register
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginViewController.viewModel = viewModel
        
        return loginViewController
    }
    
    func buildRegisterUsernameViewController(viewModel: RegisterUsernameViewModel) -> RegisterUsernameViewController {
        
        let storyboard = UIStoryboard.register
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterUsernameViewController") as! RegisterUsernameViewController
        registerViewController.viewModel = viewModel
        
        return registerViewController
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
     
        let viewModel = dependency.viewModelFactory.buildLoginViewModel(delegate: self)
        let loginViewController = buildLoginViewController(viewModel: viewModel)
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func showRegistration() {
        
        let viewModel = dependency.viewModelFactory.buildRegisterUsernameViewModel(delegate: self)
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
        
        let viewModel = dependency.viewModelFactory.buildRegisterEmailViewModel(delegate: self)
        let registerViewController = buildRegisterEmailViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}
