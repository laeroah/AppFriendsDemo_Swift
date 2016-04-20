//
//  ViewController.swift
//  AppFriendsDemo_Swift
//
//  Created by HAO WANG on 3/11/16.
//  Copyright © 2016 Hacknocraft. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        HCWidget.sharedWidget().showWidgetBubbleOnViewController(self, allowScreenShotSharing: true, atPosition: CGPointMake(self.view.frame.size.width - 60, 160))
    }
}

