//
//  File.swift
//  Resell
//
//  Created by Loranne Joncheray on 06/06/2023.
//

import Foundation
import UIKit
import FirebaseAuth


class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private var verificationId: String?
    
    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
            guard let verificationId = verificationId, error == nil else {
                completion(false)
                return
            }
            self?.verificationId = verificationId
            completion(true)
        }
    }
    
    public func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        guard let verificationId = verificationId else {
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId,
            verificationCode: smsCode
        )
        
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }

    }
}



class SignupViewController: UIViewController {
    
    // Inscription avec une adresse e-mail et un mot de passe
    func signUp(withEmail email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if let error = error {
                print("Erreur lors de l'inscription : \(error.localizedDescription)")
            } else {
                // L'utilisateur s'est inscrit avec succès
                print("Inscription réussie !")
                // Effectuez les opérations supplémentaires nécessaires après l'inscription réussie, comme la navigation vers la page suivante, etc.
            }
        }
    }
    
    // Connexion avec une adresse e-mail et un mot de passe
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("Erreur lors de la connexion : \(error.localizedDescription)")
            } else {
                // L'utilisateur s'est connecté avec succès
                print("Connexion réussie !")
                // Effectuez les opérations supplémentaires nécessaires après la connexion réussie, comme la navigation vers la page suivante, etc.
            }
        }
    }
}


