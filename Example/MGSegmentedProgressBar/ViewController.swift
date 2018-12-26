//
//  ViewController.swift
//  MGSegmentedProgressBar
//
//  Created by Mac Gallagher on 7/7/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit
import MGSegmentedProgressBar

class ViewController: UIViewController {
    let bar = ProgressBarSection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        bar.backgroundColor = .lightGray
        bar.setTitle("Hello")
        
        view.addSubview(bar)
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bar.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        _ = bar.anchor(widthConstant: 200, heightConstant: 50)
    }
}
