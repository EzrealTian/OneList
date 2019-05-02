//
//  DetailViewController.swift
//  OneList
//
//  Created by 田逸昕 on 2019/4/24.
//  Copyright © 2019 Ezreal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var title2: String?
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = title2
        // Do any additional setup after loading the view.
    }

}
