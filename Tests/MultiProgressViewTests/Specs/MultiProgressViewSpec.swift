///
/// MIT License
///
/// Copyright (c) 2020 Mac Gallagher
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.
///

import Quick
import Nimble

@testable import MultiProgressView

class MultiProgressViewSpec: QuickSpec {
  override func spec() {
    describe("MultiProgressView") {
      let mockLayoutProvider = MockLayoutProvider.self
      var subject: TestableMultiProgressView!

      beforeEach {
        subject = TestableMultiProgressView(layoutProvider: mockLayoutProvider)
      }

      // MARK: - Initialization

      describe("Initialization") {
        var progressView: MultiProgressView!

        context("When initializing a new progress view with the default initializer") {
          beforeEach {
            progressView = MultiProgressView()
          }

          it("should have the correct default properties") {
            testDefaultProperties()
          }
        }

        context("When initializing a new progress view with the required initializer") {
          beforeEach {
            // TODO: - Find a non-deprecated way to accomplish this
            let coder = NSKeyedUnarchiver(forReadingWith: Data())
            progressView = MultiProgressView(coder: coder)
          }

          it("should have the correct default properties") {
            testDefaultProperties()
          }
        }

        func testDefaultProperties() {
          testDefaultProgressViewProperties()
          testDefaultTrackProperties()
        }

        func testDefaultProgressViewProperties() {
          expect(progressView.dataSource).to(beNil())
          expect(progressView.cornerRadius).to(equal(0))
          expect(progressView.borderWidth).to(equal(0))
          expect(progressView.borderColor).to(equal(.black))
          expect(progressView.lineCap).to(equal(.square))
          expect(progressView.totalProgress).to(equal(0))
          expect(progressView.layer.masksToBounds).to(beTrue())
          expect(progressView.subviews.contains(progressView.track)).to(beTrue())
        }

        func testDefaultTrackProperties() {
          expect(progressView.trackInset).to(equal(0))
          expect(progressView.trackBackgroundColor).to(equal(.clear))
          expect(progressView.trackBorderColor).to(equal(.black))
          expect(progressView.trackBorderWidth).to(equal(0))
          expect(progressView.trackTitleLabel).toNot(beNil())
          expect(progressView.trackTitleEdgeInsets).to(equal(.zero))
          expect(progressView.trackTitleAlignment).to(equal(.center))
          expect(progressView.trackImageView).toNot(beNil())
          expect(progressView.track.layer.masksToBounds).to(beTrue())
          expect(progressView.track.subviews.contains(progressView.trackTitleLabel)).to(beTrue())
          expect(progressView.track.subviews.contains(progressView.trackImageView)).to(beTrue())
        }
      }

      // MARK: - Variables

      // MARK: Data Source

      describe("Data Source") {
        context("When setting the data source") {
          var dataSource: MultiProgressViewDataSource!

          beforeEach {
            dataSource = MockMultiProgressViewDataSource()
            subject.dataSource = dataSource
          }

          it("should reload it's data") {
            expect(subject.reloadDataCalled).to(beTrue())
          }
        }
      }

      // MARK: Track Inset

      describe("Track Inset") {
        context("When setting trackInsets") {
          beforeEach {
            subject.trackInset = 0
          }

          it("should trigger a layout update") {
            expect(subject.setNeedsLayoutCalled).to(beTrue())
          }
        }
      }

      // MARK: Track Background Color

      describe("Track background color") {
        context("When setting trackBackgroundColor") {
          let color: UIColor = .blue

          beforeEach {
            subject.trackBackgroundColor = color
          }

          it("should correctly set the progress view's background color") {
            expect(subject.trackBackgroundColor).to(be(color))
          }
        }
      }

      // MARK: Track Title Insets

      describe("Track Title Insets") {
        context("When setting trackTitleInsets") {
          beforeEach {
            subject.trackTitleEdgeInsets = UIEdgeInsets()
          }

          it("should trigger a layout update") {
            expect(subject.setNeedsLayoutCalled).to(beTrue())
          }
        }
      }

      // MARK: Track Title Alignment

      describe("Track Title Alignment") {
        context("When setting trackTitleAlignment") {
          beforeEach {
            subject.trackTitleAlignment = .bottom
          }

          it("should trigger a layout update") {
            expect(subject.setNeedsLayoutCalled).to(beTrue())
          }
        }
      }

      // MARK: Line Cap Type

      describe("Line Cap Type") {
        context("When setting lineCapType") {
          beforeEach {
            subject.lineCap = .round
          }

          it("should trigger a layout update") {
            expect(subject.setNeedsLayoutCalled).to(beTrue())
          }
        }
      }

      // MARK: Borders

      describe("Borders") {
        context("When setting borderWidth") {
          let width = CGFloat()

          beforeEach {
            subject.borderWidth = width
          }

          it("should correctly set the border width") {
            expect(subject.layer.borderWidth).to(be(width))
          }
        }

        context("When setting borderColor") {
          let color: UIColor = .blue

          beforeEach {
            subject.borderColor = color
          }

          it("should correctly set the border color") {
            expect(subject.layer.borderColor).to(equal(color.cgColor))
          }
        }

        context("When setting the trackBorderColor") {
          let color: UIColor = .blue

          beforeEach {
            subject.trackBorderColor = color
          }

          it("should correctly set the progress view's border color") {
            expect(subject.track.layer.borderColor).to(equal(color.cgColor))
          }
        }

        context("When setting the trackBorderWidth") {
          let width = CGFloat()

          beforeEach {
            subject.trackBorderWidth = width
          }

          it("should correctly set the progress view's border width") {
            expect(subject.track.layer.borderWidth).to(be(width))
          }
        }
      }

      // MARK: Corner Radius

      describe("Corner Radius") {
        context("When setting cornerRadius") {
          beforeEach {
            subject.cornerRadius = 0
          }

          it("should call the updateCornerRadius method") {
            expect(subject.updateCornerRadiusCalled).to(beTrue())
          }
        }

        context("When calling the updateCornerRadius method") {
          let cornerRadius: CGFloat = 10
          let trackCornerRadius: CGFloat = 20

          beforeEach {
            mockLayoutProvider.testCornerRadius = cornerRadius
            mockLayoutProvider.testTrackCornerRadius = trackCornerRadius
            subject.updateCornerRadius()
          }

          afterEach {
            mockLayoutProvider.reset()
          }

          it("should correctly set the corner radius") {
            expect(subject.layer.cornerRadius).to(equal(cornerRadius))
          }

          it("should correctly set the track's corner radius") {
            expect(subject.track.layer.cornerRadius).to(equal(trackCornerRadius))
          }
        }
      }

      // MARK: Total Progress

      describe("Total Progress") {
        context("When accessing totalProgress") {
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

      // MARK: - Layout

      describe("Layout") {
        let numberOfSections: Int = 3
        var dataSource: MockMultiProgressViewDataSource!

        beforeEach {
          dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
          subject.dataSource = dataSource
        }

        context("When the layoutSubviews method is called") {
          let trackFrame = CGRect(x: 1, y: 2, width: 3, height: 4)
          let trackTitleLabelConstraints = [NSLayoutConstraint]()
          let trackTitleLabelAlignment: AlignmentType = .topLeft
          let trackTitleLabelInsets = UIEdgeInsets(top: 0, left: 1, bottom: 2, right: 3)
          let trackImageViewFrame = CGRect(x: 5, y: 6, width: 7, height: 8)
          let sectionFrame = CGRect(x: 9, y: 10, width: 11, height: 12)

          beforeEach {
            mockLayoutProvider.testTrackFrame = trackFrame
            mockLayoutProvider.testAnchorConstraints = trackTitleLabelConstraints
            mockLayoutProvider.testSectionFrame = sectionFrame
            mockLayoutProvider.testTrackImageViewFrame = trackImageViewFrame

            subject.trackTitleAlignment = trackTitleLabelAlignment
            subject.trackTitleEdgeInsets = trackTitleLabelInsets
            subject.layoutSubviews()
          }

          afterEach {
            mockLayoutProvider.reset()
          }

          it("should correctly set the track's frame") {
            expect(subject.track.frame).to(equal(trackFrame))
          }

          it("should correctly layout the trackTitleLabel") {
            expect(subject.trackTitleLabelConstraints).to(be(trackTitleLabelConstraints))
            expect(mockLayoutProvider.anchorToSuperviewAlignment).to(equal(trackTitleLabelAlignment))
            expect(mockLayoutProvider.anchorToSuperviewInsets).to(equal(trackTitleLabelInsets))
          }

          it("should correctly set the imageView's frame") {
            expect(subject.trackImageView.frame).to(equal(trackImageViewFrame))
          }

          it("should send the trackImageView to the back of the track's view hierarchy") {
            expect(subject.track.subviews[0]).to(equal(subject.trackImageView))
          }

          it("should layout each section and add each as a subview of the track") {
            for section in dataSource.progressViewSections {
              expect(section.frame).to(equal(sectionFrame))
              expect(section.superview).to(equal(subject.track))
            }
          }

          it("should correctly set the delegate for each section") {
            for section in dataSource.progressViewSections {
              expect(section.delegate).to(be(subject))
            }
          }

          it("should call the updateCornerRadius method") {
            expect(subject.updateCornerRadiusCalled).to(beTrue())
          }
        }
      }

      // MARK: - Getter/Setter Methods

      // MARK: Set Title

      describe("Set Title") {
        context("When calling the setTitle method") {
          let title = String()

          beforeEach {
            subject.setTitle(title)
          }

          it("should set the text on the trackTitleLabel") {
            expect(subject.trackTitleLabel.text).to(be(title))
          }
        }
      }

      // MARK: Set Track Image

      describe("Set Track Image") {
        context("When calling the setTrackImage method") {
          let image = UIImage()

          beforeEach {
            subject.setTrackImage(image)
          }

          it("should set the image on the trackImageView") {
            expect(subject.trackImageView.image).to(equal(image))
          }
        }
      }

      // MARK: Set Attributed Title

      describe("Set Attributed Title") {
        context("When calling the setAttributedTitle method") {
          let title = NSAttributedString(string: "title")

          beforeEach {
            subject.setAttributedTitle(title)
          }

          it("should set the attributed text on the trackTitleLabel") {
            expect(subject.trackTitleLabel.attributedText).to(equal(title))
          }
        }
      }

      // MARK: Progress

      describe("Progress") {
        context("When calling the progress(forSection:) method") {
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

      // MARK: - Did Tap Section At

      describe("Did Tap Section At") {
        context("When calling the didTapSectionAt method") {
          let numberOfSections = 5
          let index = 3
          var dataSource: MockMultiProgressViewDataSource!
          var delegate: MockMultiProgressViewDelegate!

          beforeEach {
            dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
            delegate = MockMultiProgressViewDelegate()
            subject.dataSource = dataSource
            subject.delegate = delegate

            let testSection = dataSource.progressViewSections[index]
            subject.didTapSection(testSection)
          }

          it("should call the delegate's didTapSectionAt method with the correct section index") {
            expect(delegate.didTapSectionAtCalled).to(beTrue())
            expect(delegate.didTapSectionIndex).to(equal(index))
          }
        }
      }

      // MARK: - Reload Data

      describe("Reload Data") {
        let numberOfSections: Int = 3
        var dataSource: MockMultiProgressViewDataSource!

        context("When calling the reloadData method when there is no data source") {
          beforeEach {
            subject.dataSource = nil
          }

          it("should not load any data") {
            expect(subject.reloadDataCalled).to(beTrue())
            expect(subject.progressViewSections.count).to(equal(0))
          }
        }

        context("When calling the reloadData method when there is no existing data") {
          beforeEach {
            dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
            subject.dataSource = dataSource
          }

          testReloadData()
        }

        context("When calling the reloadData when there is existing data") {
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

          it("should add the section/index pairs to the dictionary and remove any previous data") {
            for index in 0..<numberOfSections {
              let expectedSection = dataSource.progressViewSections[index]
              let actualSections = subject.progressViewSections.filter({ $0.value == index }).keys
              expect(actualSections.count).to(equal(1))
              expect(actualSections.first).to(be(expectedSection))
            }
          }

          it("should add each section as a subview to the track and remove any previous sections") {
            let trackSubviews = subject.track.subviews.filter { $0 is ProgressViewSection }
            expect(trackSubviews.count).to(equal(numberOfSections))
          }
        }
      }

      // MARK: - Set progress

      describe("Set Progress") {
        let numberOfSections: Int = 3
        var dataSource: MockMultiProgressViewDataSource!

        beforeEach {
          dataSource = MockMultiProgressViewDataSource(numberOfSections: numberOfSections)
          subject.dataSource = dataSource
        }

        context("When setting a progress") {
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

        context("When setting a progress that does not exceed 1") {
          let progress: Float = 0.1

          beforeEach {
            subject.setProgress(section: 0, to: progress)
          }

          it("should set the correct progress for the section") {
            expect(subject.progress(forSection: 0)).to(equal(progress))
          }
        }

        context("When setting a progress that exceeds 1") {
          let progress: Float = 1.1

          beforeEach {
            subject.setProgress(section: 0, to: progress)
          }

          it("should set the progress to 1") {
            expect(subject.progress(forSection: 0)).to(equal(1))
          }
        }

        context("When setting a negative progress on a section") {
          let progress: Float = -0.1

          beforeEach {
            subject.setProgress(section: 0, to: progress)
          }

          it("should set it's progress to zero") {
            expect(subject.progress(forSection: 0)).to(equal(0))
          }
        }

        context("When setting a progress on a section with existing progress") {
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

        context("When setting a progress which causes the sum of all sections' progress to exceed 1") {
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

      // MARK: - Reset Progress

      describe("Reset Progress") {
        context("When calling the resetProgress method") {
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
