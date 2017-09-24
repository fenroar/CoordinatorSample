import UIKit
import RxSwift
import RxCocoa

class RegisterEmailViewController: UIViewController {
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    
    var viewModel: RegisterEmailViewModel?
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Register"
        
        bind()
    }
    
    private func bind() {
        
        guard let viewModel = viewModel else {
            fatalError("RegisterEmailController must be instantiated with view model")
        }
        
        emailTextField.rx.text.bindTo(viewModel.email).addDisposableTo(disposeBag)
        
        passwordTextField.rx.text.bindTo(viewModel.password).addDisposableTo(disposeBag)
        
        registerButton.rx.tap.asObservable()
            .map { .register }
            .bindTo(viewModel.action)
            .addDisposableTo(disposeBag)
    }
}

extension RegisterEmailViewController: RegisterEmailViewModelDelegate {
    
    func handleDidRegisterWithEmail() {
        
        let storyboard = UIStoryboard.register
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterUsernameViewController") as! RegisterUsernameViewController
        let registerViewModel = RegisterUsernameViewModel(delegate: registerViewController)
        registerViewController.viewModel = registerViewModel
        
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

