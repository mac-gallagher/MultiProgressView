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
        let button = UIButton()
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.tag = 1
        button.setTitle("Section 0", for: .normal)
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.tag = 2
        button.setTitle("Section 1", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        view.addSubview(progressBar)
        progressBar.anchor(width: 300, height: 100)
        progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(button2)
        button2.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 50, width: 200, height: 50)
        button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(button1)
        button1.anchor(bottom: button2.topAnchor, paddingBottom: 50, width: 200, height: 50)
        button1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //add buttons on either side of "Section 1", "Section 2", etc.
        
        setupProgressBar()
    }
    
    private func setupProgressBar() {
        progressBar.trackInset = 10
        progressBar.trackBackgroundColor = .gray
        progressBar.backgroundColor = .green
        progressBar.trackBorderColor = .orange
        progressBar.setTitle("Background title")
        progressBar.trackTitleAlignment = .left
        progressBar.cornerRadius = 10
        progressBar.trackTitleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        progressBar.dataSource = self
    }
    
    @objc private func handleTap(_ button: UIButton) {
        if button.tag == 1 {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.3, options: .curveLinear, animations: {
                self.progressBar.setProgress(forSection: 0, to: 3)
                self.progressBar.setProgress(forSection: 1, to: 5)
            }, completion: nil)
        } else if button.tag == 2 {
            UIView.animate(withDuration: 0.1) {
                self.progressBar.resetProgress()
            }
        }
    }
}

extension UIViewController: MGSegmentedProgressBarDataSource {
    public func numberOfUnits(in progressBar: MGSegmentedProgressBar) -> Int {
        return 10
    }
    
    public func numberOfSections(in progressBar: MGSegmentedProgressBar) -> Int {
        return 3
    }
    
    public func progressBar(_ progressBar: MGSegmentedProgressBar, barForSection section: Int) -> ProgressBarSection {
        let bar = ProgressBarSection()
        bar.backgroundColor = section % 2 == 0 ? .blue : .red
        bar.setTitle("Title")
        
        //check clipToBounds in tests
        return bar
    }
}
