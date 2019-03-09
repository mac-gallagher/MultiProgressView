//
//  MultiProgressViewSpec.swift
//  MultiProgressView_Tests
//
//  Created by Mac Gallagher on 12/26/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Quick
import Nimble

@testable import MultiProgressView

class MultiProgressViewSpec: QuickSpec {
    
    override func spec() {
        var mockLayoutCalculator: MockLayoutCalculator!
        var subject: TestableMultiProgressView!
        
        fdescribe("MultiProgressView") {
            
            beforeEach {
                mockLayoutCalculator = MockLayoutCalculator()
                subject = TestableMultiProgressView(layoutCalculator: mockLayoutCalculator)
            }
            
            //MARK: - Initialization
            
            describe("initialization") { //Done!
                var progressView: MultiProgressView!
                
                context("when initializing a new progress view with the default initializer") {
                    
                    beforeEach {
                        progressView = MultiProgressView()
                    }
                    
                    testInitialProperties()
                    testInitialTrackProperties()
                }
                
                context("when initializing a new progress view with the required initializer") {
                    
                    beforeEach {
                        progressView = MultiProgressView(coder: NSCoder())
                    }
                    
                    //TODO: Replace this test once the required initializer has been implemented
                    it("should have a nil progress view") {
                        expect(progressView).to(beNil())
                    }
                }
                
                func testInitialProperties() {
                    it("should not have a data source") {
                        expect(subject.dataSource).to(beNil())
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(subject.cornerRadius).to(equal(0))
                    }
                    
                    it("should have a border color of black") {
                        expect(subject.borderColor).to(equal(.black))
                    }
                    
                    it("should have a border width of zero") {
                        expect(subject.borderWidth).to(equal(0))
                    }
                    
                    it("should have a round line cap type") {
                        expect(subject.lineCap).to(equal(.square))
                    }
                    
                    it("should have total progress equal to zero") {
                        expect(subject.totalProgress).to(equal(0))
                    }
                    
                    it("should clip its layer to its bounds") {
                        expect(subject.layer.masksToBounds).to(beTrue())
                    }
                    
                    it("should have exactly one subview") {
                        expect(subject.subviews.contains(subject.track)).to(beTrue())
                    }
                }
                
                func testInitialTrackProperties() {
                    it("should have a track border width of zero") {
                        expect(subject.trackBorderWidth).to(equal(0))
                    }
                    
                    it("should have a track border color of black") {
                        expect(subject.trackBorderColor).to(equal(.black))
                    }
                    
                    it("should have track insets equal to zero") {
                        expect(subject.trackInset).to(equal(0))
                    }
                    
                    it("should have a track background color of white") {
                        expect(subject.trackBackgroundColor).to(equal(.white))
                    }
                    
                    it("should have a track title label") {
                        expect(subject.trackTitleLabel).toNot(beNil())
                    }
                    
                    it("should have track title insets equal to zero") {
                        expect(subject.trackTitleEdgeInsets).to(equal(.zero))
                    }
                    
                    it("should have a center track title alignment") {
                        expect(subject.trackTitleAlignment).to(equal(.center))
                    }
                    
                    it("should have a track image view") {
                        expect(subject.trackImageView).toNot(beNil())
                    }
                    
                    it("should have its track's layer mask to its bounds") {
                        expect(subject.track.layer.masksToBounds).to(beTrue())
                    }
                    
                    it("should have a track with exactly two subviews") {
                        expect(subject.track.subviews.contains(subject.trackTitleLabel)).to(beTrue())
                        expect(subject.track.subviews.contains(subject.trackImageView)).to(beTrue())
                    }
                }
            }
            
            //MARK: - Corner Radius
            
            describe("corner radius") {
                
                context("when setting the corner radius") {
                    
                    beforeEach {
                        subject.cornerRadius = 0
                    }
                    
                    it("should trigger a new layout cycle") {
                        expect(subject.setNeedsLayoutCalled).to(beTrue())
                    }
                }
            }
            
            //MARK: - Track Inset
            
            describe("track inset") {
                
                context("when setting the track insets") {
                    
                    beforeEach {
                        subject.trackInset = 0
                    }
                    
                    it("should trigger a new layout cycle") {
                        expect(subject.setNeedsLayoutCalled).to(beTrue())
                    }
                }
            }
            
            //MARK: - Track Background Color
            
            describe("progress view section background color") {
                
                context("when setting the progress view section's background color") {
                    let color: UIColor = .blue
                    
                    beforeEach {
                        subject.trackBackgroundColor = color
                    }
                    
                    it("should correctly set the progress view's background color") {
                        expect(subject.trackBackgroundColor).to(be(color))
                    }
                }
            }
            
            //MARK: - Track Title Insets
            
            describe("track title inset") {
                
                context("when setting the track title insets") {
                    
                    beforeEach {
                        subject.trackTitleEdgeInsets = UIEdgeInsets()
                    }
                    
                    it("should trigger a new layout cycle") {
                        expect(subject.setNeedsLayoutCalled).to(beTrue())
                    }
                }
            }
            
            //MARK: - Track Title Alignment
            
            describe("track title alignment") {
                
                context("when setting the track title alignment") {
                    
                    beforeEach {
                        subject.trackTitleAlignment = .bottom
                    }
                    
                    it("should trigger a new layout cycle") {
                        expect(subject.setNeedsLayoutCalled).to(beTrue())
                    }
                }
            }
            
            //MARK: - Line Cap
            
            describe("line cap type") {
                
                context("when setting the line cap type") {
                    
                    beforeEach {
                        subject.lineCap = .round
                    }
                    
                    it("should trigger a new layout cycle") {
                        expect(subject.setNeedsLayoutCalled).to(beTrue())
                    }
                }
            }
            
            //MARK: - Borders
            
            describe("borders") {
                
                context("when setting the border color") {
                    let color: UIColor = .blue
                    
                    beforeEach {
                        subject.borderColor = color
                    }
                    
                    it("should correctly set the border color") {
                        expect(subject.borderColor).to(be(color))
                    }
                }
                
                context("when setting the border width") {
                    let width: CGFloat = CGFloat()
                    
                    beforeEach {
                        subject.borderWidth = width
                    }
                    
                    it("should correctly set the border width") {
                        expect(subject.borderWidth).to(be(width))
                    }
                }
                
                context("when setting the progress view's border color") {
                    let color: UIColor = .blue
                    
                    beforeEach {
                        subject.trackBorderColor = color
                    }
                    
                    it("should correctly set the progress view's border color") {
                        expect(subject.trackBorderColor).to(be(color))
                    }
                }
                
                context("when setting the progress view's border width") {
                    let width: CGFloat = CGFloat()
                    
                    beforeEach {
                        subject.trackBorderWidth = width
                    }
                    
                    it("should correctly set the progress view's border width") {
                        expect(subject.trackBorderWidth).to(be(width))
                    }
                }
            }
            
            //MARK: - Layout Subviews
            
            describe("layout") {
                
                context("when the layoutSubviews method is called") {
                    
                }
            }
            
            //MARK: - Set Track Image
            
            describe("setTrackImage") {
                
                context("when calling the setTrackImage method") {
                    let image: UIImage = UIImage()
                    
                    beforeEach {
                        subject.setTrackImage(image)
                    }
                    
                    it("should have an image on it's track image view") {
                        expect(subject.trackImageView.image).to(equal(image))
                    }
                }
            }
            
            //MARK: - Set Title
            
            describe("progress view title label") {
                
                context("when setting the progress view's title") {
                    let title: String = String()
                    
                    beforeEach {
                        subject.setTitle(title)
                    }
                    
                    it("should show the expected title") {
                        expect(subject.trackTitleLabel.text).to(be(title))
                    }
                }
                
                context("when setting the the progress view's attributed title") {
                    let title: NSAttributedString = NSAttributedString(string: "title")
                    
                    beforeEach {
                        subject.setAttributedTitle(title)
                    }
                    
                    it("should show the expected attributed title") {
                        expect(subject.trackTitleLabel.attributedText).to(equal(title))
                    }
                }
            }
            
            //MARK: - Data Source
            
            describe("data source") {
                
                context("when the data source is changed") {
                    
                    beforeEach {
                        subject.dataSource = MockMultiProgressViewDataSource()
                    }
                    
                    it("should call reloadData") {
                        expect(subject.reloadDataCalled).to(beTrue())
                    }
                }
                
                context("when setting the data source") {
                    
                    context("and the number of sections is zero") {
                        let numberOfSections: Int = 0
                        var dataSource: MockMultiProgressViewDataSource!
                        
                        beforeEach {
                            dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                            subject.dataSource = dataSource
                        }
                        
                        it("should retrieve the number of sections") {
                            expect(dataSource.numberOfSectionsCalled).to(beTrue())
                        }
                        
                        it("should not call the viewForSectionAt function") {
                            expect(dataSource.viewForSectionCalledCount).to(equal(0))
                        }
                    }
                    
                    context("and the number of sections is nonzero") {
                        let numberOfSections: Int = 10
                        var dataSource: MockMultiProgressViewDataSource!
                        
                        beforeEach {
                            dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                            subject.dataSource = dataSource
                        }
                        
                        it("should retrieve the number of sections") {
                            expect(dataSource.numberOfSectionsCalled).to(beTrue())
                        }
                        
                        it("should call the viewForSectionAt function exactly once for each section") {
                            expect(dataSource.viewForSectionCalledCount).to(equal(numberOfSections))
                        }
                    }
                }
                
                context("when reloading the data") {
                    let numberOfSections: Int = 10
                    var dataSource: MockMultiProgressViewDataSource!
                    
                    beforeEach {
                        dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                        subject.dataSource = dataSource
                        subject.reloadData()
                    }
                    
                    it("should reset the progress on each progress view section") {
                        for index in 0..<numberOfSections {
                            expect(subject.progress(forSection: index)).to(equal(0))
                        }
                    }
                    
                    it("should have the correct number of sections") {
                        expect(subject.progressViewSections.count).to(equal(numberOfSections))
                    }
                    
                    it("should the correct number of subviews on its track") {
                        let track = subject.track
                        expect(track.subviews.count - 2).to(equal(numberOfSections))
                    }
                }
            }
            
            describe("changing the progress") {
                let numberOfSections: Int = 3
                
                beforeEach {
                    subject.dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                }
                
                context("when setting a nonnegative progress on an individual section") {
                    
                    context("when setting a progress that does not exceed 1") {
                        let progress: Float = 0.1
                        
                        beforeEach {
                            subject.setProgress(section: 0, to: progress)
                        }
                        
                        it("should set the correct progress for the section") {
                            expect(subject.progress(forSection: 0)).to(equal(progress))
                        }
                    }
                    
                    context("when setting a progress that exceeds 1") {
                        let progress: Float = 1.1
                        
                        beforeEach {
                            subject.setProgress(section: 0, to: progress)
                        }
                        
                        it("should set the progress to 1") {
                            expect(subject.progress(forSection: 0)).to(equal(1))
                        }
                    }
                }
                
                context("when setting a negative progress on an individual section") {
                    let progress: Float = -0.1
                    
                    beforeEach {
                        subject.setProgress(section: 0, to: progress)
                    }
                    
                    it("should set it's progress to zero") {
                        expect(subject.progress(forSection: 0)).to(equal(0))
                    }
                }
                
                context("when setting a progress on an individual section with existing progress") {
                    let progress: Float = Float()
                    let initialProgress: Float = Float()
                    
                    beforeEach {
                        subject.setProgress(section: 0, to: initialProgress)
                        subject.setProgress(section: 0, to: progress)
                    }
                    
                    it("should replace its existing progress with the most recent progress") {
                        expect(subject.progress(forSection: 0)).to(be(progress))
                    }
                }
                
                context("when setting a progress which causes the sum of all sections' progress to exceed 1") {
                    let firstProgress: Float = 0.2
                    let secondProgress: Float = 0.3
                    let thirdProgress: Float = 1000
                    
                    beforeEach {
                        subject.setProgress(section: 0, to: firstProgress)
                        subject.setProgress(section: 1, to: secondProgress)
                        subject.setProgress(section: 2, to: thirdProgress)
                    }
                    
                    it("should only progress up to one") {
                        expect(subject.progress(forSection: 2)).to(equal(1 - (firstProgress + secondProgress)))
                    }
                }
                
                context("when resetting the progress view") {
                    
                    beforeEach {
                        subject.setProgress(section: 0, to: 0.1)
                        subject.setProgress(section: 1, to: 0.1)
                        subject.setProgress(section: 2, to: 0.1)
                        subject.resetProgress()
                    }
                    
                    it("should set each section's progress to zero") {
                        for index in 0..<numberOfSections {
                            expect(subject.progress(forSection: index)).to(equal(0))
                        }
                    }
                }
                
                context("when getting the total progress") {
                    let progress: Float = 0.2
                    
                    beforeEach {
                        subject.setProgress(section: 0, to: progress)
                        subject.setProgress(section: 1, to: progress)
                        subject.setProgress(section: 2, to: progress)
                    }
                    
                    it("should return the correct total progress") {
                        expect(subject.totalProgress).to(equal(3 * progress))
                    }
                }
            }
        }
    }
}
