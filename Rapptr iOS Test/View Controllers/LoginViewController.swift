
import UIKit
import UIColor_Hex_Swift

 class LoginViewController: UIViewController {
    
    private var client: LoginClient = {
        let client = LoginClient()
        client.session = URLSession.shared
        return client
    }()
    
    @IBOutlet var emailTextField: TextFieldWithPadding!
    @IBOutlet var passwordTextField: TextFieldWithPadding!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        configureTextFields()
    }
    
    private func configureTextFields() {
        emailTextField.attributedPlaceholder = NSAttributedString (
            string: "Email",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor("#5F6063")
            ]
        )
        
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor("#5F6063")
            ]
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
        else {
            return
        }
        
        let startTime = Date()
        
        client.login(
            email: email,
            password: password
        ) { [weak self] successResponse in
            
            let endTime = Date()
            let timeDifference = endTime.timeIntervalSince(startTime) * 1000
            
            DispatchQueue.main.async {
                self?.showAlertView(title: "Success", message: "Message: \(successResponse)\nTime:\(timeDifference) ms.", okCompletion: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
            error: { [weak self] errorResponse in
            DispatchQueue.main.async {
                self?.showAlertView(title: "Error", message: errorResponse ?? "Something unexpected happened")
            }
        }
     }
    func showAlertView(title: String, message: String, okCompletion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: { _ in okCompletion?() }
        )
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
}


class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 24,
        bottom: 10,
        right: 24
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
