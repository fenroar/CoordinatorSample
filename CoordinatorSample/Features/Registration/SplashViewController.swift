import UIKit
import RxSwift
import RxCocoa

class SplashViewController: UIViewController {

    // MARK: Properties
    let disposeBag = DisposeBag()
    
    var viewModel: SplashViewModel?
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Splash"
        
        bind()
    }
    
    private func bind() {
        
        guard let viewModel = viewModel else {
            fatalError("SplashViewController must be instantiated with view model")
        }
        
        loginButton.rx.tap.asObservable()
            .map { .login }
            .bindTo(viewModel.action)
            .addDisposableTo(disposeBag)
        
        registerButton.rx.tap.asObservable()
            .map { .register }
            .bindTo(viewModel.action)
            .addDisposableTo(disposeBag)
    }
}

