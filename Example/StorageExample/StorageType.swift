///
/// MIT License
///
/// Copyright (c) 2020 Mac Gallagher
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.
///

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
