//
//  ViewController.swift
//  WorkingWithWebView
//
//  Created by Balu Naik on 5/11/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        /* in 2015 apple was given App Transport Security
           - NSAppTransportSecurity
           - NSAllowsArbitraryLoads --> YES   (for non https request)
         */
        #if DEVELOPMENT
        url = "https://www.google.com/"
        #elseif STAGING
        url = "https://www.apple.com"
        #else
        url = "https://www.balututorial.com/"
        #endif
        
        if let urlString = self.url,
            let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        webView.allowsBackForwardNavigationGestures = true
        self.urlTextField.text = webView?.url?.absoluteString ?? ""
        self.urlTextField.delegate = self
        self.webView.navigationDelegate = self
        self.backButton.isEnabled = false
        self.forwardButton.isEnabled = false
    }
    
    @IBAction func actionOnButtonNavigation(_ sender: UIButton) {
        if sender == backButton {
            webView.goBack()
        } else {
            webView.goForward()
        }
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let urlString = textField.text,
            let url = URL(string: urlString) {
            self.webView.load(URLRequest(url: url))
        }
        textField.resignFirstResponder()
        
        return true
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        urlTextField.text = webView.url?.absoluteString ?? ""
    }
    
}

