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
                
                it("should have a round line cap type") {
                    expect(progressView.lineCap).to(equal(.round))
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
                    var subview: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.lineCap = .round
                            view.cornerRadius = 0
                        })
                        subview = progressView.subviews.first
                    }

                    it("should have corner radius equal to half its height") {
                        expect(progressView.layer.cornerRadius).to(equal(progressView.bounds.height / 2))
                    }

                    it("should have its subview's corner radius equal to half its height") {
                        expect(subview.layer.cornerRadius).to(equal(subview.bounds.height / 2))
                    }
                }
                
                context("when the corner radius is nonzero") {
                    let cornerRadius: CGFloat = 1
                    var subview: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.lineCap = .round
                            view.cornerRadius = cornerRadius
                        })
                        subview = progressView.subviews.first
                    }
                    
                    it("should have corner radius equal to the set corner radius") {
                        expect(progressView.layer.cornerRadius).to(equal(cornerRadius))
                    }
                    
                    it("should have its subview's corner radius equal to the set corner radius") {
                        expect(subview.layer.cornerRadius).to(equal(cornerRadius))
                    }
                }
            }
            
            context("when the line cap type is square") {
                context("when the corner radius is set to zero") {
                    var subview: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.lineCap = .square
                            view.cornerRadius = 0
                        })
                        subview = progressView.subviews.first
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(progressView.layer.cornerRadius).to(equal(0))
                    }
                    
                    it("should have its subview's corner radius equal to zero") {
                        expect(subview.layer.cornerRadius).to(equal(0))
                    }
                }
                
                context("when the corner radius is nonzero") {
                    let cornerRadius: CGFloat = 1
                    var subview: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.lineCap = .square
                            view.cornerRadius = cornerRadius
                        })
                        subview = progressView.subviews.first
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(progressView.layer.cornerRadius).to(equal(0))
                    }
                    
                    it("should have its subview's corner radius equal to zero") {
                        expect(subview.layer.cornerRadius).to(equal(0))
                    }
                }
            }
            
            context("when the line cap type is butt") {
                context("when the corner radius is set to zero") {
                    var subview: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.lineCap = .butt
                            view.cornerRadius = 0
                        })
                        subview = progressView.subviews.first
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(progressView.layer.cornerRadius).to(equal(0))
                    }
                    
                    it("should have its subview's corner radius equal to zero") {
                        expect(subview.layer.cornerRadius).to(equal(0))
                    }
                }
                
                context("when the corner radius is nonzero") {
                    let cornerRadius: CGFloat = 1
                    var subview: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.lineCap = .butt
                            view.cornerRadius = cornerRadius
                        })
                        subview = progressView.subviews.first
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(progressView.layer.cornerRadius).to(equal(0))
                    }
                    
                    it("should have its subview's corner radius equal to zero") {
                        expect(subview.layer.cornerRadius).to(equal(0))
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
                var subview: UIView!
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.trackInset = 0
                    })
                    subview = progressView.subviews.first
                }
                
                it("should have no insets on its subview") {
                    expect(subview.frame).to(equal(progressView.bounds))
                }
            }
            
            context("when the track inset is nonzero") {
                let inset: CGFloat = 1
                var subview: UIView!
                
                context("when the line cap type is round") {
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.trackInset = inset
                            view.lineCap = .round
                        })
                        subview = progressView.subviews.first
                    }
                    
                    it("should have insets on all sides of its subview") {
                        expect(subview.bounds.height).to(equal(progressView.bounds.height - 2 * inset))
                        expect(subview.bounds.width).to(equal(progressView.bounds.width - 2 * inset))
                    }
                }
                
                context("when the line cap type is square") {
                    var subview: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.trackInset = inset
                            view.lineCap = .square
                        })
                        subview = progressView.subviews.first
                    }
                    
                    it("should have insets on all sides of its subview") {
                        expect(subview.bounds.height).to(equal(progressView.bounds.height - 2 * inset))
                        expect(subview.bounds.width).to(equal(progressView.bounds.width - 2 * inset))
                    }
                }
                
                context("when the line cap type is butt") {
                    var subview: UIView!
                    
                    beforeEach {
                        progressView = self.setupProgressView(configure: { view in
                            view.trackInset = inset
                            view.lineCap = .butt
                        })
                        subview = progressView.subviews.first
                    }
                    
                    it("should have insets on only the top and the bottom of its subview") {
                        expect(subview.bounds.height).to(equal(progressView.bounds.height - 2 * inset))
                        expect(subview.bounds.width).to(equal(progressView.bounds.width))
                    }
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
                
                it("should always retrieve the number of steps and number of sections") {
                    expect(dataSource.numberOfUnitsCalled).to(beTrue())
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
                var progressViewSubview: UIView!
                
                beforeEach {
                    progressView = self.setupProgressView(configure: { view in
                        view.dataSource = dataSource
                    })
                    progressViewSubview = progressView.subviews.first
                    progressView.reloadData()
                }
                
                it("should reset the progress on each progress view section") {
                    for index in 0..<numberOfSections {
                        expect(progressView.progress(forSection: index)).to(equal(0))
                    }
                }
                
                it("should have the correct number of subviews") {
                    expect(progressViewSubview.subviews.count).to(equal(numberOfSections))
                }
            }
        }
        
        describe("changing the progress") {
            let numberOfSections: Int = 3
            let numberOfUnits: Int = 10
            
            beforeEach {
                let dataSource = MockMultiProgressViewDataSource(numberOfUnits: numberOfUnits, numberOfSections: numberOfSections)
                progressView = self.setupProgressView(configure: { view in
                    view.dataSource = dataSource
                })
            }
            
            context("when setting a nonnegative progress on an individual section") {
                context("when setting a progress that does not exceed the total number of steps in the progress view") {
                    let progress: Int = 1
                    
                    beforeEach {
                        progressView.setProgress(section: 0, to: progress)
                    }
                    
                    it("should set the correct progress for the section") {
                        expect(progressView.progress(forSection: 0)).to(equal(progress))
                    }
                }
                
                context("when setting a progress that exceeds the total number of steps in the progress view") {
                    let progress: Int = numberOfUnits + 1
                    
                    beforeEach {
                        progressView.setProgress(section: 0, to: progress)
                    }
                    
                    it("should set the progress to the total number of steps in the progress view") {
                        expect(progressView.progress(forSection: 0)).to(equal(numberOfUnits))
                    }
                }
            }
            
            context("when setting a negative progress on an individual section") {
                let progress: Int = -1
                
                beforeEach {
                    progressView.setProgress(section: 0, to: progress)
                }
                
                it("should set it's progress to zero") {
                    expect(progressView.progress(forSection: 0)).to(equal(0))
                }
            }
            
            context("when setting a progress from an existing progress on an individual section") {
                let progress: Int = 1
                let initialProgress: Int = 5
                
                beforeEach {
                    progressView.setProgress(section: 0, to: initialProgress)
                    progressView.setProgress(section: 0, to: progress)
                }
                
                it("should replace its previous progress") {
                    expect(progressView.progress(forSection: 0)).to(equal(progress))
                }
            }
            
            context("when setting a progress which causes the sum of all sections' progress to exceed the number of steps in the progress view") {
                let progress: Int = 1000
                let sum: Int = 2 + 3
                
                beforeEach {
                    progressView.setProgress(section: 0, to: 2)
                    progressView.setProgress(section: 1, to: 3)
                    progressView.setProgress(section: 2, to: progress)
                }
                it("should only progress up to the maximum number of steps") {
                    expect(progressView.progress(forSection: 2)).to(equal(numberOfUnits - sum))
                }
            }
            
            context("when advancing a section") {
                let existingProgress: Int = 5
                
                context("when advancing progress in a section with existing progress") {
                    let progress: Int = 1
                    
                    beforeEach {
                        progressView.setProgress(section: 0, to: existingProgress)
                        progressView.advance(by: progress, section: 0)
                    }
                    
                    it("should add to the existing progress") {
                        expect(progressView.progress(forSection: 0)).to(equal(existingProgress + progress))
                    }
                }
                
                context("when subtracting progress in a section with existing progress ") {
                    let progress: Int = -1
                    
                    beforeEach {
                        progressView.setProgress(section: 0, to: existingProgress)
                        progressView.advance(by: progress, section: 0)
                    }
                    
                    it("should subtract from the existing progress") {
                        expect(progressView.progress(forSection: 0)).to(equal(existingProgress + progress))
                    }
                }
            }
            
            context("when resetting the progress view") {
                beforeEach {
                    progressView.setProgress(section: 0, to: 1)
                    progressView.setProgress(section: 1, to: 1)
                    progressView.setProgress(section: 2, to: 1)
                    progressView.resetProgress()
                }
                
                it("should set each section's progress to zero") {
                    for index in 0..<numberOfSections {
                        expect(progressView.progress(forSection: index)).to(equal(0))
                    }
                }
            }
            
            context("when getting the total progress") {
                let progress: Int = 2
                
                beforeEach {
                    progressView.setProgress(section: 0, to: progress)
                    progressView.setProgress(section: 1, to: progress)
                    progressView.setProgress(section: 2, to: progress)
                }
                
                it("should return the correct total progress") {
                    expect(progressView.totalProgress()).to(equal(3 * progress))
                }
            }
        }
        
        describe("progress view section layout") {
            context("when the progress view is initialized") {
                var progressViewSubview: UIView!
                let numberOfSections: Int = 3
                
                beforeEach {
                    let dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
                    progressView = self.setupProgressView(configure: { view in
                        view.dataSource = dataSource
                    })
                    progressViewSubview = progressView.subviews.first
                }
                
                it("should layout each section with zero width") {
                    for section in progressViewSubview.subviews {
                        expect(section.frame.width).to(equal(0))
                    }
                }
            }
            
            context("after setting the progress") {
                context("on an individual progress view section") {
                    let numberOfSections: Int = 1
                    let numberOfUnits: Int = 10
                    let progress: Int = 1
                    var progressViewSubview: UIView!
                    
                    beforeEach {
                        let dataSource = MockMultiProgressViewDataSource(numberOfUnits: numberOfUnits, numberOfSections: numberOfSections)
                        progressView = self.setupProgressView(configure: { view in
                            view.dataSource = dataSource
                        })
                        progressView.setProgress(section: 0, to: progress)
                        progressViewSubview = progressView.subviews.first
                    }
                    
                    it("should calculate the correct width for the section") {
                        let section = progressViewSubview.subviews.first
                        let expectedWidth = (CGFloat(progress) / CGFloat(numberOfUnits)) * progressViewSubview.frame.width
                        expect(section?.frame.width).to(equal(expectedWidth))
                    }
                }
                
                context("on a section with whose section before it has nonzero progress") {
                    let numberOfSections: Int = 2
                    let numberOfUnits: Int = 10
                    let firstSectionProgress: Int = 2
                    let secondSectionProgress: Int = 1
                    var progressViewSubview: UIView!
                    
                    beforeEach {
                        let dataSource = MockMultiProgressViewDataSource(numberOfUnits: numberOfUnits, numberOfSections: numberOfSections)
                        progressView = self.setupProgressView(configure: { view in
                            view.dataSource = dataSource
                        })
                        progressView.setProgress(section: 0, to: firstSectionProgress)
                        progressView.setProgress(section: 1, to: secondSectionProgress)
                        progressViewSubview = progressView.subviews.first
                    }
                    
                    it("should calculate the correct width and origin for the section") {
                        let firstSection = progressViewSubview.subviews.first!
                        let secondSection = progressViewSubview.subviews.last
                        
                        let expectedOrigin = CGPoint(x: firstSection.frame.width, y: 0)
                        let expectedWidth = (CGFloat(secondSectionProgress) / CGFloat(numberOfUnits)) * progressViewSubview.frame.width
                        
                        expect(secondSection?.frame.origin).to(equal(expectedOrigin))
                        expect(secondSection?.frame.width).to(equal(expectedWidth))
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
        var numberOfUnitsCalled: Bool = false
        var numberOfSectionsCalled: Bool = false
        var viewForSectionCalledCount: Int = 0
        
        private var numberOfUnits: Int
        private var numberOfSections: Int
        
        init(numberOfUnits: Int = 0, numberOfSections: Int = 0) {
            self.numberOfUnits = numberOfUnits
            self.numberOfSections = numberOfSections
        }
        
        func numberOfUnits(in progressView: MultiProgressView) -> Int {
            numberOfUnitsCalled = true
            return numberOfUnits
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
