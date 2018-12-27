//
//  MGSegmentedProgressBarSpec.swift
//  MGSegmentedProgressBar_Tests
//
//  Created by Mac Gallagher on 12/26/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Quick
import Nimble
import MGSegmentedProgressBar

let progressBarWidth: CGFloat = 300
let progressBarHeight: CGFloat = 50

class MGSegmentedProgressBarSpec: QuickSpec {
    override func spec() {
        var progressBar: MGSegmentedProgressBar!
        
        describe("initialization") {
            beforeEach {
                progressBar = self.setupProgressBar()
            }
            
            context("when initializing a new progress bar") {
                it("should have no bar title label") {
                    expect(progressBar.barTitleLabel).to(beNil())
                }
                
                it("should have bar insets equal to zero") {
                    expect(progressBar.barInset).to(equal(0))
                }
                
                it("should have bar title insets equal to zero") {
                    expect(progressBar.barTitleEdgeInsets).to(equal(.zero))
                }
                
                it("should have a center bar title alignment") {
                    expect(progressBar.barTitleAlignment).to(equal(.center))
                }
                
                it("should have a bar background color of white") {
                    expect(progressBar.barBackgroundColor).to(equal(.white))
                }
                
                it("should have a bar border color of black") {
                    expect(progressBar.barBorderColor).to(equal(.black))
                }
                
                it("should have a bar border width of zero") {
                    expect(progressBar.barBorderWidth).to(equal(0))
                }
                
                it("should have a round line cap type") {
                    expect(progressBar.lineCap).to(equal(.round))
                }
                
                it("should have corner radius equal to zero") {
                    expect(progressBar.cornerRadius).to(equal(0))
                }
                
                it("should have no data source") {
                    expect(progressBar.dataSource).to(beNil())
                }
                
                it("should have exactly one subview") {
                    expect(progressBar.subviews.count).to(equal(1))
                }
            }
        }

        describe("bar title label") {
            context("when setting the progress bar's title") {
                var title: String!
                
                beforeEach {
                    title = "title"
                    progressBar = self.setupProgressBar(configure: { bar in
                        bar.setTitle(title)
                    })
                }
                
                it("should show the expected title") {
                    expect(progressBar.barTitleLabel?.text).to(equal(title))
                }
            }
            
            context("when setting the the progress bar's attributed title") {
                var title: NSAttributedString!
                
                beforeEach {
                    title = NSAttributedString(string: "title")
                    progressBar = self.setupProgressBar(configure: { bar in
                        bar.setAttributedTitle(title)
                    })
                }
                
                it("should show the expected attributed title") {
                    expect(progressBar.barTitleLabel?.attributedText).to(equal(title))
                }
            }
        }
        
        describe("corner radius") {
            var subview: UIView!
            
            context("when the line cap type is round") {
                context("when the corner radius is set to zero") {
                    beforeEach {
                        progressBar = self.setupProgressBar(configure: { bar in
                            bar.lineCap = .round
                            bar.cornerRadius = 0
                        })
                        subview = progressBar.subviews.first
                    }

                    it("should have corner radius equal to half its height") {
                        expect(progressBar.layer.cornerRadius).to(equal(progressBar.bounds.height / 2))
                    }

                    it("should have its subview's corner radius equal to half its height") {
                        expect(subview.layer.cornerRadius).to(equal(subview.bounds.height / 2))
                    }
                }
                
                context("when the corner radius is nonzero") {
                    let cornerRadius: CGFloat = 1
                    
                    beforeEach {
                        progressBar = self.setupProgressBar(configure: { bar in
                            bar.lineCap = .round
                            bar.cornerRadius = cornerRadius
                        })
                        subview = progressBar.subviews.first
                    }
                    
                    it("should have corner radius equal to the set corner radius") {
                        expect(progressBar.layer.cornerRadius).to(equal(cornerRadius))
                    }
                    
                    it("should have its subview's corner radius equal to the set corner radius") {
                        expect(subview.layer.cornerRadius).to(equal(cornerRadius))
                    }
                }
            }
            
            context("when the line cap type is square") {
                context("when the corner radius is set to zero") {
                    beforeEach {
                        progressBar = self.setupProgressBar(configure: { bar in
                            bar.lineCap = .square
                            bar.cornerRadius = 0
                        })
                        subview = progressBar.subviews.first
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(progressBar.layer.cornerRadius).to(equal(0))
                    }
                    
                    it("should have its subview's corner radius equal to zero") {
                        expect(subview.layer.cornerRadius).to(equal(0))
                    }
                }
                
                context("when the corner radius is nonzero") {
                    let cornerRadius: CGFloat = 1
                    
                    beforeEach {
                        progressBar = self.setupProgressBar(configure: { bar in
                            bar.lineCap = .square
                            bar.cornerRadius = cornerRadius
                        })
                        subview = progressBar.subviews.first
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(progressBar.layer.cornerRadius).to(equal(0))
                    }
                    
                    it("should have its subview's corner radius equal to zero") {
                        expect(subview.layer.cornerRadius).to(equal(0))
                    }
                }
            }
            
            context("when the line cap type is butt") {
                context("when the corner radius is set to zero") {
                    beforeEach {
                        progressBar = self.setupProgressBar(configure: { bar in
                            bar.lineCap = .butt
                            bar.cornerRadius = 0
                        })
                        subview = progressBar.subviews.first
                    }
                    
                    it("should have corner radius equal to zero") {
                        expect(progressBar.layer.cornerRadius).to(equal(0))
                    }
                    
                    it("should have its subview's corner radius equal to zero") {
                        expect(subview.layer.cornerRadius).to(equal(0))
                    }
                }
                
                context("when the corner radius is nonzero") {
                    let cornerRadius: CGFloat = 1
                    
                    beforeEach {
                        progressBar = self.setupProgressBar(configure: { bar in
                            bar.lineCap = .butt
                            bar.cornerRadius = cornerRadius
                        })
                        subview = progressBar.subviews.first
                    }
                    
                    it("should have corner radius equal to the set corner radius") {
                        expect(progressBar.layer.cornerRadius).to(equal(cornerRadius))
                    }
                    
                    it("should have its subview's corner radius equal to zero") {
                        expect(subview.layer.cornerRadius).to(equal(0))
                    }
                }
            }
        }
        
        describe("border") {
            context("when setting the border color") {
                let color: UIColor = .blue
                
                beforeEach {
                    progressBar = self.setupProgressBar(configure: { bar in
                        bar.barBorderColor = color
                    })
                }
                
                it("should correctly set the progress bar's border color") {
                    expect(progressBar.barBorderColor).to(equal(color))
                }
            }
            
            context("when setting the border width") {
                let width: CGFloat = 5
                
                beforeEach {
                    progressBar = self.setupProgressBar(configure: { bar in
                        bar.barBorderWidth = width
                    })
                }
                
                it("should correctly set the progress bar's border width") {
                    expect(progressBar.barBorderWidth).to(equal(width))
                }
            }
        }
        
        describe("bar background color") {
            context("when setting the bar background color") {
                let color: UIColor = .blue
                
                beforeEach {
                    progressBar = self.setupProgressBar(configure: { bar in
                        bar.barBackgroundColor = color
                    })
                }
                
                it("should correctly set the progress bar's background color") {
                    expect(progressBar.barBackgroundColor).to(equal(color))
                }
            }
        }
        
        describe("bar inset") {
            var subview: UIView!
            
            context("when the bar inset is equal to zero") {
                beforeEach {
                    progressBar = self.setupProgressBar(configure: { bar in
                        bar.barInset = 0
                    })
                    subview = progressBar.subviews.first
                }
                
                it("should have no insets on its subview") {
                    expect(subview.frame).to(equal(progressBar.bounds))
                }
            }
            
            context("when the bar inset is nonzero") {
                let inset: CGFloat = 1
                
                context("when the line cap type is round") {
                    beforeEach {
                        progressBar = self.setupProgressBar(configure: { bar in
                            bar.barInset = inset
                            bar.lineCap = .round
                        })
                        subview = progressBar.subviews.first
                    }
                    
                    it("should have insets on all sides of its subview") {
                        expect(subview.bounds.height).to(equal(progressBar.bounds.height - 2 * inset))
                        expect(subview.bounds.width).to(equal(progressBar.bounds.width - 2 * inset))
                    }
                }
                
                context("when the line cap type is square") {
                    beforeEach {
                        progressBar = self.setupProgressBar(configure: { bar in
                            bar.barInset = inset
                            bar.lineCap = .square
                        })
                        subview = progressBar.subviews.first
                    }
                    
                    it("should have insets on all sides of its subview") {
                        expect(subview.bounds.height).to(equal(progressBar.bounds.height - 2 * inset))
                        expect(subview.bounds.width).to(equal(progressBar.bounds.width - 2 * inset))
                    }
                }
                
                context("when the line cap type is butt") {
                    beforeEach {
                        progressBar = self.setupProgressBar(configure: { bar in
                            bar.barInset = inset
                            bar.lineCap = .butt
                        })
                        subview = progressBar.subviews.first
                    }
                    
                    it("should have insets on only the top and the bottom of its subview") {
                        expect(subview.bounds.height).to(equal(progressBar.bounds.height - 2 * inset))
                        expect(subview.bounds.width).to(equal(progressBar.bounds.width))
                    }
                }
            }
        }
        
        describe("data source") {
            var dataSource: MockMGSegmentedProgressBarDataSource!
            
            context("when setting the data source") {
                beforeEach {
                    dataSource = MockMGSegmentedProgressBarDataSource()
                    progressBar = self.setupProgressBar(configure: { bar in
                        bar.dataSource = dataSource
                    })
                }
                
                it("should always retrieve the number of steps and number of sections") {
                    expect(dataSource.numberOfStepsCalled).to(beTrue())
                    expect(dataSource.numberOfSectionsCalled).to(beTrue())
                }
            }
            
            context("when the number of sections is zero") {
                beforeEach {
                    dataSource = MockMGSegmentedProgressBarDataSource(numberOfSections: 0)
                    progressBar = self.setupProgressBar(configure: { bar in
                        bar.dataSource = dataSource
                    })
                }
                
                it("should not call the barForSectionAt function") {
                    expect(dataSource.barForSectionCalledCount).to(equal(0))
                }
            }
            
            context("when the number of sections is nonzero") {
                let numberOfSections: Int = 10
                beforeEach {
                    dataSource = MockMGSegmentedProgressBarDataSource(numberOfSections: numberOfSections)
                    progressBar = self.setupProgressBar(configure: { bar in
                        bar.dataSource = dataSource
                    })
                }
                
                it("should call the barForSectionAt function exactly once for each section") {
                    expect(dataSource.barForSectionCalledCount).to(equal(numberOfSections))
                }
            }
            
            context("when reloading the data") {
                let numberOfSections: Int = 10
                var progressBarSubview: UIView!
                
                beforeEach {
                    dataSource = MockMGSegmentedProgressBarDataSource(numberOfSections: numberOfSections)
                    progressBar = self.setupProgressBar(configure: { bar in
                        bar.dataSource = dataSource
                    })
                    progressBarSubview = progressBar.subviews.first
                    progressBar.reloadData()
                }
                
                it("should reset the progress on each bar") {
                    for index in 0..<numberOfSections {
                        expect(progressBar.progress(forSection: index)).to(equal(0))
                    }
                }
                
                it("should have the correct number of subviews") {
                    expect(progressBarSubview.subviews.count).to(equal(numberOfSections))
                }
            }
        }
        
        describe("changing the progress") {
            let numberOfSections: Int = 3
            let numberOfSteps: Int = 10
            var progress: Int!
            
            beforeEach {
                let dataSource = MockMGSegmentedProgressBarDataSource(numberOfSteps: numberOfSteps, numberOfSections: numberOfSections)
                progressBar = self.setupProgressBar(configure: { bar in
                    bar.dataSource = dataSource
                })
            }
            
            context("when setting a nonnegative progress on an individual section") {
                context("when setting a progress that does not exceed the total number of steps in the progress bar") {
                    beforeEach {
                        progress = 1
                        progressBar.setProgress(forSection: 0, steps: progress)
                    }
                    
                    it("should set the correct progress for the section") {
                        expect(progressBar.progress(forSection: 0)).to(equal(progress))
                    }
                }
                
                context("when setting a progress that exceeds the total number of steps in the progress bar") {
                    beforeEach {
                        progress = numberOfSteps + 1
                        progressBar.setProgress(forSection: 0, steps: progress)
                    }
                    
                    it("should set the progress to the total number of steps in the progress bar") {
                        expect(progressBar.progress(forSection: 0)).to(equal(numberOfSteps))
                    }
                }
            }
            
            context("when setting a negative progress on an individual section") {
                beforeEach {
                    progress = -1
                    progressBar.setProgress(forSection: 0, steps: progress)
                }
                
                it("should set it's progress to zero") {
                    expect(progressBar.progress(forSection: 0)).to(equal(0))
                }
            }
            
            context("when setting a progress from an existing progress on an individual section") {
                var initialProgress: Int!
                beforeEach {
                    progress = 1
                    initialProgress = 5
                    progressBar.setProgress(forSection: 0, steps: initialProgress)
                    progressBar.setProgress(forSection: 0, steps: progress)
                }
                
                it("should replace its previous progress") {
                    expect(progressBar.progress(forSection: 0)).to(equal(progress))
                }
            }
            
            context("when setting a progress which causes the sum of all sections' progress to exceed the number of steps in the progress bar") {
                let sum = 2 + 3
                beforeEach {
                    progress = 1000
                    progressBar.setProgress(forSection: 0, steps: 2)
                    progressBar.setProgress(forSection: 1, steps: 3)
                    progressBar.setProgress(forSection: 2, steps: progress)
                }
                it("should only progress up to the maximum number of steps") {
                    expect(progressBar.progress(forSection: 2)).to(equal(numberOfSteps - sum))
                }
            }
            
            context("when advancing a section") {
                var existingProgress: Int!
                
                context("when advancing progress in a section with existing progress") {
                    
                    beforeEach {
                        progress = 1
                        existingProgress = 5
                        progressBar.setProgress(forSection: 0, steps: existingProgress)
                        progressBar.advance(section: 0, by: progress)
                    }
                    
                    it("should add to the existing progress") {
                        expect(progressBar.progress(forSection: 0)).to(equal(existingProgress + progress))
                    }
                }
                
                context("when subtracting progress in a section with existing progress ") {
                    beforeEach {
                        progress = -1
                        existingProgress = 5
                        progressBar.setProgress(forSection: 0, steps: existingProgress)
                        progressBar.advance(section: 0, by: progress)
                    }
                    
                    it("should subtract from the existing progress") {
                        expect(progressBar.progress(forSection: 0)).to(equal(existingProgress + progress))
                    }
                }
            }
            
            context("when resetting the progress bar") {
                beforeEach {
                    progressBar.setProgress(forSection: 0, steps: 1)
                    progressBar.setProgress(forSection: 1, steps: 1)
                    progressBar.setProgress(forSection: 2, steps: 1)
                    progressBar.resetProgress()
                }
                
                it("should set each section's progress to zero") {
                    for index in 0..<numberOfSections {
                        expect(progressBar.progress(forSection: index)).to(equal(0))
                    }
                }
            }
        }
        
        describe("bar section layout") {
        }
    }
}

