import UIKit
import RxSwift
import RxCocoa

class RegisterUsernameViewController: UIViewController {
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    
    var viewModel: RegisterUsernameViewModel?
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Register"
        
        bind()
    }
    
    private func bind() {
        
        guard let viewModel = viewModel else {
            fatalError("RegisterUsernameController must be instantiated with view model")
        }
        
        usernameTextField.rx.text.bindTo(viewModel.username).addDisposableTo(disposeBag)
        
        registerButton.rx.tap.asObservable()
            .map { .register }
            .bindTo(viewModel.action)
            .addDisposableTo(disposeBag)
    }
}

extension RegisterUsernameViewController: RegisterUsernameViewModelDelegate {
    
    func handleDidRegisterWithUsername() {
        
        let storyboard = UIStoryboard.main
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        navigationController?.setViewControllers([mainViewController], animated: true)
    }
}

