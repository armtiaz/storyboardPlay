//
//  ViewController.swift
//  storyboardPlay
//
//  Created by Arman Imtiaz on 13/3/22.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemIndigo
        
    }
        
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let loggedIn = UserDefaults.standard.bool(forKey: "isLoggedin")
        if !loggedIn {
            //let vc = LoginViewController()
            //
            //
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "loginStoryboardID") else { return  }
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }

}
