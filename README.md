# MGSegmentedProgressBar
![Swift-Version](https://img.shields.io/badge/Swift-4.2-orange.svg)
![CocoaPods](https://img.shields.io/cocoapods/v/MGSegmentedProgressBar.svg)
![license](https://img.shields.io/cocoapods/l/MGSegmentedProgressBar.svg)
![CocoaPods](https://img.shields.io/cocoapods/p/MGSegmentedProgressBar.svg)

An animatable progress bar with support for multiple sections.

![ProgressBar](https://raw.githubusercontent.com/mac-gallagher/MGSegmentedProgressBar/master/Images/progress_bar.gif)

***

- [Requirements](#requirements)
- [Installation](#installation)
- [Contributing](#contributing)
- [Quick Start](#quick-start)
- [Architecture](#architecture)
   - [MGSegmentedProgressBar](#mgsegmentedprogressbar)
     - [Animating your progress](#animating-your-progress)
   - [ProgressBarSection](#progressbarsection)
- [Author](#author)
- [License](#license)

# Requirements
* iOS 9.0+
* Xcode 10.0+
* Swift 4.2+

# Installation

### CocoaPods
MGSegmentedProgressBar is available through [CocoaPods](<https://cocoapods.org/>). To install it, simply add the following line to your `Podfile`:

	pod 'MGSegmentedProgressBar'

### Manual
Download and drop the `MGSegmentedProgressBar` directory into your project.

# Contributing
- If you **found a bug**, open an issue and tag as bug.
- If you **have a feature request**, open an issue and tag as feature.
- If you **want to contribute**, submit a pull request.
	- In order to submit a pull request, please fork this repo and submit a pull request from your forked repo.
	- Have a detailed message as to what your pull request fixes/enhances/adds.

# Quick Start
1. Add a `MGSegmentedProgressBar` to your view hierarchy.
2. Conform to the `MGSegmentedProgressBarDataSource` protocol (don't forget to set your progress bar's `dataSource`) and implement the following functions:

    ```swift
    func numberOfSteps(in progressBar: MGSegmentedProgressBar) -> Int
    func numberOfSections(in progressBar: MGSegmentedProgressBar) -> Int
    func progressBar(_ progressBar: MGSegmentedProgressBar, barForSection section: Int) -> MGBarView
    ```
3. Done!

The progress of each section can be changed by calling any of the following functions:

```swift
func setProgress(forSection section: Int, steps: Int) //sets the progress
func advance(section: Int, by numberOfSteps: Int = 1) //advances the existing progress 
func resetProgress() //sets the progress of all section to zero
```

# Architecture
There are two major components in the `MGSegmentedProgressBar` framework. The first is the `MGSegmentedProgressBar` which displays the individual bar sections. It is responsible for maintaining the overall progress and controlling the width of each bar. The second component are the bar sections themselves.

## MGSegmentedProgressBar
Each `MGSegmentedProgressBar` exposes the following variables:

```swift
var dataSource: MGSegmentedProgressBarDataSource?

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

### Animating your progress
All of methods which change the progress can easily be animated. For example,

```swift
UIView.animate(withDuration: 0.2) {
	self.progressBar.setProgress(forSection: 0, steps: 4)
}

```

## ProgressBarSection
Each `ProgressBarSection` exposes the following variables:

```swift
var titleLabel: UILabel?
var titleEdgeInsets: UIEdgeInsets = .zero
var titleAlignment: AlignmentType = .center
```

# Author
Mac Gallagher, jmgallagher36@gmail.com.

# License
MGSegmentedProgressBar is available under the [MIT License](LICENSE), see LICENSE for more infomation.
