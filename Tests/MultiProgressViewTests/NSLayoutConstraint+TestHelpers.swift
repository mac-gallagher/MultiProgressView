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

extension NSLayoutConstraint {

  override open func isEqual(_ object: Any?) -> Bool {
    guard let constraint = object as? NSLayoutConstraint else { return false }

    guard let firstItem = firstItem as? UIView,
      let constraintFirstItem = constraint.firstItem as? UIView else { return false }

    guard let secondItem = secondItem as? UIView,
      let constraintSecondItem = constraint.secondItem as? UIView else { return false }

    guard relation == constraint.relation,
      constant == constraint.constant,
      constant == constraint.constant,
      firstItem == constraintFirstItem,
      secondItem == constraintSecondItem,
      multiplier == constraint.multiplier,
      firstAttribute == constraint.firstAttribute,
      secondAttribute == constraint.secondAttribute else { return false }

    return true
  }
}
