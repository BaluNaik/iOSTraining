//
//  ViewController.swift
//  SocialLoginApp
//
//  Created by Balu Naik on 6/8/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices

class ViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var appleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        self.setUpAppleSignIn()
    }
    
    func setUpAppleSignIn() {
        let signinButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
        signinButton.frame = self.appleView.bounds
        signinButton.addTarget(self, action: #selector(appleSignIn), for: .touchUpInside)
        self.appleView.addSubview(signinButton)
    }
    
    @objc func appleSignIn() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.presentationContextProvider = self
        authController.delegate = self
        authController.performRequests()
    }
    
    @IBAction func googleSignIn() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func faceBookSignIn() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let accessToken = AccessToken.current?.tokenString {
                //Pass this token to backend for furture use
            } else if let fbError = error {
                print(fbError.localizedDescription)
            }
            if((AccessToken.current) != nil) {
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil) {
                        if let resultDic = result as? [String: Any] {
                            if let detailsScreen = self.storyboard?.instantiateViewController(identifier:"Details") as? DetailsViewController {
                                detailsScreen.loginType = .FaceBook
                                detailsScreen.userInfo = "User ID: \(resultDic["id"] ?? "") \nFull Name:\(resultDic["name"] ?? "")\nEmail:\(resultDic["email"] ?? "")"
                                self.navigationController?.pushViewController(detailsScreen, animated: true)
                            }
                        }
                    }
                })
                
            }
        }
    }

    
    //MARK: - GIDSignInDelegate
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        
        /*
          * This information we can pass to our server for furthure use
          * Dont expose token to logs
         */
        if let detailsScreen = self.storyboard?.instantiateViewController(identifier:"Details") as? DetailsViewController {
            detailsScreen.loginType = .Google
            detailsScreen.userInfo = "User ID: \(userId ?? "") \nFull Name:\(fullName ?? "")\nEmail:\(email ?? "")"
            self.navigationController?.pushViewController(detailsScreen, animated: true)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
    }

}


// MARK: - Apple Sign-In

extension ViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            if let data = credential.authorizationCode, let code = String(data: data, encoding: .utf8) {
                // code required to send server
                if let detailsScreen = self.storyboard?.instantiateViewController(identifier:"Details") as? DetailsViewController {
                    detailsScreen.loginType = .Apple
                    detailsScreen.userInfo = "First Name: \(credential.fullName?.givenName ?? "") \nFamily Name:\(credential.fullName?.familyName ?? "")\nEmail:\(credential.email ?? "")"
                    self.navigationController?.pushViewController(detailsScreen, animated: true)
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let authError = ASAuthorizationError(_nsError: error as NSError)
              switch authError.code {
              default:()
                  //Show Error
              }
    }
    
    
    
}
