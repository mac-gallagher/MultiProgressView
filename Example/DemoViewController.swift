//
//  DemoViewController.swift
//  MultiProgressViewExample
//
//  Created by Mac Gallagher on 4/26/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

import UIKit

class DemoViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Demo"
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Single Progress View (Programmatic)"
        case 1:
            cell.textLabel?.text = "Multiple Progress Views (Storyboard)"
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(StorageExampleViewController(), animated: true)
        case 1:
            let storyboard = UIStoryboard(name: "LanguageExample", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LanguageExampleViewController")
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
