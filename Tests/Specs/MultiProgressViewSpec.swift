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
        
        describe("MultiProgressView") {
            
            beforeEach {
                mockLayoutCalculator = MockLayoutCalculator()
                subject = TestableMultiProgressView(layoutCalculator: mockLayoutCalculator)
            }
            
            //MARK: - Initialization
            
            describe("initialization") {
                var progressView: MultiProgressView!
                
                context("when initializing a new progress view with the default initializer") {
                    
                    beforeEach {
                        progressView = MultiProgressView()
                    }
                    
                    testInitialProperties()
                }
                
                context("when initializing a new progress view with the required initializer") {
                    
                    beforeEach {
                        //TODO: - Find a non-deprecated way to accomplish this
                        let coder = NSKeyedUnarchiver(forReadingWith: Data())
                        progressView = MultiProgressView(coder: coder)
                    }
                    
                    testInitialProperties()
                }
                
                func testInitialProperties() {
                    testInitialProgressViewProperties()
                    testInitialTrackProperties()
                }
                
                func testInitialProgressViewProperties() {
                    
                    it("should not have a data source") {
                        expect(progressView.dataSource).to(beNil())
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(progressView.cornerRadius).to(equal(0))
                    }
                    
                    it("should have a border width of zero") {
                        expect(progressView.borderWidth).to(equal(0))
                    }
                    
                    it("should have a border color of black") {
                        expect(progressView.borderColor).to(equal(.black))
                    }
                    
                    it("should have a square line cap type") {
                        expect(progressView.lineCap).to(equal(.square))
                    }
                    
                    it("should have total progress equal to zero") {
                        expect(progressView.totalProgress).to(equal(0))
                    }
                    
                    it("should mask its layer to its bounds") {
                        expect(progressView.layer.masksToBounds).to(beTrue())
                    }
                    
                    it("should have its track as a subview") {
                        expect(progressView.subviews.contains(progressView.track)).to(beTrue())
                    }
                }
                
                func testInitialTrackProperties() {
                    
                    it("should have track insets equal to zero") {
                        expect(progressView.trackInset).to(equal(0))
                    }
                    
                    it("should have a track background color of clear") {
                        expect(progressView.trackBackgroundColor).to(equal(.clear))
                    }
                    
                    it("should have a track border color of black") {
                        expect(progressView.trackBorderColor).to(equal(.black))
                    }
                    
                    it("should have a track border width of zero") {
                        expect(progressView.trackBorderWidth).to(equal(0))
                    }
                    
                    it("should have a track title label") {
                        expect(progressView.trackTitleLabel).toNot(beNil())
                    }
                    
                    it("should have track title insets equal to zero") {
                        expect(progressView.trackTitleEdgeInsets).to(equal(.zero))
                    }
                    
                    it("should have a center track title alignment") {
                        expect(progressView.trackTitleAlignment).to(equal(.center))
                    }
                    
                    it("should have a track image view") {
                        expect(progressView.trackImageView).toNot(beNil())
                    }
                    
                    it("should have the track's layer mask to its bounds") {
                        expect(progressView.track.layer.masksToBounds).to(beTrue())
                    }
                    
                    it("should have the trackTitleLabel as a subview of its track") {
                        expect(progressView.track.subviews.contains(progressView.trackTitleLabel)).to(beTrue())
                    }
                    
                    it("should have the trackImageView as a subview of its track") {
                        expect(progressView.track.subviews.contains(progressView.trackImageView)).to(beTrue())
                    }
                }
            }
            
            //MARK: - Data Source
            
            describe("data source") {
                
                context("when setting the data source") {
                    
                    beforeEach {
                        subject.dataSource = MockMultiProgressViewDataSource()
                    }
                    
                    it("should reload it's data") {
                        expect(subject.reloadDataCalled).to(beTrue())
                    }
                }
            }
            
            //MARK: - Track Inset
            
            describe("track inset") {
                
                context("when setting the track insets") {
                    
                    beforeEach {
                        subject.trackInset = 0
                    }
                    
                    it("should trigger a layout update") {
                        expect(subject.setNeedsLayoutCalled).to(beTrue())
                    }
                }
            }
            
            //MARK: - Track Background Color
            
            describe("track background color") {
                
                context("when setting the track background color") {
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
            
            describe("track title insets") {
                
                context("when setting the track title insets") {
                    
                    beforeEach {
                        subject.trackTitleEdgeInsets = UIEdgeInsets()
                    }
                    
                    it("should trigger a layout update") {
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
                    
                    it("should trigger a layout update") {
                        expect(subject.setNeedsLayoutCalled).to(beTrue())
                    }
                }
            }
            
            //MARK: - Line Cap Type
            
            describe("line cap type") {
                
                context("when setting the line cap type") {
                    
                    beforeEach {
                        subject.lineCap = .round
                    }
                    
                    it("should trigger a layout update") {
                        expect(subject.setNeedsLayoutCalled).to(beTrue())
                    }
                }
            }
            
            //MARK: - Borders
            
            describe("borders") {
                
                context("when setting the border width") {
                    let width: CGFloat = CGFloat()
                    
                    beforeEach {
                        subject.borderWidth = width
                    }
                    
                    it("should correctly set the border width") {
                        expect(subject.layer.borderWidth).to(be(width))
                    }
                }
                
                context("when setting the border color") {
                    let color: UIColor = .blue
                    
                    beforeEach {
                        subject.borderColor = color
                    }
                    
                    it("should correctly set the border color") {
                        expect(subject.layer.borderColor).to(equal(color.cgColor))
                    }
                }
                
                context("when setting the track border color") {
                    let color: UIColor = .blue
                    
                    beforeEach {
                        subject.trackBorderColor = color
                    }
                    
                    it("should correctly set the progress view's border color") {
                        expect(subject.track.layer.borderColor).to(equal(color.cgColor))
                    }
                }
                
                context("when setting the track border width") {
                    let width: CGFloat = CGFloat()
                    
                    beforeEach {
                        subject.trackBorderWidth = width
                    }
                    
                    it("should correctly set the progress view's border width") {
                        expect(subject.track.layer.borderWidth).to(be(width))
                    }
                }
            }
            
            //MARK: - Corner Radius
            
            describe("corner radius") {
                
                context("when setting the corner radius") {
                    
                    beforeEach {
                        subject.cornerRadius = 0
                    }
                    
                    it("should call the updateCornerRadius method") {
                        expect(subject.updateCornerRadiusCalled).to(beTrue())
                    }
                }
                
                context("when calling the updateCornerRadius method") {
                    let cornerRadius: CGFloat = 10
                    let trackCornerRadius: CGFloat = 20
                    
                    beforeEach {
                        mockLayoutCalculator.testCornerRadius = cornerRadius
                        mockLayoutCalculator.testTrackCornerRadius = trackCornerRadius
                        subject.updateCornerRadius()
                    }
                    
                    it("should correctly set the corner radius") {
                        expect(subject.layer.cornerRadius).to(equal(cornerRadius))
                    }
                    
                    it("should correctly set the track's corner radius") {
                        expect(subject.track.layer.cornerRadius).to(equal(trackCornerRadius))
                    }
                }
            }
            
            //MARK: - Total Progress
            
            describe("total progress") {
                
                context("when accessing the totalProgress variable") {
                    let numberOfSections: Int = 2
                    let progress0: Float = 0.2
                    let progress1: Float = 0.3
                    var dataSource: MockMultiProgressViewDataSource!
                    
                    beforeEach {
                        dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                        subject.dataSource = dataSource
                        subject.setProgress(section: 0, to: progress0)
                        subject.setProgress(section: 1, to: progress1)
                    }
                    
                    it("should return the correct total progress") {
                        expect(subject.totalProgress).to(equal(progress0 + progress1))
                    }
                }
            }
            
            //MARK: - Layout
            
            describe("layout") {
                let numberOfSections: Int = 3
                var dataSource: MockMultiProgressViewDataSource!
                
                beforeEach {
                    dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                    subject.dataSource = dataSource
                }
                
                context("when the layoutSubviews method is called") {
                    let trackFrame: CGRect = CGRect(x: 1, y: 2, width: 3, height: 4)
                    let trackTitleLabelConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
                    let trackTitleLabelAlignment: AlignmentType = .topLeft
                    let trackTitleLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 1, bottom: 2, right: 3)
                    let trackImageViewFrame: CGRect = CGRect(x: 5, y: 6, width: 7, height: 8)
                    let sectionFrame: CGRect = CGRect(x: 9, y: 10, width: 11, height: 12)
                    
                    beforeEach {
                        mockLayoutCalculator.testTrackFrame = trackFrame
                        mockLayoutCalculator.testAnchorConstraints = trackTitleLabelConstraints
                        mockLayoutCalculator.testSectionFrame = sectionFrame
                        mockLayoutCalculator.testTrackImageViewFrame = trackImageViewFrame
                        
                        subject.trackTitleAlignment = trackTitleLabelAlignment
                        subject.trackTitleEdgeInsets = trackTitleLabelInsets
                        subject.layoutSubviews()
                    }
                    
                    it("should correctly set the track's frame") {
                        expect(subject.track.frame).to(equal(trackFrame))
                    }
                    
                    it("should correctly layout the trackTitleLabel") {
                        expect(subject.trackTitleLabelConstraints).to(be(trackTitleLabelConstraints))
                        expect(mockLayoutCalculator.anchorToSuperviewAlignment).to(equal(trackTitleLabelAlignment))
                        expect(mockLayoutCalculator.anchorToSuperviewInsets).to(equal(trackTitleLabelInsets))
                    }
                    
                    it("should correctly set the imageView's frame") {
                        expect(subject.trackImageView.frame).to(equal(trackImageViewFrame))
                    }
                    
                    it("should send the trackImageView to the back of the track's view hierarchy") {
                        expect(subject.track.subviews[0]).to(equal(subject.trackImageView))
                    }
                    
                    it("should layout each section and add each as a subview of the track") {
                        for section in dataSource.progressViewSections {
                            let expectedFrame: CGRect
                            expect(section.frame).to(equal(sectionFrame))
                            expect(section.superview).to(equal(subject.track))
                        }
                    }
                    
                    it("should call the updateCornerRadius method") {
                        expect(subject.updateCornerRadiusCalled).to(beTrue())
                    }
                }
            }
            
            //MARK: - Getter/Setter Methods
            
            describe("getter/setter methods") {
                
                context("when calling the setTitle method") {
                    let title: String = String()
                    
                    beforeEach {
                        subject.setTitle(title)
                    }
                    
                    it("should set the text on the trackTitleLabel") {
                        expect(subject.trackTitleLabel.text).to(be(title))
                    }
                }
                
                context("when calling the setTrackImage method") {
                    let image: UIImage = UIImage()
                    
                    beforeEach {
                        subject.setTrackImage(image)
                    }
                    
                    it("should set the image on the trackImageView") {
                        expect(subject.trackImageView.image).to(equal(image))
                    }
                }
                
                context("when calling the setAttributedTitle method") {
                    let title: NSAttributedString = NSAttributedString(string: "title")
                    
                    beforeEach {
                        subject.setAttributedTitle(title)
                    }
                    
                    it("should set the attributed text on the trackTitleLabel") {
                        expect(subject.trackTitleLabel.attributedText).to(equal(title))
                    }
                }
                
                context("when calling the progress(forSection:) method") {
                    let progress: Float = 0.5
                    var dataSource: MockMultiProgressViewDataSource!
                    
                    beforeEach {
                        dataSource = MockMultiProgressViewDataSource(numberOfSections: 1)
                        subject.dataSource = dataSource
                        subject.setProgress(section: 0, to: progress)
                    }
                    
                    it("should return the correct progress") {
                        let actualProgress: Float = subject.progress(forSection: 0)
                        expect(actualProgress).to(equal(progress))
                    }
                }
            }
            
            //MARK: - Data Loading
            
            describe("data loading") {
                let numberOfSections: Int = 3
                var dataSource: MockMultiProgressViewDataSource!
                
                context("when calling the reloadData method when there is no data source") {
                    
                    beforeEach {
                        subject.dataSource = nil
                    }
                    
                    it("should not load any data") {
                        expect(subject.reloadDataCalled).to(beTrue())
                        expect(subject.progressViewSections.count).to(equal(0))
                    }
                }
                
                context("when calling the reloadData method when there is no existing data") {
                    
                    beforeEach {
                        dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                        subject.dataSource = dataSource
                    }
                    
                    testReloadData()
                }
                
                context("when calling the reloadData when there is existing data") {
                    
                    beforeEach {
                        dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                        subject.dataSource = dataSource
                        subject.reloadData()
                    }
                    
                    testReloadData()
                }
                
                func testReloadData() {
                    
                    it("should add the correct number of progress view sections") {
                        expect(subject.reloadDataCalled).to(beTrue())
                        expect(subject.progressViewSections.count).to(equal(numberOfSections))
                    }
                    
                    it("should add the sections in the correct order and remove any previous data") {
                        for index in 0..<numberOfSections {
                            let section: ProgressViewSection = dataSource.progressViewSections[index]
                            expect(subject.progressViewSections[index]).to(be(section))
                        }
                    }
                    
                    it("should add each section as a subview to the track and remove any previous sections") {
                        let trackSubviews: [UIView] = subject.track.subviews.filter { $0 is ProgressViewSection }
                        expect(trackSubviews.count).to(equal(numberOfSections))
                    }
                }
            }
            
            //MARK: - Setting Progress
            
            describe("setting progress") {
                let numberOfSections: Int = 3
                var dataSource: MockMultiProgressViewDataSource!
                
                beforeEach {
                    dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                    subject.dataSource = dataSource
                }
                
                context("when setting a progress") {
                    
                    beforeEach {
                        subject.setProgress(section: 0, to: 0)
                    }
                    
                    it("should always call setNeedsLayout") {
                        expect(subject.setNeedsLayoutCalled).to(beTrue())
                    }
                    
                    it("should always call layoutIfNeeded") {
                        expect(subject.layoutIfNeededCalled).to(beTrue())
                    }
                }
                
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
                
                context("when setting a negative progress on a section") {
                    let progress: Float = -0.1
                    
                    beforeEach {
                        subject.setProgress(section: 0, to: progress)
                    }
                    
                    it("should set it's progress to zero") {
                        expect(subject.progress(forSection: 0)).to(equal(0))
                    }
                }
                
                context("when setting a progress on a section with existing progress") {
                    let progress: Float = 0.1
                    let initialProgress: Float = 0.2
                    
                    beforeEach {
                        subject.setProgress(section: 0, to: initialProgress)
                        subject.setProgress(section: 0, to: progress)
                    }
                    
                    it("should replace its existing progress with the most recent progress") {
                        expect(subject.progress(forSection: 0)).to(equal(progress))
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
                    
                    it("should only progress the section up the remaining progress") {
                        expect(subject.progress(forSection: 2)).to(equal(1 - (firstProgress + secondProgress)))
                    }
                }
            }
            
            //MARK: - Resetting Progress
            
            describe("resetting progress") {
                
                context("when calling the resetProgress method") {
                    let numberOfSections: Int = 3
                    var dataSource: MockMultiProgressViewDataSource!
                    
                    beforeEach {
                        dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                        subject.dataSource = dataSource
                        
                        subject.setProgress(section: 0, to: 0.2)
                        subject.setProgress(section: 1, to: 0.3)
                        subject.setProgress(section: 2, to: 0.4)
                        subject.resetProgress()
                    }
                    
                    it("should set each section's progress to zero") {
                        for index in 0..<numberOfSections {
                            expect(subject.progress(forSection: index)).to(equal(0))
                        }
                    }
                }
            }
        }
    }
}
