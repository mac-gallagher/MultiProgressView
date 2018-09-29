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
    
    let button1: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 1
        button.setTitle("Section 1", for: .normal)
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 2
        button.setTitle("Section 2", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //configure progress bar
        view.addSubview(progressBar)
        progressBar.frame = CGRect(x: 50, y: 50, width: view.bounds.width - 100, height: 50)
        progressBar.dataSource = self
        
        //configure buttons
        view.addSubview(button1)
        button1.frame = CGRect(x: 50, y: 100, width: view.bounds.width - 100, height: 50)
        button1.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
        
        view.addSubview(button2)
        button2.frame = CGRect(x: 50, y: 150, width: view.bounds.width - 100, height: 50)
        button2.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
    }
    
    @objc func handleTouch(_ sender: UIButton) {
        progressBar.advance(section: sender.tag - 1)
    }
    
}

//MARK: Data Source

extension ViewController: MGSegmentedProgressBarDataSource {
    
    func progressBar(_ progressBar: MGSegmentedProgressBar, barForSection section: Int) -> MGBarView {
        let bar =  MGBarView()
        bar.backgroundColor = section % 2 == 0 ? .red : .blue
        bar.titleAlwaysVisible = true
        return bar
    }
    
    func numberOfSections(in progressBar: MGSegmentedProgressBar) -> Int {
        return 2
    }
    
    func numberOfSteps(in progressBar: MGSegmentedProgressBar) -> Int {
        return 10
    }
    
    func progressBar(_ progressBar: MGSegmentedProgressBar, maximumNumberOfStepsForSection section: Int) -> Int {
        if section == 1 { return 1}
        return Int.max
    }
    
    func progressBar(_ progressBar: MGSegmentedProgressBar, titleForSection section: Int) -> String? {
        return "Hello!"
    }
    
}