extension MGSegmentedProgressBarSpec {
    func setupProgressBar(configure: (MGSegmentedProgressBar) -> Void = { _ in } ) -> MGSegmentedProgressBar {
        let parentView = UIView()
        let progressBar = MGSegmentedProgressBar()
        parentView.addSubview(progressBar)
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.widthAnchor.constraint(equalToConstant: progressBarWidth).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: progressBarHeight).isActive = true
        
        configure(progressBar)
        
        progressBar.layoutIfNeeded()
        return progressBar
    }
}

extension MGSegmentedProgressBarSpec {
    class MockMGSegmentedProgressBarDataSource: MGSegmentedProgressBarDataSource {
        var numberOfStepsCalled: Bool = false
        var numberOfSectionsCalled: Bool = false
        var barForSectionCalledCount: Int = 0
        
        private var numberOfSteps: Int
        private var numberOfSections: Int
        
        init(numberOfSteps: Int = 0, numberOfSections: Int = 0) {
            self.numberOfSteps = numberOfSteps
            self.numberOfSections = numberOfSections
        }
        
        func numberOfSteps(in progressBar: MGSegmentedProgressBar) -> Int {
            numberOfStepsCalled = true
            return numberOfSteps
        }
        
        func numberOfSections(in progressBar: MGSegmentedProgressBar) -> Int {
            numberOfSectionsCalled = true
            return numberOfSections
        }
        
        func progressBar(_ progressBar: MGSegmentedProgressBar, barForSection section: Int) -> ProgressBarSection {
            barForSectionCalledCount += 1
            return ProgressBarSection()
        }
    }
}
