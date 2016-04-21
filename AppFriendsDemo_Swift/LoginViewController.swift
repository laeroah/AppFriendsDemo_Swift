//
//  ViewController.swift
//  AppFriendsDemo_Swift
//
//  Created by HAO WANG on 3/11/16.
//  Copyright © 2016 Hacknocraft. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var logoSubTextLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extendedLayoutIncludesOpaqueBars = true
        
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.center = self.view.center
        self.view .addSubview(loginButton)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            self.performSegueWithIdentifier("showLandingSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //FBSDKLoginButtonDelegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error != nil {
            //login failed
        }
        else if result.isCancelled{
            // cancelled
        }
        else  {
            //login successful
            
            self.performSegueWithIdentifier("showLandingSegue", sender: self)
        }
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        HCWidget.sharedWidget().logout()
    }
}

