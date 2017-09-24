import RxSwift

protocol SplashViewModelDelegate: class {
    func showLogin()
    func showRegistration()
}

enum SplashViewModelAction {
    case login
    case register
}

struct SplashViewModel {
    
    private let disposeBag = DisposeBag()
    
    let action = PublishSubject<SplashViewModelAction>()
    
    weak var delegate: SplashViewModelDelegate?
    
    init(delegate: SplashViewModelDelegate?) {
        
        self.delegate = delegate
        
        bind()
    }
    
    private func bind() {
        
        action.subscribe(onNext: { action in
            
            switch action {
            case .login:
                self.delegate?.showLogin()
            case .register:
                self.delegate?.showRegistration()
            }
        }).addDisposableTo(disposeBag)
    }

}
