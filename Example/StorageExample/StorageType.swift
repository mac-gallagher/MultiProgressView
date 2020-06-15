//
//  StorageType.swift
//  MultiProgressViewExample
//
//  Created by Mac Gallagher on 1/5/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

import UIKit

enum StorageType: Int {
  case app, message, media, photo, mail, unknown, other

  static var allTypes: [StorageType] = [.app, .message, .media, .photo, .mail, .unknown, .other]

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
      return UIColor.StorageExample.progressRed
    case .message:
      return UIColor.StorageExample.progressGreen
    case .media:
      return UIColor.StorageExample.progressPurple
    case .photo:
      return UIColor.StorageExample.progressYellow
    case .mail:
      return UIColor.StorageExample.progressBlue
    case .unknown:
      return UIColor.StorageExample.progressOrange
    case .other:
      return UIColor.StorageExample.progressGray
    }
  }
}
