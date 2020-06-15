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

extension UIColor {

  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
  }

  enum StorageExample {
    static let progressRed = UIColor.rgb(red: 251, green: 16, blue: 68)
    static let progressGreen = UIColor.rgb(red: 67, green: 213, blue: 82)
    static let progressPurple = UIColor.rgb(red: 70, green: 58, blue: 205)
    static let progressYellow = UIColor.rgb(red: 252, green: 196, blue: 9)
    static let progressBlue = UIColor.rgb(red: 10, green: 96, blue: 253)
    static let progressOrange = UIColor.rgb(red: 251, green: 128, blue: 7)
    static let progressGray = UIColor.rgb(red: 188, green: 186, blue: 194)
    static let progressBackground = UIColor.rgb(red: 224, green: 224, blue: 224)

    static let backgroundGray = UIColor.rgb(red: 235, green: 235, blue: 242)
    static let borderColor = UIColor.rgb(red: 189, green: 189, blue: 189)
  }

  enum LanguageExample {
    static let progressBlueDark = UIColor.rgb(red: 45, green: 94, blue: 146)
    static let progressBlueLight = UIColor.rgb(red: 54, green: 117, blue: 190)
    static let progressGreenDark = UIColor.rgb(red: 65, green: 136, blue: 61)
    static let progressGreenLight = UIColor.rgb(red: 77, green: 173, blue: 74)
    static let progressCyanDark = UIColor.rgb(red: 63, green: 141, blue: 167)
    static let progressCyanLight = UIColor.rgb(red: 79, green: 177, blue: 216)
    static let progressYellowDark = UIColor.rgb(red: 182, green: 125, blue: 51)
    static let progressYellowLight = UIColor.rgb(red: 233, green: 158, blue: 60)
    static let progressRedDark = UIColor.rgb(red: 160, green: 51, blue: 52)
    static let progressRedLight = UIColor.rgb(red: 204, green: 61, blue: 62)

    static let borderColor = UIColor.rgb(red: 189, green: 189, blue: 189)
  }
}
