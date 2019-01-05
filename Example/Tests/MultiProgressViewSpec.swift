//
//  MultiProgressViewSpec.swift
//  MultiProgressView_Tests
//
//  Created by Mac Gallagher on 12/26/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Quick
import Nimble
import MultiProgressView

class MultiProgressViewSpec: QuickSpec {
    private let progressViewWidth: CGFloat = 300
    private let progressViewHeight: CGFloat = 50

    override func spec() {
        var progressView: MultiProgressView!
        
        describe("initialization") {
            beforeEach {
                progressView = self.setupProgressView()
            }
            
            context("when initializing a new progress view") {
                it("should have no track title label") {
                    expect(progressView.trackTitleLabel).to(beNil())
                }
                
                it("should have track insets equal to zero") {
                    expect(progressView.trackInset).to(equal(0))
                }
                
                it("should have a border color of black") {
                    expect(progressView.borderColor).to(equal(.black))
                }
                
                it("should have a border width of zero") {
                    expect(progressView.borderWidth).to(equal(0))
                }
                
                it("should have track title insets equal to zero") {
                    expect(progressView.trackTitleEdgeInsets).to(equal(.zero))
                }
                
                it("should have a center track title alignment") {
                    expect(progressView.trackTitleAlignment).to(equal(.center))
                }
                
                it("should have a track background color of white") {
                    expect(progressView.trackBackgroundColor).to(equal(.white))
                }
                
                it("should have a track border color of black") {
                    expect(progressView.trackBorderColor).to(equal(.black))
                }
                
                it("should have a track border width of zero") {
                    expect(progressView.trackBorderWidth).to(equal(0))
                }
                
                it("should have no track image view") {
                    expect(progressView.trackImageView).to(beNil())
                }
                
                it("should have a round line cap type") {
                    expect(progressView.lineCap).to(equal(.square))
                }
                
                it("should have corner radius equal to zero") {
                    expect(progressView.cornerRadius).to(equal(0))
                }
                
                it("should have no data source") {
                    expect(progressView.dataSource).to(beNil())
                }
                
                it("should clip to bounds") {
                    expect(progressView.clipsToBounds).to(beTrue())
                }
                
                it("should have exactly one subview") {
                    expect(progressView.subviews.count).to(equal(1))
                }
               
                it("should clip its subview to its bounds") {
                    let subview = progressView.subviews.first
                    expect(subview?.clipsToBounds).to(beTrue())
                }
            }
        }

        describe("progress view title label") {
            context("when setting the progress view's title") {
                var title: String!
                
                beforeEach {
                    title = "title"
                    progressView = self.setupProgressView(configure: { view in
                        view.setTitle(title)
                    })
                }
                
                it("should show the expected title") {
                    expect(progressView.trackTitleLabel?.text).to(equal(title))
                }
            }
            
            context("when setting the the progress view's attributed title") {
                var title: NSAttributedString!
                
                beforeEach {
                    title = NSAttributedString(string: "title")
                    progressView = self.setupProgressView(configure: { view in
                        view.setAttributedTitle(title)
                    })
                }
                
                it("should show the expected attributed title") {
                    expect(progressView.trackTitleLabel?.attributedText).to(equal(title))
                }
            }
        }
        
        describe("corner radius") {
            context("when the line cap type is round") {
                context("when the corner radius is set to zero") {
                    let trackinset: CGFloat = 5
                    var track: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.lineCap = .round
                            view.cornerRadius = 0
                            view.trackInset = trackinset
                        })
                        track = progressView.subviews.first
                        progressView.layoutSubviews()
                    }

                    it("should have corner radius equal to half its height") {
                        expect(progressView.layer.cornerRadius).to(equal(progressView.bounds.height / 2))
                    }

                    it("should have its track's corner radius equal to half its height") {
                        expect(track.layer.cornerRadius).to(equal(track.bounds.height / 2))
                    }
                }
                
