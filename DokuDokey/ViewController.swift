//
//  ViewController.swift
//  DokuDokey
//
//  Created by 오승연 on 2021/08/05.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate { //UITextFieldDelegate 프로토콜 채택
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func moveFillQuizViewWithNavigation(_ sender: Any) {
        guard let fillQuizView = self.storyboard?.instantiateViewController(identifier: "FillQuizVC") else {return
        }
        self.navigationController?.pushViewController(fillQuizView, animated: true)
    }
}

