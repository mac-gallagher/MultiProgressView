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

enum CodingLanguage: Int {
  case none, html, net, java, javascript, css

  var description: String {
    switch self {
    case .none:
      return "Language"
    case .html:
      return "HTML/HTML5"
    case .net:
      return "ASP.Net"
    case .java:
      return "Java"
    case .javascript:
      return "JavaScript/jQuery"
    case .css:
      return "CSS/CSS3"
    }
  }

  var darkColor: UIColor {
    switch self {
    case .none:
      return .black
    case .html:
      return UIColor.LanguageExample.progressBlueDark
    case .net:
      return UIColor.LanguageExample.progressGreenDark
    case .java:
      return UIColor.LanguageExample.progressCyanDark
    case .javascript:
      return UIColor.LanguageExample.progressYellowDark
    case .css:
      return UIColor.LanguageExample.progressRedDark
    }
  }

  var lightColor: UIColor {
    switch self {
    case .none:
      return .black
    case .html:
      return UIColor.LanguageExample.progressBlueLight
    case .net:
      return UIColor.LanguageExample.progressGreenLight
    case .java:
      return UIColor.LanguageExample.progressCyanLight
    case .javascript:
      return UIColor.LanguageExample.progressYellowLight
    case .css:
      return UIColor.LanguageExample.progressRedLight
    }
  }
}
