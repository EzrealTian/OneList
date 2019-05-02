//
//  MainPageViewController.swift
//  OneList
//
//  Created by 田逸昕 on 2019/4/24.
//  Copyright © 2019 Ezreal. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet weak var leftMenuWidthConstraints: NSLayoutConstraint!
    var leftMenuIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftMenuWidthConstraints.constant = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func leftMenuButtonTapped(_ sender: Any) {
         leftMenuWidthConstraints.constant = leftMenuIsOpen ? 0 : 165
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        leftMenuIsOpen = !leftMenuIsOpen
    }
    
}
