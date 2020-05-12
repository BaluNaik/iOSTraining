//
//  ViewController.swift
//  WebViewWithHtmlData
//
//  Created by Balu Naik on 5/12/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.loadHtmlString()
        self.loadHTMLFile()
    }
    
    private func loadHtmlString() {
         let htmlString = """
                            <p>
                            Identify the arrow marked structures in the images
                            <img alt=\"\" src=\"https://dams-apps-production.s3.ap-south-1.amazonaws.com/course_file_meta/73857742.PNG\">
                            </p>
                        """
        self.webview.loadHTMLString(htmlString, baseURL: nil)
    }
    
    private func loadHTMLFile() {
        if let htmlPath = Bundle.main.path(forResource: "sample", ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let request =  URLRequest(url: url)
            self.webview.load(request)
        }
    }


}

