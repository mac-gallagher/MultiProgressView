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

class LanguageExampleViewController: UIViewController {

  @IBOutlet private weak var backgroundView: UIView!
  @IBOutlet private weak var totalProgressLabel: UILabel!

  @IBOutlet private weak var progressView1: LanguageExampleProgressView!
  @IBOutlet private weak var progressView2: LanguageExampleProgressView!
  @IBOutlet private weak var progressView3: LanguageExampleProgressView!
  @IBOutlet private weak var progressView4: LanguageExampleProgressView!
  @IBOutlet private weak var progressView5: LanguageExampleProgressView!

  private lazy var progressViews = backgroundView.subviews.filter { $0 is LanguageExampleProgressView }
    as? [LanguageExampleProgressView] ?? []

  override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
  }

  private func initialize() {
    backgroundView.layer.borderColor = UIColor.LanguageExample.borderColor.cgColor
    backgroundView.layer.borderWidth = 0.5
  }

  @IBAction private func animateButtonTapped(_ sender: UIButton) {
    for progressView in progressViews {
      progressView.shouldHideTitle(false)
    }

    animateSetProgress(progressView1, firstProgress: 0.45, secondProgress: 0.15)
    animateSetProgress(progressView2, firstProgress: 0.2, secondProgress: 0.20)
    animateSetProgress(progressView3, firstProgress: 0.17, secondProgress: 0.03)
    animateSetProgress(progressView4, firstProgress: 0.40, secondProgress: 0.20)
    animateSetProgress(progressView5, firstProgress: 0.30, secondProgress: 0.50)

    totalProgressLabel.text = "52%"
  }

  private func animateSetProgress(_ progressView: LanguageExampleProgressView,
                                  firstProgress: Float,
                                  secondProgress: Float) {
    UIView.animate(withDuration: 0.25,
                   delay: 0,
                   options: .curveEaseInOut,
                   animations: { progressView.setProgress(section: 0, to: firstProgress) },
                   completion: { _ in
                    UIView.animate(withDuration: 0.25,
                                   delay: 0,
                                   options: .curveEaseInOut,
                                   animations: { progressView.setProgress(section: 1, to: secondProgress) },
                                   completion: nil)
    })

    progressView.percentage = Int(100 * (firstProgress + secondProgress))
  }

  @IBAction private func resetButtonTapped(_ sender: UIButton) {
    for progressView in progressViews {
      animateResetProgress(progressView)
    }
    totalProgressLabel.text = "0%"
  }

  private func animateResetProgress(_ progressView: LanguageExampleProgressView) {
    UIView.animate(withDuration: 0.25,
                   animations: {
                    progressView.setProgress(section: 0, to: 0)
                    progressView.setProgress(section: 1, to: 0)
    },
                   completion: { _ in
                    progressView.shouldHideTitle(true)
    })

    progressView.percentage = 0
  }
}

// MARK: - MultiProgressViewDataSource

extension LanguageExampleViewController: MultiProgressViewDataSource {
  func numberOfSections(in progressView: MultiProgressView) -> Int {
    return 5
  }

  func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
    guard let progressView = progressView as? LanguageExampleProgressView else { return ProgressViewSection() }

    let sectionView = ProgressViewSection()
    switch section {
    case 0:
      sectionView.backgroundColor = CodingLanguage(rawValue: progressView.language)?.darkColor
    case 1:
      sectionView.backgroundColor = CodingLanguage(rawValue: progressView.language)?.lightColor
    default:
      break
    }
    return sectionView
  }
}

// MARK: - MultiProgressViewDelegate

extension LanguageExampleViewController: MultiProgressViewDelegate {

  func progressView(_ progressView: MultiProgressView, didTapSectionAt index: Int) {
    for (progressViewIndex, view) in progressViews.enumerated() where view === progressView {
      print("Tapped progressView \(progressViewIndex) at section \(index)")
    }
  }
}
