import UIKit

protocol RegistrationFactory {
    func buildSplashViewModel(delegate: RegistrationCoordinatorDelegate) -> SplashViewModel
    func buildLoginViewModel(delegate: RegistrationCoordinatorDelegate) -> LoginViewModel
    func buildRegisterUsernameViewModel(delegate: RegistrationCoordinatorDelegate) -> RegisterUsernameViewModel
    func buildRegisterEmailViewModel(delegate: RegistrationCoordinatorDelegate) -> RegisterEmailViewModel
}

class RegistrationViewModelFactory: RegistrationFactory {
    
    func buildSplashViewModel(delegate: RegistrationCoordinatorDelegate) -> SplashViewModel {
        return SplashViewModel(delegate: delegate)
    }
    
    func buildLoginViewModel(delegate: RegistrationCoordinatorDelegate) -> LoginViewModel {
        return LoginViewModel(delegate: delegate)
    }
    
    func buildRegisterUsernameViewModel(delegate: RegistrationCoordinatorDelegate) -> RegisterUsernameViewModel {
        return RegisterUsernameViewModel(delegate: delegate)
    }
    
    func buildRegisterEmailViewModel(delegate: RegistrationCoordinatorDelegate) -> RegisterEmailViewModel {
        return RegisterEmailViewModel(delegate: delegate)
    }
}
