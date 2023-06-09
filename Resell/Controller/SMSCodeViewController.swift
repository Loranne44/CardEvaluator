//
//  SMSCodeViewController.swift
//  Resell
//
//  Created by Loranne Joncheray on 08/06/2023.
//

import UIKit

class SMSCodeViewController: UIViewController, UITextFieldDelegate  {
    
    private var codeField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .secondarySystemBackground
        field.placeholder = "Enter Code"
        field.returnKeyType = .continue
        field.textAlignment = .center
        return  field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(codeField)
        codeField.frame = CGRect(x: 0, y: 0, width: 220, height: 50)
        codeField.center = view.center
        codeField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text, !text.isEmpty {
            let code = text
            AuthManager.shared.verifyCode(smsCode: code) { [weak self] success in
                guard success else { return }
                DispatchQueue.main.async {
                    let vc = AccountViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                }
            }
        }
        return true
    }
    
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


