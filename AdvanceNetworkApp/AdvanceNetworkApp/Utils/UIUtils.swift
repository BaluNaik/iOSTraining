//
//  UIUtils.swift
//  AdvanceNetworkApp
//
//  Created by Balu Naik on 5/19/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func showErrorAlert(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}



class BaseViewController: UIViewController {
    
    var loader: UIActivityIndicatorView?
    
    func setupMainLoader() {
        self.loader = UIActivityIndicatorView(style: .large)
        self.loader?.color = UIColor.black
        self.loader?.frame = CGRect(origin: CGPoint(x: self.view.frame.size.width / 2 - 60, y: self.view.frame.height / 2 - 60), size: CGSize(width: 60.0, height: 60))
        if let loaderView = self.loader {
            self.view.addSubview(loaderView)
            loaderView.hidesWhenStopped = true
        }
    }
    
    func showLoaderOnView(_ show: Bool) {
          DispatchQueue.main.async {
              if show {
                  self.loader?.startAnimating()
                  self.view.isUserInteractionEnabled = false
              } else {
                  self.loader?.stopAnimating()
                  self.view.isUserInteractionEnabled = true
              }
          }
      }
    
}
