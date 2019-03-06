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
        let progressViewWidth: CGFloat = 300
        let progressViewHeight: CGFloat = 50
        var mockLayoutCalculator: MockLayoutCalculator!
        var subject: MultiProgressView!
        
        describe("MultiProgressView") {
            
            beforeEach {
                mockLayoutCalculator = MockLayoutCalculator()
                subject = MultiProgressView(layoutCalculator: mockLayoutCalculator)
                self.layoutProgressView(subject,
                                        width: progressViewWidth,
                                        height: progressViewHeight)
            }
            
            describe("initialization") {
                
                context("when initializing a new progress view") {
                    
                    it("should have a track title label") {
                        expect(subject.trackTitleLabel).toNot(beNil())
                    }
                    
                    it("should have track insets equal to zero") {
                        expect(subject.trackInset).to(equal(0))
                    }
                    
                    it("should have a border color of black") {
                        expect(subject.borderColor).to(equal(.black))
                    }
                    
                    it("should have a border width of zero") {
                        expect(subject.borderWidth).to(equal(0))
                    }
                    
                    it("should have track title insets equal to zero") {
                        expect(subject.trackTitleEdgeInsets).to(equal(.zero))
                    }
                    
                    it("should have a center track title alignment") {
                        expect(subject.trackTitleAlignment).to(equal(.center))
                    }
                    
                    it("should have a track background color of white") {
                        expect(subject.trackBackgroundColor).to(equal(.white))
                    }
                    
                    it("should have a track border color of black") {
                        expect(subject.trackBorderColor).to(equal(.black))
                    }
                    
                    it("should have a track border width of zero") {
                        expect(subject.trackBorderWidth).to(equal(0))
                    }
                    
                    it("should have a track image view") {
                        expect(subject.trackImageView).toNot(beNil())
                    }
                    
                    it("should have a round line cap type") {
                        expect(subject.lineCap).to(equal(.square))
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(subject.cornerRadius).to(equal(0))
                    }
                    
                    it("should have no data source") {
                        expect(subject.dataSource).to(beNil())
                    }
                    
                    it("should clip its layer to its bounds") {
                        expect(subject.layer.masksToBounds).to(beTrue())
                    }
                    
                    it("should have its track's layer mask to its bounds") {
                        expect(subject.track.layer.masksToBounds).to(beTrue())
                    }
                }
            }
            
            describe("progress view title label") {
                
                context("when setting the progress view's title") {
                    let title: String = "title"
                    
                    beforeEach {
                        subject.setTitle(title)
                    }
                    
                    it("should show the expected title") {
                        expect(subject.trackTitleLabel.text).to(equal(title))
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
            
            describe("corner radius") {
                
                context("when the line cap type is round") {
                    let trackinset: CGFloat = 5
                    
                    context("when the corner radius is set to zero") {
                        
                        beforeEach {
                            subject.lineCap = .round
                            subject.trackInset = trackinset
                            subject.cornerRadius = 0
                            subject.layoutSubviews()
                        }
                        
                        it("should have corner radius equal to half its height") {
                            expect(subject.layer.cornerRadius).to(equal(subject.bounds.height / 2))
                        }
                        
                        it("should have its track's corner radius equal to half its height") {
                            expect(subject.track.layer.cornerRadius).to(equal(subject.track.bounds.height / 2))
                        }
                    }
                    
                    context("when the corner radius is nonzero") {
                        let cornerRadius: CGFloat = 10
                        
                        beforeEach {
                            subject.lineCap = .round
                            subject.cornerRadius = cornerRadius
                            subject.trackInset = trackinset
                            subject.layoutSubviews()
                        }
                        
                        it("should have corner radius equal to the set corner radius") {
                            expect(subject.layer.cornerRadius).to(equal(cornerRadius))
                        }
                        
                        it("should have the correct scaled track corner radius") {
                            let cornerRadiusFactor: CGFloat = cornerRadius / subject.bounds.height
                            expect(subject.track.layer.cornerRadius).to(equal(cornerRadiusFactor * subject.track.bounds.height))
                        }
                    }
                }
                
                context("when the line cap type is square") {
                    
                    context("when the corner radius is set to zero") {
                        
                        beforeEach {
                            subject.lineCap = .square
                            subject.cornerRadius = 0
                            subject.layoutIfNeeded()
                        }
                        
                        it("should have corner radius equal to zero") {
                            expect(subject.layer.cornerRadius).to(equal(0))
                        }
                        
                        it("should have its track's corner radius equal to zero") {
                            expect(subject.track.layer.cornerRadius).to(equal(0))
                        }
                    }
                    
                    context("when the corner radius is nonzero") {
                        let cornerRadius: CGFloat = 1
                        
                        beforeEach {
                            subject.lineCap = .square
                            subject.cornerRadius = cornerRadius
                            subject.layoutIfNeeded()
                        }
                        
                        it("should have corner radius equal to zero") {
                            expect(subject.layer.cornerRadius).to(equal(0))
                        }
                        
                        it("should have its track's corner radius equal to zero") {
                            expect(subject.track.layer.cornerRadius).to(equal(0))
                        }
                    }
                }
                
                context("when the line cap type is butt") {
                    
                    context("when the corner radius is set to zero") {
                        
                        beforeEach {
                            subject.lineCap = .butt
                            subject.cornerRadius = 0
                            subject.layoutIfNeeded()
                        }
                        
                        it("should have corner radius equal to zero") {
                            expect(subject.layer.cornerRadius).to(equal(0))
                        }
                        
                        it("should have its track's corner radius equal to zero") {
                            expect(subject.track.layer.cornerRadius).to(equal(0))
                        }
                    }
                    
                    context("when the corner radius is nonzero") {
                        let cornerRadius: CGFloat = 1
                        
                        beforeEach {
                            subject.lineCap = .butt
                            subject.cornerRadius = cornerRadius
                        }
                        
                        it("should have corner radius equal to zero") {
                            expect(subject.layer.cornerRadius).to(equal(0))
                        }
                        
                        it("should have its track's corner radius equal to zero") {
                            expect(subject.track.layer.cornerRadius).to(equal(0))
                        }
                    }
                }
            }
            
            describe("borders") {
                
                context("when setting the border color") {
                    let color: UIColor = .blue
                    
                    beforeEach {
                        subject.borderColor = color
                    }
                    
                    it("should correctly set the border color") {
                        expect(subject.borderColor).to(equal(color))
                    }
                }
                
                context("when setting the border width") {
                    let width: CGFloat = 5
                    
                    beforeEach {
                        subject.borderWidth = width
                    }
                    
                    it("should correctly set the border width") {
                        expect(subject.borderWidth).to(equal(width))
                    }
                }
                
                context("when setting the progress view's border color") {
                    let color: UIColor = .blue
                    
                    beforeEach {
                        subject.trackBorderColor = color
                    }
                    
                    it("should correctly set the progress view's border color") {
                        expect(subject.trackBorderColor).to(equal(color))
                    }
                }
                
                context("when setting the progress view's border width") {
                    let width: CGFloat = 5
                    
                    beforeEach {
                        subject.trackBorderWidth = width
                    }
                    
                    it("should correctly set the progress view's border width") {
                        expect(subject.trackBorderWidth).to(equal(width))
                    }
                }
            }
            
            describe("progress view section background color") {
                
                context("when setting the progress view section's background color") {
                    let color: UIColor = .blue
                    
                    beforeEach {
                        subject.trackBackgroundColor = color
                    }
                    
                    it("should correctly set the progress view's background color") {
                        expect(subject.trackBackgroundColor).to(equal(color))
                    }
                }
            }
            
            describe("track inset") {
                
                context("when the track inset is equal to zero") {
                    
                    beforeEach {
                        subject.trackInset = 0
                    }
                    
                    //it should call the layout calculator with the correct parameters
                    it("should have no insets on its track") {
                        expect(subject.track.frame).to(equal(subject.bounds))
                    }
                }
                
                context("when the track inset is nonzero") {
                    let inset: CGFloat = 1
                    
                    context("when the line cap type is round") {
                        
                        beforeEach {
                            subject.trackInset = inset
                            subject.lineCap = .round
                            subject.layoutIfNeeded()
                        }
                        
                        //it should call the layout calculator with the correct parameters
                        it("should have a track with the correct size and origin") {
                            expect(subject.track.bounds.height).to(equal(subject.bounds.height - 2 * inset))
                            expect(subject.track.bounds.width).to(equal(subject.bounds.width - 2 * inset))
                            expect(subject.track.frame.origin).to(equal(CGPoint(x: inset, y: inset)))
                        }
                    }
                    
                    context("when the line cap type is square") {
                        
                        beforeEach {
                            subject.trackInset = inset
                            subject.lineCap = .square
                            subject.layoutIfNeeded()
                        }
                        
                        //it should call the layout calculator with the correct parameters
                        it("should have a track with the correct size and origin") {
                            expect(subject.track.bounds.height).to(equal(subject.bounds.height - 2 * inset))
                            expect(subject.track.bounds.width).to(equal(subject.bounds.width - 2 * inset))
                            expect(subject.track.frame.origin).to(equal(CGPoint(x: inset, y: inset)))
                        }
                    }
                    
                    context("when the line cap type is butt") {
                        
                        beforeEach {
                            subject.trackInset = inset
                            subject.lineCap = .butt
                            subject.layoutIfNeeded()
                        }
                        
                        //it should call the layout calculator with the correct parameters
                        it("should have a track with the correct size and origin") {
                            expect(subject.track.bounds.height).to(equal(subject.bounds.height - 2 * inset))
                            expect(subject.track.bounds.width).to(equal(subject.bounds.width))
                            expect(subject.track.frame.origin).to(equal(CGPoint(x: 0, y: inset)))
                        }
                    }
                }
            }
            
            describe("track image view") {
                
                context("when setting the track's image") {
                    let image: UIImage = UIImage()
                    
                    beforeEach {
                        subject.setTrackImage(image)
                        subject.layoutIfNeeded()
                    }
                    
                    //it should call the layout calculator with the correct parameters
                    it("should have a track image view with the correct bounds") {
                        expect(subject.trackImageView.frame).to(equal(subject.track.bounds))
                    }
                    
                    it("should have an image on it's track image view") {
                        expect(subject.trackImageView.image).to(equal(image))
                    }
                }
            }
            
            describe("data source") {
                
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
                    let progress: Float = 0.1
                    let initialProgress: Float = 0.5
                    
                    beforeEach {
                        subject.setProgress(section: 0, to: initialProgress)
                        subject.setProgress(section: 0, to: progress)
                    }
                    
                    it("should replace its existing progress") {
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
            
            describe("progress view section layout") {
                
                context("when the progress view is initialized") {
                    let numberOfSections: Int = 3
                    
                    beforeEach {
                        subject.dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                    }
                    
                    it("should layout each section with zero width") {
                        for section in subject.progressViewSections {
                            expect(section.frame.width).to(equal(0))
                        }
                    }
                }
                
                context("after setting the progress") {
                    
                    context("on an individual progress view section") {
                        let numberOfSections: Int = 1
                        let progress: Float = 0.1
                        
                        beforeEach {
                            subject.dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                            subject.setProgress(section: 0, to: progress)
                        }
                        
                        it("should calculate the correct width and origin for the section") {
                            let track = subject.track
                            let section = subject.progressViewSections[0]
                            let expectedWidth = CGFloat(progress) * track.frame.width
                            
                            expect(section.frame.origin.x).to(beCloseTo(0))
                            expect(section.frame.origin.y).to(beCloseTo(0))
                            expect(section.frame.width).to(beCloseTo(expectedWidth))
                        }
                    }
                    
                    context("on a section with whose section before it has nonzero progress") {
                        let numberOfSections: Int = 2
                        let firstSectionProgress: Float = 0.2
                        let secondSectionProgress: Float = 0.1
                        
                        beforeEach {
                            subject.dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                            subject.setProgress(section: 0, to: firstSectionProgress)
                            subject.setProgress(section: 1, to: secondSectionProgress)
                        }
                        
                        it("should calculate the correct width and origin for the section") {
                            let track = subject.track
                            let firstSection = subject.progressViewSections[0]
                            let secondSection = subject.progressViewSections[1]
                            
                            let expectedOrigin = CGPoint(x: firstSection.frame.width, y: 0)
                            let expectedWidth = CGFloat(secondSectionProgress) * track.frame.width
                            
                            expect(secondSection.frame.origin.x).to(beCloseTo(expectedOrigin.x))
                            expect(secondSection.frame.origin.y).to(beCloseTo(expectedOrigin.y))
                            expect(secondSection.frame.width).to(beCloseTo(expectedWidth))
                        }
                    }
                }
            }
        }
    }
}

extension MultiProgressViewSpec {
    func layoutProgressView(_ progressView: MultiProgressView, width: CGFloat, height: CGFloat) {
        let parentView = UIView()
        parentView.addSubview(progressView)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.widthAnchor.constraint(equalToConstant: width).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        progressView.layoutIfNeeded()
    }
}
