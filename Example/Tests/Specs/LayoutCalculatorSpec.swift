//
//  LayoutCalculatorSpec.swift
//  MultiProgressView_Tests
//
//  Created by Mac Gallagher on 3/5/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

import Quick
import Nimble

@testable import MultiProgressView

class LayoutCalculatorSpec: QuickSpec {
    
    override func spec() {
        
        describe("LayoutCalculator") {
            let numberOfSections: Int = 5
            let progressViewWidth: CGFloat = 200
            let progressViewHeight: CGFloat = 50
            let trackInset: CGFloat = 10
            
            var mockDataSource: MockMultiProgressViewDataSource!
            var mockLayoutCalculator: MockLayoutCalculator!
            var progressView: TestableMultiProgressView!
            var subject: LayoutCalculator!
            
            beforeEach {
                mockDataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                mockLayoutCalculator = MockLayoutCalculator()
                
                let progressViewFrame: CGRect = CGRect(x: 0, y: 0, width: progressViewWidth, height: progressViewHeight)
                progressView = TestableMultiProgressView(layoutCalculator: mockLayoutCalculator)
                progressView.frame = progressViewFrame
                progressView.dataSource = mockDataSource
                progressView.trackInset = trackInset
                
                subject = LayoutCalculator()
            }
            
            //MARK: - Track Frame
            
            context("when calling the trackFrame function") {
                
                context("and the line cap type is butt") {
                    
                    beforeEach {
                        progressView.lineCap = .butt
                    }
                    
                    it("should return the correct track frame") {
                        let actualFrame: CGRect = subject.trackFrame(forProgressView: progressView)
                        let expectedFrame: CGRect = CGRect(x: 0,
                                                           y: trackInset,
                                                           width: progressViewWidth,
                                                           height: progressViewHeight - 2 * trackInset)
                        expect(actualFrame).to(equal(expectedFrame))
                    }
                }
                
                context("and the line cap type is round") {
                    
                    beforeEach {
                        progressView.lineCap = .round
                    }
                    
                    it("should return the correct track frame") {
                        let actualFrame: CGRect = subject.trackFrame(forProgressView: progressView)
                        let expectedFrame: CGRect = CGRect(x: trackInset,
                                                           y: trackInset,
                                                           width: progressViewWidth - 2 * trackInset,
                                                           height: progressViewHeight - 2 * trackInset)
                        expect(actualFrame).to(equal(expectedFrame))
                    }
                }
                
                context("and the line cap type is square") {
                    
                    beforeEach {
                        progressView.lineCap = .square
                    }
                    
                    it("should return the correct track frame") {
                        let actualFrame: CGRect = subject.trackFrame(forProgressView: progressView)
                        let expectedFrame: CGRect = CGRect(x: trackInset,
                                                           y: trackInset,
                                                           width: progressViewWidth - 2 * trackInset,
                                                           height: progressViewHeight - 2 * trackInset)
                        expect(actualFrame).to(equal(expectedFrame))
                    }
                }
            }
            
            //MARK: - Section Frame
            
            describe("when calling the sectionFrame function") {
                let trackBounds: CGRect = CGRect(x: 10, y: 20, width: 30, height: 40)
                let section: Int = 1
                
                beforeEach {
                    progressView.track.bounds = trackBounds
                }
                
                context("and there is no progress on the section") {
                    let progress: Float = 0
                    
                    beforeEach {
                        progressView.setProgress(section: section, to: progress)
                    }
                    
                    it("should return the correct frame with zero width") {
                        let actualFrame = subject.sectionFrame(forProgressView: progressView,
                                                               section: section)
                        let expectedFrame: CGRect = CGRect(x: trackBounds.origin.x,
                                                           y: trackBounds.origin.y,
                                                           width: 0,
                                                           height: trackBounds.height)
                        expect(actualFrame).to(equal(expectedFrame))
                    }
                }
                
                context("and there is nonzero progress on the section but no section before it") {
                    let progress: Float = 0.5
                    
                    beforeEach {
                        progressView.setProgress(section: section, to: progress)
                    }
                    
                    it("should return the correct frame with the proper width") {
                        let actualFrame = subject.sectionFrame(forProgressView: progressView,
                                                               section: section)
                        let expectedWidth: CGFloat = trackBounds.width * CGFloat(progress)
                        let expectedFrame: CGRect = CGRect(x: trackBounds.origin.x,
                                                           y: trackBounds.origin.y,
                                                           width: expectedWidth,
                                                           height: trackBounds.height)
                        expect(actualFrame).to(equal(expectedFrame))
                    }
                }
                
                context("and there is nonzero progress on the section and the section before it has a nonzero width") {
                    let firstSectionFrame: CGRect = CGRect(x: 0, y: 0, width: 30, height: 0)
                    let progress: Float = 0.2
                    
                    beforeEach {
                        progressView.progressViewSections[0].frame = firstSectionFrame
                        progressView.setProgress(section: section, to: progress)
                    }
                    
                    it("should return the correct frame with the proper width and origin") {
                        let actualFrame = subject.sectionFrame(forProgressView: progressView,
                                                               section: section)
                        
                        let expectedOrigin: CGPoint = CGPoint(x: trackBounds.origin.x + firstSectionFrame.width,
                                                              y: trackBounds.origin.y)
                        let expectedSize: CGSize = CGSize(width: trackBounds.width * CGFloat(progress),
                                                          height: trackBounds.height)
                        let expectedFrame: CGRect = CGRect(origin: expectedOrigin, size: expectedSize)
                        
                        expect(actualFrame).to(equal(expectedFrame))
                    }
                }
            }
            
            //MARK: - Track Image View Frame
            
            context("when calling the trackImageViewFrame function") {
                
                it("should return the track's bounds") {
                    let actualFrame: CGRect = subject.trackImageViewFrame(forProgressView: progressView)
                    expect(actualFrame).to(equal(progressView.track.bounds))
                }
            }
            
            //MARK: - Section Image View Frame
            
            context("when calling the sectionImageViewFrame function") {
                let sectionBounds: CGRect = CGRect(x: 1, y: 2, width: 3, height: 4)
                var section: ProgressViewSection!
                
                beforeEach {
                    section = progressView.progressViewSections[0]
                    section.bounds = sectionBounds
                }
                
                it("should return the section's bounds") {
                    let actualFrame: CGRect = subject.sectionImageViewFrame(forSection: section)
                    expect(actualFrame).to(equal(sectionBounds))
                }
            }
            
            //MARK: - Corner Radius
            
            context("when calling the cornerRadius function") {
                
                context("and the line cap type is butt") {
                    
                    beforeEach {
                        progressView.lineCap = .butt
                    }
                    
                    it("should return zero") {
                        let actualCornerRadius: CGFloat = subject.cornerRadius(forProgressView: progressView)
                        expect(actualCornerRadius).to(equal(0))
                    }
                }
                
                context("and the line cap type is square") {
                    
                    beforeEach {
                        progressView.lineCap = .square
                    }
                    
                    it("should return zero") {
                        let actualCornerRadius: CGFloat = subject.cornerRadius(forProgressView: progressView)
                        expect(actualCornerRadius).to(equal(0))
                    }
                }
                
                context("and the line cap type is round and corner radius is equal to zero") {
                    
                    beforeEach {
                        progressView.lineCap = .round
                        progressView.cornerRadius = 0
                    }
                    
                    it("should return half the height of the progressView") {
                        let actualCornerRadius: CGFloat = subject.cornerRadius(forProgressView: progressView)
                        expect(actualCornerRadius).to(equal(progressViewHeight / 2))
                    }
                }
                
                context("and the line cap type is round and corner radius is nonzero") {
                    let cornerRadius: CGFloat = 5
                    
                    beforeEach {
                        progressView.lineCap = .round
                        progressView.cornerRadius = cornerRadius
                    }
                    
                    it("should return the given corner radius") {
                        let actualCornerRadius: CGFloat = subject.cornerRadius(forProgressView: progressView)
                        expect(actualCornerRadius).to(equal(cornerRadius))
                    }
                }
            }
            
            //MARK: - Track Corner Radius
            
            context("when calling the trackCornerRadius function") {
                
                context("and the line cap type is butt") {
                    
                    beforeEach {
                        progressView.lineCap = .butt
                    }
                    
                    it("should return zero") {
                        let actualCornerRadius: CGFloat = subject.trackCornerRadius(forProgressView: progressView)
                        expect(actualCornerRadius).to(equal(0))
                    }
                }
                
                context("and the line cap type is square") {
                    
                    beforeEach {
                        progressView.lineCap = .square
                    }
                    
                    it("should return zero") {
                        let actualCornerRadius: CGFloat = subject.trackCornerRadius(forProgressView: progressView)
                        expect(actualCornerRadius).to(equal(0))
                    }
                }
                
                context("and the line cap type is round and corner radius is equal to zero") {
                    let trackBounds: CGRect = CGRect(x: 0, y: 0, width: 0, height: 500)
                    
                    beforeEach {
                        progressView.track.bounds = trackBounds
                        progressView.lineCap = .round
                        progressView.cornerRadius = 0
                    }
                    
                    it("should return half the height of the track") {
                        let actualCornerRadius: CGFloat = subject.trackCornerRadius(forProgressView: progressView)
                        expect(actualCornerRadius).to(equal(trackBounds.height / 2))
                    }
                }
                
                context("and the line cap type is round and corner radius is nonzero") {
                    let trackBounds: CGRect = CGRect(x: 0, y: 0, width: 0, height: 500)
                    let cornerRadius: CGFloat = 5
                    var cornerRadiusFactor: CGFloat!
                    
                    beforeEach {
                        progressView.track.bounds = trackBounds
                        progressView.lineCap = .round
                        progressView.cornerRadius = cornerRadius
                        cornerRadiusFactor = cornerRadius / progressViewHeight
                    }
                    
                    it("should return the correct scaled corner radius") {
                        let actualCornerRadius: CGFloat = subject.trackCornerRadius(forProgressView: progressView)
                        let expectedCornerRaduis: CGFloat = cornerRadiusFactor * trackBounds.height
                        
                        expect(actualCornerRadius).to(equal(expectedCornerRaduis))
                    }
                }
            }
            
            //TODO: Write these tests
            describe("anchorToSuperview") {
                
                context("when calling the anchorToSuperview function") {
                    let view: UIView = UIView()
                    
                    context("and the view has no superview") {
                        
                        it("should return no constraints") {
                            let actualConstraints: [NSLayoutConstraint] = subject.anchorToSuperview(view,
                                                                                                    withAlignment: .bottom,
                                                                                                    insets: UIEdgeInsets())
                            expect(actualConstraints).to(equal([]))
                        }
                    }
                    
                }
                
                func testConstraint() {
                    //check isActive, constant, item1, etc...
                    //or conform to equatable
                }
            }
        }
    }
}
