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

import MultiProgressView
import UIKit

@IBDesignable
class LanguageExampleProgressView: MultiProgressView {

  @IBInspectable var language: Int = 0 {
    didSet {
      titleLabel.text = CodingLanguage(rawValue: language)?.description
    }
  }

  @IBInspectable var percentage: Int = 0 {
    didSet {
      percentageLabel.text = "\(percentage)%"
    }
  }

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    label.textColor = .white
    return label
  }()

  private let percentageLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }

  private func initialize() {
    setupLabels()
    lineCap = .round
    titleLabel.isHidden = true
  }

  private func setupLabels() {
    addSubview(titleLabel)
    titleLabel.anchor(left: leftAnchor, paddingLeft: 8)
    titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    addSubview(percentageLabel)
    percentageLabel.anchor(right: rightAnchor, paddingRight: 8)
    percentageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }

  func shouldHideTitle(_ hide: Bool) {
    titleLabel.isHidden = hide
  }
}
