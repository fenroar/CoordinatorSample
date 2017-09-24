import RxSwift

protocol RegisterEmailViewModelDelegate: class {
    func handleDidRegisterWithEmail()
}

enum RegisterEmailViewModelAction {
    case register
}

struct RegisterEmailViewModel {
    
    private let disposeBag = DisposeBag()
    
    let email = Variable<String?>(.none)
    let password = Variable<String?>(.none)
    let action = PublishSubject<RegisterEmailViewModelAction>()
    
    weak var delegate: RegisterEmailViewModelDelegate?
    
    init(delegate: RegisterEmailViewModelDelegate?) {
        self.delegate = delegate
        
        bind()
    }
    
    private func bind() {
        
        action.subscribe(onNext: { action in
            
            switch action {
            case .register:
                self.handleRegister()
            }
        }).addDisposableTo(disposeBag)
    }
    
    private func handleRegister() {
        
        guard let email = email.value, let password = password.value else {
            return
        }
        
        if !email.isEmpty && !password.isEmpty {
            self.delegate?.handleDidRegisterWithEmail()
        }
    }
}
