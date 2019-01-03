//
//  MGSegmentedProgressBar_Tests.swift
//  MGSegmentedProgressBar_Tests
//
//  Created by Mac Gallagher on 12/26/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Quick
import Nimble
import MultiProgressView

class ProgressBarSectionSpec: QuickSpec {
    override func spec() {
        var section: ProgressBarSection!
        
        describe("initialization") {
            context("when initializing a new section") {
                beforeEach {
                    section = self.setupBarSection()
                }
                
                it("should not have a title label") {
                    expect(section.titleLabel).to(beNil())
                }
                
                it("should have a black background color") {
                    expect(section.backgroundColor).to(equal(.black))
                }
                
                it("should have a center title alignment") {
                    expect(section.titleAlignment).to(equal(.center))
                }
                
                it("should clip to bounds") {
                    expect(section.clipsToBounds).to(beTrue())
                }
            }
        }
        
        describe("title label") {
            context("when setting the section's title") {
                var title: String!
                
                beforeEach {
                    title = "title"
                    section = self.setupBarSection(configure: { section in
                        section.setTitle(title)
                    })
                }
                
                it("should have a title") {
                    expect(section.titleLabel?.text).to(equal(title))
                }
            }
            
            context("when setting the section's attributed title") {
                var title: NSAttributedString!
                
                beforeEach {
                    title = NSAttributedString(string: "title")
                    section = self.setupBarSection(configure: { section in
                        section.setAttributedTitle(title)
                    })
                }
                
                it("should have an attributed title") {
                    expect(section.titleLabel?.attributedText).to(equal(title))
                }
            }
        }
    }
}

extension ProgressBarSectionSpec {
    func setupBarSection(configure: (ProgressBarSection) -> Void = { _ in } ) -> ProgressBarSection {
        let section = ProgressBarSection()
        configure(section)
        return section
    }
}