                context("when the corner radius is nonzero") {
                    let trackinset: CGFloat = 5
                    let cornerRadius: CGFloat = 10
                    var track: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.lineCap = .round
                            view.cornerRadius = cornerRadius
                            view.trackInset = trackinset
                        })
                        track = progressView.subviews.first
                        progressView.layoutSubviews()
                    }
                    
                    it("should have corner radius equal to the set corner radius") {
                        expect(progressView.layer.cornerRadius).to(equal(cornerRadius))
                    }
                    
                    it("should have the correct scaled track corner radius") {
                        let cornerRadiusFactor: CGFloat = cornerRadius / progressView.bounds.height
                        expect(track.layer.cornerRadius).to(be(cornerRadiusFactor * track.bounds.height))
                    }
                }
            }
            
            context("when the line cap type is square") {
                context("when the corner radius is set to zero") {
                    var track: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.lineCap = .square
                            view.cornerRadius = 0
                        })
                        track = progressView.subviews.first
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(progressView.layer.cornerRadius).to(equal(0))
                    }
                    
                    it("should have its track's corner radius equal to zero") {
                        expect(track.layer.cornerRadius).to(equal(0))
                    }
                }
                
                context("when the corner radius is nonzero") {
                    let cornerRadius: CGFloat = 1
                    var track: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.lineCap = .square
                            view.cornerRadius = cornerRadius
                        })
                        track = progressView.subviews.first
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(progressView.layer.cornerRadius).to(equal(0))
                    }
                    
                    it("should have its track's corner radius equal to zero") {
                        expect(track.layer.cornerRadius).to(equal(0))
                    }
                }
            }
            
            context("when the line cap type is butt") {
                context("when the corner radius is set to zero") {
                    var track: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.lineCap = .butt
                            view.cornerRadius = 0
                        })
                        track = progressView.subviews.first
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(progressView.layer.cornerRadius).to(equal(0))
                    }
                    
                    it("should have its track's corner radius equal to zero") {
                        expect(track.layer.cornerRadius).to(equal(0))
                    }
                }
                
                context("when the corner radius is nonzero") {
                    let cornerRadius: CGFloat = 1
                    var track: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.lineCap = .butt
                            view.cornerRadius = cornerRadius
                        })
                        track = progressView.subviews.first
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(progressView.layer.cornerRadius).to(equal(0))
                    }
                    
                    it("should have its track's corner radius equal to zero") {
                        expect(track.layer.cornerRadius).to(equal(0))
                    }
                }
            }
        }
        
        describe("borders") {
            context("when setting the border color") {
                let color: UIColor = .blue
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.borderColor = color
                    })
                }
                
                it("should correctly set the border color") {
                    expect(progressView.borderColor).to(equal(color))
                }
            }
            
            context("when setting the border width") {
                let width: CGFloat = 5
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.borderWidth = width
                    })
                }
                
                it("should correctly set the border width") {
                    expect(progressView.borderWidth).to(equal(width))
                }
            }
            
            context("when setting the progress view's border color") {
                let color: UIColor = .blue
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.trackBorderColor = color
                    })
                }
                
                it("should correctly set the progress view's border color") {
                    expect(progressView.trackBorderColor).to(equal(color))
                }
            }
            
            context("when setting the progress view's border width") {
                let width: CGFloat = 5
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.trackBorderWidth = width
                    })
                }
                
                it("should correctly set the progress view's border width") {
                    expect(progressView.trackBorderWidth).to(equal(width))
                }
            }
        }
        
        describe("progress view section background color") {
            context("when setting the progress view section's background color") {
                let color: UIColor = .blue
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.trackBackgroundColor = color
                    })
                }
                
                it("should correctly set the progress view's background color") {
                    expect(progressView.trackBackgroundColor).to(equal(color))
                }
            }
        }
        
        describe("track inset") {
            context("when the track inset is equal to zero") {
                var track: UIView!
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.trackInset = 0
                    })
                    track = progressView.subviews.first
                }
                
                it("should have no insets on its track") {
                    expect(track.frame).to(equal(progressView.bounds))
                }
            }
            
            context("when the track inset is nonzero") {
                let inset: CGFloat = 1
                var track: UIView!
                
                context("when the line cap type is round") {
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.trackInset = inset
                            view.lineCap = .round
                        })
                        track = progressView.subviews.first
                    }
                    
                    it("should have a track with the correct size and origin") {
                        expect(track.bounds.height).to(equal(progressView.bounds.height - 2 * inset))
                        expect(track.bounds.width).to(equal(progressView.bounds.width - 2 * inset))
                        expect(track.frame.origin).to(equal(CGPoint(x: inset, y: inset)))
                    }
                }
                
                context("when the line cap type is square") {
                    var track: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.trackInset = inset
                            view.lineCap = .square
                        })
                        track = progressView.subviews.first
                    }
                    
                    it("should have a track with the correct size and origin") {
                        expect(track.bounds.height).to(equal(progressView.bounds.height - 2 * inset))
                        expect(track.bounds.width).to(equal(progressView.bounds.width - 2 * inset))
                        expect(track.frame.origin).to(equal(CGPoint(x: inset, y: inset)))
                    }
                }
                
                context("when the line cap type is butt") {
                    var track: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.trackInset = inset
                            view.lineCap = .butt
                        })
                        track = progressView.subviews.first
                    }
                    
                    it("should have a track with the correct size and origin") {
                        expect(track.bounds.height).to(equal(progressView.bounds.height - 2 * inset))
                        expect(track.bounds.width).to(equal(progressView.bounds.width))
                        expect(track.frame.origin).to(equal(CGPoint(x: 0, y: inset)))
                    }
                }
            }
        }
        
        describe("track image view") {
            context("when setting the track's image") {
                let image = UIImage()
                var track: UIView!
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.setTrackImage(image)
                    })
                    track = progressView.subviews.first
                }
                
                it("should have a track image view with the correct bounds") {
                    expect(progressView.trackImageView?.frame).to(equal(track.bounds))
                }

                it("should have an image on it's track image view") {
                    expect(progressView.trackImageView?.image).to(equal(image))
                }
            }
        }
        
        describe("data source") {
            context("when setting the data source") {
                let dataSource = MockMultiProgressViewDataSource()
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.dataSource = dataSource
                    })
                }
                
                it("should always retrieve the number of sections") {
                    expect(dataSource.numberOfSectionsCalled).to(beTrue())
                }
            }
            
            context("when the number of sections is zero") {
                let dataSource = MockMultiProgressViewDataSource(numberOfSections: 0)
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.dataSource = dataSource
                    })
                }
                
                it("should not call the viewForSectionAt function") {
                    expect(dataSource.viewForSectionCalledCount).to(equal(0))
                }
            }
            
            context("when the number of sections is nonzero") {
                let numberOfSections: Int = 10
                let dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.dataSource = dataSource
                    })
                }
                
                it("should call the viewForSectionAt function exactly once for each section") {
                    expect(dataSource.viewForSectionCalledCount).to(equal(numberOfSections))
                }
            }
            
            context("when reloading the data") {
                let numberOfSections: Int = 10
                let dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                var track: UIView!
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.dataSource = dataSource
                    })
                    track = progressView.subviews.first
                    progressView.reloadData()
                }
                
                it("should reset the progress on each progress view section") {
                    for index in 0..<numberOfSections {
                        expect(progressView.progress(forSection: index)).to(equal(0))
                    }
                }
                
                it("should have a track with the correct number of sections") {
                    expect(track.subviews.count).to(equal(numberOfSections))
                }
            }
        }
        
        describe("changing the progress") {
            let numberOfSections: Int = 3
            
            beforeEach {
                let dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                progressView = self.setupProgressView(configure: { view in
                    view.dataSource = dataSource
                })
            }
            
            context("when setting a nonnegative progress on an individual section") {
                context("when setting a progress that does not exceed 1") {
                    let progress: Float = 0.1
                    
                    beforeEach {
                        progressView.setProgress(section: 0, to: progress)
                    }
                    
                    it("should set the correct progress for the section") {
                        expect(progressView.progress(forSection: 0)).to(equal(progress))
                    }
                }
                
                context("when setting a progress that exceeds 1") {
                    let progress: Float = 1.1
                    
                    beforeEach {
                        progressView.setProgress(section: 0, to: progress)
                    }
                    
                    it("should set the progress to 1") {
                        expect(progressView.progress(forSection: 0)).to(equal(1))
                    }
                }
            }
            
            context("when setting a negative progress on an individual section") {
                let progress: Float = -0.1
                
                beforeEach {
                    progressView.setProgress(section: 0, to: progress)
                }
                
                it("should set it's progress to zero") {
                    expect(progressView.progress(forSection: 0)).to(equal(0))
                }
            }
            
            context("when setting a progress on an individual section with existing progress") {
                let progress: Float = 0.1
                let initialProgress: Float = 0.5
                
                beforeEach {
                    progressView.setProgress(section: 0, to: initialProgress)
                    progressView.setProgress(section: 0, to: progress)
                }
                
                it("should replace its existing progress") {
                    expect(progressView.progress(forSection: 0)).to(equal(progress))
                }
            }
            
            context("when setting a progress which causes the sum of all sections' progress to exceed 1") {
                let firstProgress: Float = 0.2
                let secondProgress: Float = 0.3
                let thirdProgress: Float = 1000
                
                beforeEach {
                    progressView.setProgress(section: 0, to: firstProgress)
                    progressView.setProgress(section: 1, to: secondProgress)
                    progressView.setProgress(section: 2, to: thirdProgress)
                }
                it("should only progress up to one") {
                    expect(progressView.progress(forSection: 2)).to(equal(1 - (firstProgress + secondProgress)))
                }
            }
            
            context("when resetting the progress view") {
                beforeEach {
                    progressView.setProgress(section: 0, to: 0.1)
                    progressView.setProgress(section: 1, to: 0.1)
                    progressView.setProgress(section: 2, to: 0.1)
                    progressView.resetProgress()
                }
                
                it("should set each section's progress to zero") {
                    for index in 0..<numberOfSections {
                        expect(progressView.progress(forSection: index)).to(equal(0))
                    }
                }
            }
            
            context("when getting the total progress") {
                let progress: Float = 0.2
                
                beforeEach {
                    progressView.setProgress(section: 0, to: progress)
                    progressView.setProgress(section: 1, to: progress)
                    progressView.setProgress(section: 2, to: progress)
                }
                
                it("should return the correct total progress") {
                    expect(progressView.totalProgress).to(equal(3 * progress))
                }
            }
        }
        
        describe("progress view section layout") {
            context("when the progress view is initialized") {
                var track: UIView!
                let numberOfSections: Int = 3
                
                beforeEach {
                    let dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                    progressView = self.setupProgressView(configure: { view in
                        view.dataSource = dataSource
                    })
                    track = progressView.subviews.first
                }
                
                it("should layout each section with zero width") {
                    for section in track.subviews {
                        expect(section.frame.width).to(equal(0))
                    }
                }
            }
            
            context("after setting the progress") {
                context("on an individual progress view section") {
                    let numberOfSections: Int = 1
                    let progress: Float = 0.1
                    var track: UIView!
                    
                    beforeEach {
                        let dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                        progressView = self.setupProgressView(configure: { view in
                            view.dataSource = dataSource
                        })
                        progressView.setProgress(section: 0, to: progress)
                        track = progressView.subviews.first
                    }
                    
                    it("should calculate the correct width and origin for the section") {
                        let section = track.subviews.first
                        let expectedWidth = CGFloat(progress) * track.frame.width
                        let expectedOrigin = CGPoint.zero
                        
                        expect(section?.frame.origin.x).to(beCloseTo(expectedOrigin.x))
                        expect(section?.frame.origin.y).to(beCloseTo(expectedOrigin.y))
                        expect(section?.frame.width).to(beCloseTo(expectedWidth))
                    }
                }
                
                context("on a section with whose section before it has nonzero progress") {
                    let numberOfSections: Int = 2
                    let firstSectionProgress: Float = 0.2
                    let secondSectionProgress: Float = 0.1
                    var track: UIView!
                    
                    beforeEach {
                        let dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                        progressView = self.setupProgressView(configure: { view in
                            view.dataSource = dataSource
                        })
                        progressView.setProgress(section: 0, to: firstSectionProgress)
                        progressView.setProgress(section: 1, to: secondSectionProgress)
                        track = progressView.subviews.first
                    }
                    
                    it("should calculate the correct width and origin for the section") {
                        let firstSection = track.subviews.first!
                        let secondSection = track.subviews.last!
                        
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

extension MultiProgressViewSpec {
    func setupProgressView(configure: (MultiProgressView) -> Void = { _ in } ) -> MultiProgressView {
        let parentView = UIView()
        let progressView = MultiProgressView()
        parentView.addSubview(progressView)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.widthAnchor.constraint(equalToConstant: progressViewWidth).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: progressViewHeight).isActive = true
        
        configure(progressView)
        
        progressView.layoutIfNeeded()
        return progressView
    }
}

extension MultiProgressViewSpec {
    class MockMultiProgressViewDataSource: MultiProgressViewDataSource {
        var numberOfSectionsCalled: Bool = false
        var viewForSectionCalledCount: Int = 0
        
        private var numberOfSections: Int
        
        init(numberOfSections: Int = 0) {
            self.numberOfSections = numberOfSections
        }
        
        func numberOfSections(in progressView: MultiProgressView) -> Int {
            numberOfSectionsCalled = true
            return numberOfSections
        }
        
        func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
            viewForSectionCalledCount += 1
            return ProgressViewSection()
        }
    }
}
