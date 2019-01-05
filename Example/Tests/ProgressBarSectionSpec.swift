//
//  ProgressBarSectionSpec.swift
//  MultiProgressView_Tests
//
//  Created by Mac Gallagher on 12/26/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Quick
import Nimble
import MultiProgressView

class ProgressBarSectionSpec: QuickSpec {
    private let sectionWidth: CGFloat = 100
    private let sectionHeight: CGFloat = 50
    
    override func spec() {
        var section: ProgressViewSection!
        
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
                let title: String = "title"
                
                beforeEach {
                    section = self.setupBarSection(configure: { section in
                        section.setTitle(title)
                    })
                }
                
                it("should have a title") {
                    expect(section.titleLabel?.text).to(equal(title))
                }
            }
            
            context("when setting the section's attributed title") {
                let title: NSAttributedString = NSAttributedString(string: "title")
                
                beforeEach {
                    section = self.setupBarSection(configure: { section in
                        section.setAttributedTitle(title)
                    })
                }
                
                it("should have an attributed title") {
                    expect(section.titleLabel?.attributedText).to(equal(title))
                }
            }
        }
        
        describe("image view") {
            context("when setting the section's image") {
                let image = UIImage()
                
                beforeEach {
                    section = self.setupBarSection(configure: { section in
                        let subview1 = UIView()
                        section.addSubview(subview1)
                        
                        section.setImage(image)
                        
                        let subview2 = UIView()
                        section.addSubview(subview2)
                    })
                }
                
                it("should have an image view with the correct bounds") {
                    expect(section.imageView?.frame).to(equal(section.bounds))
                }
                
                it("should have an image on it's image view") {
                    expect(section.imageView?.image).to(equal(image))
                }
                
                it("should have its image view behind all other subviews") {
                    expect(section.subviews.first is UIImageView).to(beTrue())
                }
            }
        }
    }
}

extension ProgressBarSectionSpec {
    func setupBarSection(configure: (ProgressViewSection) -> Void = { _ in } ) -> ProgressViewSection {
        let parentView = UIView()
        let section = ProgressViewSection()
        parentView.addSubview(section)
        
        section.translatesAutoresizingMaskIntoConstraints = false
        section.widthAnchor.constraint(equalToConstant: sectionWidth).isActive = true
        section.heightAnchor.constraint(equalToConstant: sectionHeight).isActive = true
        
        configure(section)
        
        section.layoutIfNeeded()
        return section
    }
}
