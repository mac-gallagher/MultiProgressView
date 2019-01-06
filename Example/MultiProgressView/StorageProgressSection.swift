//
//  CustomProgressViewSection.swift
//  MultiProgressView_Example
//
//  Created by Mac Gallagher on 1/5/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

import UIKit
import MultiProgressView

class StorageProgressSection: ProgressViewSection {
    private let rightBorder: UIView = {
        let border = UIView()
        border.backgroundColor = .white
        return border
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(storageType: StorageType) {
        addSubview(rightBorder)
        rightBorder.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, width: 1)
        backgroundColor = storageType.color
    }
}
