//
//  ViewController.swift
//  GMSwitchDemo
//
//  Created by Nguyen Duc Hoang on 9/15/15.
//  Copyright © 2015 Nguyen Duc Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var switcher1:GMSwitcher!
    @IBOutlet weak var switcher2:GMSwitcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        switcher1.turnOn(1)
        switcher2.turnOn(0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

