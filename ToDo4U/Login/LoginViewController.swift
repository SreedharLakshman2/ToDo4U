//
//  ViewController.swift
//  ToDo4U
//
//  Created by IFOCUS on 09/01/23.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
 
    @IBOutlet weak var appNameLable: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    var loginViewModel: LoginViewModel =  LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        addTapgestureToUIView()
        updateFontAndAppName()
        
        emailTextField.tag = LoginTextFieldEnum.emailTextfield.rawValue
        passwordTextField.tag = LoginTextFieldEnum.passwordTextField.rawValue
        emailTextField.delegate = self
        passwordTextField.delegate = self
        //authenticateUserWithBiometric()
    }
    
    //MARK: - View Controller methods
    func addTapgestureToUIView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
            self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func updateFontAndAppName() {
        appNameLable.font = UIFont(name: "sparkyStones-Regular", size: 50)
        appNameLable.text = "ToDO 4 UR Life"
        emailValidationLabel.isHidden = true
        passwordValidationLabel.isHidden = true
     }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func authenticateUserWithBiometric() {
        if UserDefaults.standard.bool(forKey: "UserAlreadyLoggedIn") {
            authenticationWithTouchIDOrFaceID()
        }
        else {
          showAlert(message: "Initial Login is required to access FaceID/Biometric")
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        if (emailTextField.text == loginViewModel.loginUserName) && (passwordTextField.text == loginViewModel.loginPassword) {
            print("Success")
            UserDefaults.standard.set(true, forKey: "UserAlreadyLoggedIn")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
        else {
            showAlert(message: "Login Failed")
        }
     }
    
    
    @IBAction func loginWithBiometric(_ sender: Any) {
        authenticateUserWithBiometric()
    }
    
    func authenticationWithTouchIDOrFaceID() {
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"

            var authorizationError: NSError?
            let reason = "Authentication required to access the secure data"

            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
                
                localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
                    
                    if success {
                        DispatchQueue.main.async() {
                            let alert = UIAlertController(title: "Success", message: "Authenticated succesfully!", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                                print("TODO Success")
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                                let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                                self.navigationController?.pushViewController(homeViewController, animated: true)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    } else {
                        // Failed to authenticate
                        guard let error = evaluateError else {
                            return
                        }
                        print(error)
                        self.showAlert(message: error.localizedDescription)
                     }
                }
            } else {
                
                guard let error = authorizationError else {
                    return
                }
                print(error)
            }
        }
    
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == LoginTextFieldEnum.emailTextfield.rawValue {
            print(textField.text ?? "")
        }
        else {
            print(textField.text ?? "")
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldObserver(textField: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldObserver(textField: textField)
    }
    
    
    func textFieldObserver(textField: UITextField) {
        if textField.tag == LoginTextFieldEnum.emailTextfield.rawValue {
            print(textField.text ?? "", "//Email")
            if let textFieldString = textField.text {
                if textFieldString.isValidEmail() && textFieldString.count > 5 {
                    emailValidationLabel.isHidden = true
                }
                else {
                    emailValidationLabel.isHidden = false
                    emailValidationLabel.text = "Enter valid email"
                }
            }
        }
        else {
            print(textField.text ?? "","//Password")
        }
    }
    
    @nonobjc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension UIViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
}

