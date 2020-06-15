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

import UIKit

protocol ProgressViewSectionDelegate: AnyObject {
  func didTapSection(_ section: ProgressViewSection)
}

open class ProgressViewSection: UIView {

  public var titleLabel: UILabel {
    return sectionTitleLabel
  }

  private var sectionTitleLabel = UILabel()

  public var titleEdgeInsets: UIEdgeInsets = .zero {
    didSet {
      setNeedsLayout()
    }
  }

  public var titleAlignment: AlignmentType = .center {
    didSet {
      setNeedsLayout()
    }
  }

  public var imageView: UIImageView {
    return sectionImageView
  }

  var tapGestureRecognizer: UITapGestureRecognizer {
    return tapRecognizer
  }

  private lazy var tapRecognizer = TapGestureRecognizer(target: self,
                                                        action: #selector(didTap))

  var labelConstraints = [NSLayoutConstraint]() {
    didSet {
      NSLayoutConstraint.deactivate(oldValue)
      NSLayoutConstraint.activate(labelConstraints)
    }
  }

  weak var delegate: ProgressViewSectionDelegate?

  private var sectionImageView = UIImageView()

  private var layoutProvider: LayoutProvidable = LayoutProvider.shared

  // MARK: - Initialization

  override public init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }

  convenience init(layoutProvider: LayoutProvidable) {
    self.init(frame: .zero)
    self.layoutProvider = layoutProvider
  }

  private func initialize() {
    backgroundColor = .black
    layer.masksToBounds = true
    addSubview(sectionImageView)
    addSubview(sectionTitleLabel)
    addGestureRecognizer(tapGestureRecognizer)
  }

  // MARK: - Tap handler

  @objc
  private func didTap() {
    delegate?.didTapSection(self)
  }

  // MARK: - Layout

  override open func layoutSubviews() {
    super.layoutSubviews()
    labelConstraints = layoutProvider.anchorToSuperview(sectionTitleLabel,
                                                        withAlignment: titleAlignment,
                                                        insets: titleEdgeInsets)
    sectionImageView.frame = layoutProvider.sectionImageViewFrame(self)
    sendSubviewToBack(sectionImageView)
  }

  // MARK: - Main Methods

  public func setTitle(_ title: String?) {
    sectionTitleLabel.text = title
  }

  public func setAttributedTitle(_ title: NSAttributedString?) {
    sectionTitleLabel.attributedText = title
  }

  public func setImage(_ image: UIImage?) {
    sectionImageView.image = image
  }
}
