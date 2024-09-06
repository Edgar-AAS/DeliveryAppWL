//
//  GoogleLogin.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 17/07/24.
//

import Foundation
import GoogleSignIn
import Firebase
import UIKit

class GoogleLogin {
    static func showGoogleLogin(target: UIViewController, completion: @escaping (() -> ())) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: target) { result, error in
            guard error == nil,
                  let user = result?.user,
                  let idToken = user.idToken?.tokenString else
            { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if error == nil {
                    completion()
                }
            }
        }
    }
}
