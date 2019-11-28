import Quick
import Nimble

@testable import MultiProgressView

class ProgressViewSectionSpec: QuickSpec {
    override func spec() {
        describe("ProgressViewSection") {
            let mockLayoutProvider = MockLayoutProvider.self
            var subject: TestableProgressViewSection!
            
            beforeEach {
                subject = TestableProgressViewSection(layoutProvider: mockLayoutProvider)
            }
            
            // MARK: - Initialization
            
            describe("Initialization") {
                var section: ProgressViewSection!
                
                context("When initializing a new section with the default initializer") {
                    beforeEach {
                        section = ProgressViewSection()
                    }
                    
                    it("should have the correct default properties") {
                        testDefaultProperties()
                    }
                }
                
                context("When initializing a new section with the required initializer") {
                    beforeEach {
                        // TODO: - Find a non-deprecated way to accomplish this
                        let coder = NSKeyedUnarchiver(forReadingWith: Data())
                        section = ProgressViewSection(coder: coder)
                    }
                    
                    it("should have the correct default properties") {
                        testDefaultProperties()
                    }
                }
                
                func testDefaultProperties() {
                    expect(section.titleLabel).toNot(beNil())
                    expect(section.titleEdgeInsets).to(equal(.zero))
                    expect(section.titleAlignment).to(equal(.center))
                    expect(section.imageView).toNot(beNil())
                    expect(section.backgroundColor).to(equal(.black))
                    expect(section.layer.masksToBounds).to(beTrue())
                    expect(section.subviews.contains(section.imageView)).to(beTrue())
                    expect(section.subviews.contains(section.titleLabel)).to(beTrue())
                    expect(section.gestureRecognizers?.count).to(equal(1))
                }
            }
            
            // MARK: - Variables
            
            // MARK: Title Insets
            
            describe("Title Insets") {
                context("When setting the title insets") {
                    beforeEach {
                        subject.titleEdgeInsets = UIEdgeInsets()
                    }
                    
                    it("should trigger a layout update") {
                        expect(subject.setNeedsLayoutCalled).to(beTrue())
                    }
                }
            }
            
            // MARK: Title Alignment
            
            describe("Title Alignment") {
                context("When setting the title alignment") {
                    beforeEach {
                        subject.titleAlignment = .bottom
                    }
                    
                    it("should trigger a layout update") {
                        expect(subject.setNeedsLayoutCalled).to(beTrue())
                    }
                }
            }
            
            // MARK: - Layout
            
            describe("Layout") {
                context("When calling the layoutSubviews method") {
                    let titleAlignment: AlignmentType = .topLeft
                    let titleEdgeInsets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
                    let labelConstraints = [NSLayoutConstraint]()
                    let imageViewFrame = CGRect(x: 1, y: 2, width: 3, height: 4)
                    
                    beforeEach {
                        mockLayoutProvider.testAnchorConstraints = labelConstraints
                        mockLayoutProvider.testSectionImageViewFrame = imageViewFrame
                        subject.titleAlignment = titleAlignment
                        subject.titleEdgeInsets = titleEdgeInsets
                        subject.layoutSubviews()
                    }
                    
                    afterEach {
                        mockLayoutProvider.reset()
                    }
                    
                    it("should correctly set the title label's constraints") {
                        expect(subject.labelConstraints).to(be(labelConstraints))
                        expect(mockLayoutProvider.anchorToSuperviewAlignment).to(equal(titleAlignment))
                        expect(mockLayoutProvider.anchorToSuperviewInsets).to(equal(titleEdgeInsets))
                    }
                    
                    it("should correctly set the imageView's frame") {
                        expect(subject.imageView.frame).to(equal(imageViewFrame))
                    }
                    
                    it("should send the the imageView to the back of the view hierarchy") {
                        expect(subject.sendSubviewToBackView).to(be(subject.imageView))
                    }
                }
            }
            
            // MARK: - Tap Gesture Recognizer
            
            describe("Tap Gesture Recognizer") {
                context("When performing a tap on the section") {
                    var mockDelegate: MockProgressViewSectionDelegate!
                    
                    beforeEach {
                        mockDelegate = MockProgressViewSectionDelegate()
                        subject.delegate = mockDelegate
                        
                        let tapGestureRecognizer = subject.tapGestureRecognizer as? TestableTapGestureRecognizer
                        tapGestureRecognizer?.performTap(withLocation: .zero)
                    }
                    
                    it("should call the delegate's didTapSection method") {
                        expect(mockDelegate.didTapSectionCalled).to(beTrue())
                    }
                }
            }
            
            // MARK: - Main Methods
            
            // MARK: Set Title
            
            describe("Set Title") {
                context("When calling the setTitle method") {
                    let title: String = "title"
                    
                    beforeEach {
                        subject.setTitle(title)
                    }
                    
                    it("should set the titleLabel's title") {
                        expect(subject.titleLabel.text).to(equal(title))
                    }
                }
            }
            
            // MARK: Set Attributed Title
            
            describe("Set Attributed Title") {
                context("When calling the setAttributedTitle method") {
                    let attributedTitle = NSAttributedString(string: "title")
                    
                    beforeEach {
                        subject.setAttributedTitle(attributedTitle)
                    }
                    
                    it("should set the titleLabel's attributed title") {
                        expect(subject.titleLabel.attributedText).to(equal(attributedTitle))
                    }
                }
            }
            
            // MARK: Set Image
            
            describe("Set Image") {
                context("when calling the setImage method") {
                    let image = UIImage()
                    
                    beforeEach {
                        subject.setImage(image)
                    }
                    
                    it("should set the imageView's image") {
                        expect(subject.imageView.image).to(equal(image))
                    }
                }
            }
        }
    }
}
