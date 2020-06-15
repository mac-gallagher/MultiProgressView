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

protocol LayoutProvidable {
  func trackFrame(_ progressView: MultiProgressView) -> CGRect
  func trackImageViewFrame(_ progressView: MultiProgressView) -> CGRect
  func cornerRadius(_ progressView: MultiProgressView) -> CGFloat
  func trackCornerRadius(_ progressView: MultiProgressView) -> CGFloat

  func sectionFrame(_ progressView: MultiProgressView, section: Int) -> CGRect
  func sectionImageViewFrame(_ section: ProgressViewSection) -> CGRect

  func anchorToSuperview(_ view: UIView,
                         withAlignment alignment: AlignmentType,
                         insets: UIEdgeInsets) -> [NSLayoutConstraint]
}

class LayoutProvider: LayoutProvidable {

  static let shared = LayoutProvider()

  func trackFrame(_ progressView: MultiProgressView) -> CGRect {
    switch progressView.lineCap {
    case .butt:
      return CGRect(x: 0,
                    y: progressView.trackInset,
                    width: progressView.frame.width,
                    height: progressView.frame.height - 2 * progressView.trackInset)
    case .round, .square:
      return CGRect(x: progressView.trackInset,
                    y: progressView.trackInset,
                    width: progressView.frame.width - 2 * progressView.trackInset,
                    height: progressView.frame.height - 2 * progressView.trackInset)
    }
  }

  func trackImageViewFrame(_ progressView: MultiProgressView) -> CGRect {
    return progressView.track.bounds
  }

  func cornerRadius(_ progressView: MultiProgressView) -> CGFloat {
    switch progressView.lineCap {
    case .round:
      return progressView.cornerRadius == 0 ?
        progressView.bounds.height / 2 : progressView.cornerRadius
    case .butt, .square:
      return 0
    }
  }

  func trackCornerRadius(_ progressView: MultiProgressView) -> CGFloat {
    let cornerRadiusFactor = progressView.cornerRadius / progressView.bounds.height
    let trackHeight = progressView.track.bounds.height

    switch progressView.lineCap {
    case .round:
      return progressView.cornerRadius == 0 ?
        trackHeight / 2 : cornerRadiusFactor * trackHeight
    case .butt, .square:
      return 0
    }
  }

  func sectionFrame(_ progressView: MultiProgressView, section: Int) -> CGRect {
    let trackBounds = progressView.track.bounds
    let width = trackBounds.width * CGFloat(progressView.progress(forSection: section))
    let size = CGSize(width: width, height: trackBounds.height)

    var origin: CGPoint = trackBounds.origin
    for (bar, index) in progressView.progressViewSections where index < section {
      origin.x += bar.frame.width
    }

    return CGRect(origin: origin, size: size)
  }

  func sectionImageViewFrame(_ section: ProgressViewSection) -> CGRect {
    return section.bounds
  }

  func anchorToSuperview(_ view: UIView,
                         withAlignment alignment: AlignmentType,
                         insets: UIEdgeInsets) -> [NSLayoutConstraint] {
    guard let superview = view.superview else { return [] }
    view.translatesAutoresizingMaskIntoConstraints = false

    var constraints = [NSLayoutConstraint]()

    let topConstraint = view.topAnchor.constraint(equalTo: superview.topAnchor,
                                                  constant: insets.top)
    let leftConstraint = view.leftAnchor.constraint(equalTo: superview.leftAnchor,
                                                    constant: insets.left)
    let rightConstraint = view.rightAnchor.constraint(equalTo: superview.rightAnchor,
                                                      constant: -insets.right)
    let bottomConstraint = view.bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                                                        constant: -insets.bottom)
    let centerXConstraint = view.centerXAnchor.constraint(equalTo: superview.centerXAnchor,
                                                          constant: insets.left - insets.right)
    let centerYConstraint = view.centerYAnchor.constraint(equalTo: superview.centerYAnchor,
                                                          constant: insets.top - insets.bottom)

    switch alignment {
    case .bottom:
      constraints.append(bottomConstraint)
      constraints.append(centerXConstraint)

    case .bottomLeft:
      constraints.append(bottomConstraint)
      constraints.append(leftConstraint)

    case .bottomRight:
      constraints.append(bottomConstraint)
      constraints.append(rightConstraint)

    case .center:
      constraints.append(centerXConstraint)
      constraints.append(centerYConstraint)

    case .left:
      constraints.append(leftConstraint)
      constraints.append(centerYConstraint)

    case .right:
      constraints.append(rightConstraint)
      constraints.append(centerYConstraint)

    case .top:
      constraints.append(topConstraint)
      constraints.append(centerXConstraint)

    case .topLeft:
      constraints.append(topConstraint)
      constraints.append(leftConstraint)

    case .topRight:
      constraints.append(topConstraint)
      constraints.append(rightConstraint)
    }

    constraints.forEach { $0.isActive = true }

    return constraints
  }
}
