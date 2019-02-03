//
//  LoginViewController.swift
//  Twitter
//
//  Created by Ryan Sullivan on 2/2/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "loggedIn") {
            self.performSegue(withIdentifier: "Login", sender: self)
        }
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let myurl = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myurl, success: {
            // success
            UserDefaults.standard.set(true, forKey: "loggedIn")
            self.performSegue(withIdentifier: "Login", sender: self)
        }, failure: { (error) in
            // failure
            print("Could not log in")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
