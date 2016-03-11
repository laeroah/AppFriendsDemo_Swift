//
//  ViewController.swift
//  AppFriendsDemo_Swift
//
//  Created by HAO WANG on 3/11/16.
//  Copyright © 2016 Hacknocraft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        
        HCWidget.showSocialWidgetOnViewController(self, viewControllerPath: "/home", disableScreenshot: false) { () -> Void in
            
            debugPrint("AppFriends widget is shown now")
        }
    }
}

