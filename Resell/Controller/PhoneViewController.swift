//
//  ViewController.swift
//  Resell
//
//  Created by Loranne Joncheray on 06/06/2023.
//

import UIKit

class PhoneViewController: UIViewController, UITextFieldDelegate {

    private var phoneField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .secondarySystemBackground
        field.placeholder = "Phone Number"
        field.returnKeyType = .continue
        field.textAlignment = .center
        return  field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(phoneField)
        phoneField.frame = CGRect(x: 0, y: 0, width: 220, height: 50)
        phoneField.center = view.center
        phoneField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text, !text.isEmpty {
            let number = "+1/(text)"
            AuthManager.shared.startAuth(phoneNumber: number) { [weak self] success in
                guard success else { return }
                DispatchQueue.main.async {
                    let vc = SMSCodeViewController()
                    vc.title = "Enter Code"
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        return true
    }

}

