import RxSwift

protocol LoginViewModelDelegate: class {
    func handleDidLogin()
}

enum LoginViewModelAction {
    case login
}

struct LoginViewModel {
    
    private let disposeBag = DisposeBag()
    
    let email = Variable<String?>(.none)
    let password = Variable<String?>(.none)
    let action = PublishSubject<LoginViewModelAction>()
    
    weak var delegate: LoginViewModelDelegate?
    
    init(delegate: LoginViewModelDelegate?) {
        self.delegate = delegate
        
        bind()
    }
    
    private func bind() {
        
        action.subscribe(onNext: { action in
            
            switch action {
            case .login:
                self.handleLogin()
            }
        }).addDisposableTo(disposeBag)
    }
    
    private func handleLogin() {
        
        guard let email = email.value, let password = password.value else {
            return
        }
        
        if !email.isEmpty && !password.isEmpty {
            self.delegate?.handleDidLogin()
        }
    }
}
