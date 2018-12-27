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
    let progressBar = MGSegmentedProgressBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        view.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        progressBar.barBorderWidth = 10
        progressBar.barInset = 20
        progressBar.barBackgroundColor = .gray
        progressBar.backgroundColor = .green
        progressBar.barBorderColor = .orange
        progressBar.setTitle("Hello")
        progressBar.barTitleAlignment = .left
        progressBar.cornerRadius = 10
        progressBar.barTitleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
//        progressBar.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        _ = progressBar.anchor(widthConstant: 200, heightConstant: 100)
        
    }
}
