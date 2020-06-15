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

class StorageStackView: UIStackView {

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 11)
    return label
  }()

  private lazy var colorView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = colorViewHeight / 4
    view.layer.masksToBounds = true
    return view
  }()

  private let colorViewHeight: CGFloat = 11

  init(storageType: StorageType) {
    super.init(frame: .zero)
    alignment = .fill
    spacing = 6

    addArrangedSubview(colorView)
    colorView.anchor(width: colorViewHeight, height: colorViewHeight)
    colorView.backgroundColor = storageType.color

    addArrangedSubview(titleLabel)
    titleLabel.text = storageType.description
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
