//
//  MGSegmentedProgressBar_Tests.swift
//  MGSegmentedProgressBar_Tests
//
//  Created by Mac Gallagher on 12/26/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import MGSegmentedProgressBar

class ProgressBarSectionTests: QuickSpec {
    override func spec() {
        var section: ProgressBarSection!
        
        beforeEach {
            section = ProgressBarSection()
        }
        
        context("when initializing a new section") {
            it("should not have a title label") {
                expect(section.titleLabel).to(beNil())
            }
            
            it("should have a black background color") {
                expect(section.backgroundColor).to(equal(.black))
            }
            
            it("should have a center title alignment") {
                expect(section.titleAlignment).to(equal(.center))
            }
        }
        
        context("when setting the section's title") {
            var title: String!
            beforeEach {
                title = "Title"
                section.setTitle(title)
            }
            
            it("should have a title") {
                expect(section.titleLabel?.text).to(equal(title))
            }
        }
        
        context("when setting the section's attributed title") {
            var title: NSAttributedString!
            beforeEach {
                title = NSAttributedString(string: "title")
                section.setAttributedTitle(title)
            }
            
            it("should have an attributed title") {
                expect(section.titleLabel?.attributedText).to(equal(title))
            }
        }
        
        context("when setting the section's title label alignment") {
            
        }
    }
    
    func testTitleLabelAlignmentLayout() {
//        let section = ProgressBarSection()
    }
}
