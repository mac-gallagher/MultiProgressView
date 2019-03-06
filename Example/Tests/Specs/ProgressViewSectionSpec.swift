//
//  ProgressViewSectionSpec.swift
//  MultiProgressView_Tests
//
//  Created by Mac Gallagher on 12/26/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Quick
import Nimble
import MultiProgressView

class ProgressViewSectionSpec: QuickSpec {
    
    override func spec() {
        
        describe("ProgressViewSection") {
            let subjectFrame: CGRect = CGRect(x: 10, y: 10, width: 100, height: 50)
            var subject: ProgressViewSection!
            
            beforeEach {
                subject = ProgressViewSection(frame: subjectFrame)
            }
            
            describe("initialization") {
                
                context("when initializing a new section") {
                    
                    beforeEach {
                        subject.layoutSubviews()
                    }
                    
                    it("should have a title label") {
                        expect(subject.titleLabel).toNot(beNil())
                    }
                    
                    it("should have an image view with the correct frame") {
                        expect(subject.imageView).toNot(beNil())
                    }
                    
                    it("should have a black background color") {
                        expect(subject.backgroundColor).to(equal(.black))
                    }
                    
                    it("should have a center title alignment") {
                        expect(subject.titleAlignment).to(equal(.center))
                    }
                    
                    it("should clip to bounds") {
                        expect(subject.clipsToBounds).to(beTrue())
                    }
                }
            }
            
            describe("title label") {
                
                context("when setting the section's title") {
                    let title: String = "title"
                    
                    beforeEach {
                        subject.setTitle(title)
                    }
                    
                    it("should have a title") {
                        expect(subject.titleLabel.text).to(equal(title))
                    }
                }
                
                context("when setting the section's attributed title") {
                    let attributedTitle: NSAttributedString = NSAttributedString(string: "title")
                    
                    beforeEach {
                        subject.setAttributedTitle(attributedTitle)
                    }
                    
                    it("should have an attributed title") {
                        expect(subject.titleLabel.attributedText).to(equal(attributedTitle))
                    }
                }
            }
            
            describe("image view") {
                
                context("when setting the section's image") {
                    let image: UIImage = UIImage()
                    
                    beforeEach {
                        let subview1 = UIView()
                        subject.addSubview(subview1)
                        
                        subject.setImage(image)
                        
                        let subview2 = UIView()
                        subject.addSubview(subview2)
                    }
                    
                    it("should have an image on it's image view") {
                        expect(subject.imageView.image).to(equal(image))
                    }
                    
                    it("should have its image view behind all other subviews") {
                        expect(subject.subviews.first is UIImageView).to(beTrue())
                    }
                }
            }
        }
    }
}
