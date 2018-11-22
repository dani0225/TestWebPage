//
//  ViewController.swift
//  TestLink
//
//  Created by Daniel Ardeleanu on 11/22/18.
//  Copyright © 2018 Daniel Ardeleanu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldOutlet.delegate = self
       
    }

    func openWebPage() {
        if let userInsertedLink = textFieldOutlet.text {
            guard let url = URL(string: userInsertedLink) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
            else {
                let alert = UIAlertController(title: "Error", message: "Please enter a valid URL.", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
      
        }
    }
    

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        openWebPage()
        self.view.endEditing(true)
        return false
    }
}

