//
//  CodingLanguage.swift
//  MultiProgressViewExample
//
//  Created by Mac Gallagher on 4/26/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

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
