import RxSwift

protocol RegisterUsernameViewModelDelegate: class {
    func handleDidRegisterWithUsername()
}

enum RegisterUsernameViewModelAction {
    case register
}

struct RegisterUsernameViewModel {
    
    private let disposeBag = DisposeBag()
    
    let username = Variable<String?>(.none)
    let action = PublishSubject<RegisterUsernameViewModelAction>()
    
    weak var delegate: RegisterUsernameViewModelDelegate?
    
    init(delegate: RegisterUsernameViewModelDelegate?) {
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
        
        guard let username = username.value else {
            return
        }
        
        if !username.isEmpty {
            self.delegate?.handleDidRegisterWithUsername()
        }
    }
}
