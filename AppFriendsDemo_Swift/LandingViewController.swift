//
//  LandingViewController.swift
//  AppFriendsDemo_Swift
//
//  Created by HAO WANG on 4/20/16.
//  Copyright © 2016 Hacknocraft. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LandingViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidAppear(animated: Bool) {
        
        HCWidget.sharedWidget().showWidgetBubbleOnViewController(self, allowScreenShotSharing: true, atPosition: CGPointMake(self.view.frame.size.width - 60, 160))
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.title = "Demo"
        self.userProfileImageView.clipsToBounds = true
        self.userProfileImageView.layer.cornerRadius = self.userProfileImageView.frame.size.width/2
        
        FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler { (connection, result, error) in
            
            if (error == nil) {
                print("fetched user:\(result)");
                
                let avatarURL = "https://graph.facebook.com/\(result.objectForKey("id")!)/picture?type=large"
                
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    
                    let avatarImage = UIImage.init(data: NSData(contentsOfURL: NSURL(string: avatarURL)!)!)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.userProfileImageView.image = avatarImage
                    }
                }
                
            }
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        var center = self.view.center
        center.y += 50
        loginButton.center = center
        self.view .addSubview(loginButton)
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
        }
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        HCWidget.sharedWidget().logout()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
