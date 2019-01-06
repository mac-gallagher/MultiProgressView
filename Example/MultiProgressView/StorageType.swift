//
//  StorageType.swift
//  MultiProgressView_Example
//
//  Created by Mac Gallagher on 1/5/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

import UIKit

enum StorageType {
    static var allTypes: [StorageType] = [.app, .message, .media, .photo, .mail, .unknown, .other]
    
    case app
    case message
    case media
    case photo
    case mail
    case unknown
    case other
    
    var description: String {
        switch self {
        case .app:
            return "Apps"
        case .message:
            return "Messages"
        case .media:
            return "Media"
        case .photo:
            return "Photos"
        case .mail:
            return "Mail"
        case .unknown:
            return ""
        case .other:
            return "Other"
        }
    }
    
    var color: UIColor {
        switch self {
        case .app:
            return .progressRed
        case .message:
            return .progressGreen
        case .media:
            return .progressPurple
        case .photo:
            return .progressYellow
        case .mail:
            return .progressBlue
        case .unknown:
            return .progressOrange
        case .other:
            return .progressGray
        }
    }
}
