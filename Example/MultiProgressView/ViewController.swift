//
//  ViewController.swift
//  MultiProgressView
//
//  Created by Mac Gallagher on 7/7/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit
import MultiProgressView

class ViewController: UIViewController {
    let progressBar = MultiProgressView()
    let button1: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.tag = 1
        button.setTitle("Animate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.tag = 2
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
        progressBar.trackBorderWidth = 2
        progressBar.trackBorderColor = .gray
        progressBar.trackBackgroundColor = .lightGray
        progressBar.setTitle("Background title")
        progressBar.trackTitleAlignment = .left
        progressBar.cornerRadius = 10
        progressBar.trackTitleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        progressBar.dataSource = self
    }
    
    @objc private func handleTap(_ button: UIButton) {
        if button.tag == 1 {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.3, options: .curveLinear, animations: {
                self.progressBar.setProgress(section: 0, to: 3)
            }, completion: nil)
            UIView.animate(withDuration: 1, delay: 0.7, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.3, options: .curveLinear, animations: {
                self.progressBar.setProgress(section: 1, to: 5)
            }, completion: nil)
            UIView.animate(withDuration: 1, delay: 0.4, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.3, options: .curveLinear, animations: {
                self.progressBar.setProgress(section: 2, to: 1)
            }, completion: nil)
        } else if button.tag == 2 {
            UIView.animate(withDuration: 0.1) {
                self.progressBar.resetProgress()
            }
        }
    }
}

extension UIViewController: MultiProgressViewDataSource {
    public func numberOfUnits(in progressBar: MultiProgressView) -> Int {
        return 10
    }
    
    public func numberOfSections(in progressBar: MultiProgressView) -> Int {
        return 3
    }
    
    public func progressView(_ progressBar: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        let bar = ProgressViewSection()
        switch section {
        case 0:
            bar.backgroundColor = .blue
        case 1:
            bar.backgroundColor = .red
        case 2:
            bar.backgroundColor = .green
        default:
            break
        }
        bar.setTitle("Title")
        return bar
    }
}
