# MultiProgressView

![Swift-Version](https://img.shields.io/badge/Swift-4.2-orange.svg)
![CocoaPods](https://img.shields.io/cocoapods/v/MultiProgressView.svg)
![license](https://img.shields.io/cocoapods/l/MultiProgressView.svg)
![CocoaPods](https://img.shields.io/cocoapods/p/MultiProgressView.svg)

# About
**MultiProgressView** is a discrete, animatable progress bar that depicts multiple progresses over time. The `MultiProgressView` class mimics `UIProgressView` as much as possible while also providing additional customization options. 

# Example
To run the example project, clone the repo and run the `MultiProgressView-Example` target.

# Requirements
* iOS 9.0+
* Xcode 10.0+
* Swift 4.2+

# Installation

### CocoaPods
MultiProgressView is available through [CocoaPods](<https://cocoapods.org/>). To install it, simply add the following line to your `Podfile`:

	pod 'MultiProgressView'

### Manual
Download and drop the `MultiProgressView` directory into your project.

# Usage
1. Add a `MultiProgressView` to your view hierarchy:

    ```swift
    let progressView = MultiProgressView()
    view.addSubview(progressView)
    ```
    
2. Conform your class to the `MultiProgressViewDataSource` protocol and set your progress view's `dataSource`:

    ```swift
    func numberOfUnits(in progressBar: MultiProgressView) -> Int
    func numberOfSections(in progressBar: MultiProgressView) -> Int
    func progressBar(_ progressBar: MultiProgressView, barForSection section: Int) -> ProgressBarSection
    ```
    
    ```swift
    progressView.dataSource = self
    ```
3. Call the `setProgress` function to update your view's progress.

    ```swift
    UIView.animate(withDuration: 0.2) {
        self.progressView.setProgress(forSection: 0, steps: 4)
    }
    ```


## Customization

### MultiProgressView
Each `MultiProgressView` exposes the following variables:

```swift
var cornerRadius: CGFloat = 0
var borderWidth: CGFloat = 0
var borderColor: UIColor? = .black
var lineCap: LineCapType = .round 

var barInset: CGFloat = 0
var barBackgroundColor: UIColor? = .white
var barBorderColor: UIColor? = .black
var barBorderWidth: CGFloat = 0
var barTitleLabel: UILabel?
var barTitleEdgeInsets: UIEdgeInsets = .zero
var barTitleAlignment: AlignmentType = .center
```

### ProgressBarSection
Each `ProgressBarSection` exposes the following variables:

```swift
var titleLabel: UILabel?
var titleEdgeInsets: UIEdgeInsets = .zero
var titleAlignment: AlignmentType = .center
```

### Animating your progress
All of methods which alter the view's progress can be animated. For example:

```swift
UIView.animate(withDuration: 0.2) {
    self.progressBar.setProgress(forSection: 0, steps: 4)
}

```

# Contributing
- If you **found a bug**, open an issue and tag as bug.
- If you **have a feature request**, open an issue and tag as feature.
- If you **want to contribute**, submit a pull request.
	- In order to submit a pull request, please fork this repo and submit a pull request from your forked repo.
	- Have a detailed message as to what your pull request fixes/enhances/adds.

# To-do
- [ ] Support for Carthage installation
- [ ] Storyboard/`IBInspectable` support
- [ ] Support for both vertical and horizontal axis
- [ ] Continuous progress support

# Author
Mac Gallagher, jmgallagher36@gmail.com.

# License
MultiProgressView is available under the [MIT License](LICENSE), see LICENSE for more infomation.
