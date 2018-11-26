//
//  ViewController.swift
//  TestLink
//
//  Created by Daniel Ardeleanu on 11/22/18.
//  Copyright © 2018 Daniel Ardeleanu. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    @IBOutlet weak var myWebView: WKWebView!
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldOutlet.delegate = self
        myWebView.navigationDelegate = self
        
       
    }

    func openWebPage() {
        if let userInsertedLink = textFieldOutlet.text {
            guard let url = URL(string: userInsertedLink) else {
                showAlart(message: "cannot convert Url")
                return }
            if UIApplication.shared.canOpenURL(url) {
                let urlRequest:URLRequest = URLRequest(url: url)
                myWebView.load(urlRequest)
            }
            else {
                showAlart(message: "Please enter a valid URL.")
            }
      
        }
    }
    
    func showAlart(message:String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        openWebPage()
        self.view.endEditing(true)
        return false
    }
    
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if(navigationResponse.response .isKind(of: HTTPURLResponse.self)){
            let response = navigationResponse.response as! HTTPURLResponse
            if(response.statusCode == 401){
               showAlart(message: "401 Unauthorized")
            }
            else if (response.statusCode == 400) {
                showAlart(message: "Bad Request")
            }
            else if (response.statusCode == 403) {
                showAlart(message: "Forbidden")
            }
            else if (response.statusCode == 522) {
                showAlart(message: "Connection timed out")
            }
            else if (response.statusCode == 524) {
                showAlart(message: "A timeout occurred")
            }
            else if (response.statusCode == 504) {
                showAlart(message: "Gateway Timeout")
            }
            else {
                showAlart(message: "\(response.statusCode)")
            }
        }
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
}

