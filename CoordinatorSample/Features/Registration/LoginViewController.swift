import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    
    var viewModel: LoginViewModel?
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login"
        
        bind()
    }
    
    private func bind() {
        
        guard let viewModel = viewModel else {
            fatalError("LoginViewController must be instantiated with view model")
        }
        emailTextField.rx.text.bindTo(viewModel.email).addDisposableTo(disposeBag)
        
        passwordTextField.rx.text.bindTo(viewModel.password).addDisposableTo(disposeBag)
        
        loginButton.rx.tap.asObservable()
            .map { .login }
            .bindTo(viewModel.action)
            .addDisposableTo(disposeBag)
    }
}

