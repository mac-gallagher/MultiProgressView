# MultiProgressView

[![Build Status](https://travis-ci.org/mac-gallagher/MultiProgressView.svg?branch=master)](https://travis-ci.org/mac-gallagher/MultiProgressView)
![CocoaPods](https://img.shields.io/cocoapods/p/MultiProgressView.svg)
![Swift-Version](https://img.shields.io/badge/Swift-5.0-orange.svg)
![CocoaPods](https://img.shields.io/cocoapods/v/MultiProgressView.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov](https://codecov.io/gh/mac-gallagher/MultiProgressView/branch/master/graph/badge.svg)](https://codecov.io/gh/mac-gallagher/MultiProgressView)

**MultiProgressView** is an animatable view that depicts multiple progresses over time. The `MultiProgressView` class mimics `UIProgressView` as much as possible while providing additional [customizations](#customization). 

## Example

To run the example project, clone the repo and run the `MultiProgressViewExample` target.

![Demo2](https://raw.githubusercontent.com/mac-gallagher/MultiProgressView/master/Images/example2.gif)

![Demo1](https://raw.githubusercontent.com/mac-gallagher/MultiProgressView/master/Images/example1.gif)

## Usage

### Programmatic
1. Add a `MultiProgressView` to your view hierarchy:

    ```swift
    let progressView = MultiProgressView()
    view.addSubview(progressView)
    ```
    
2. Conform your class to the `MultiProgressViewDataSource` protocol and set your progress view's `dataSource`:

    ```swift
    func numberOfSections(in progressView: MultiProgressView) -> Int
    func progressBar(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection
    ```
    
    ```swift
    progressView.dataSource = self
    ```
3. Call `setProgress(section:to:)` to update your view's progress:

    ```swift
    progressView.setProgress(section: 0, to: 0.4) //animatable
    ```

### Storyboards

1. Drag a `UIView` onto your view controller and set the view's class to `MultiProgressView` in the *Identity Inspector*:

   ![IdentityInspector](https://raw.githubusercontent.com/mac-gallagher/MultiProgressView/master/Images/storyboard_identity_inspector.gif)

3. Connect your progress view to your view controller with an `IBOutlet`:

   ![IBOutlet](https://raw.githubusercontent.com/mac-gallagher/MultiProgressView/master/Images/storyboard_ib_outlet.gif)

4. Conform your view controller to the `MultiProgressViewDataSource` protocol and implement the required methods:
 
   ```swift
    func numberOfSections(in progressView: MultiProgressView) -> Int
    func progressBar(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection
    ```
     
5. Set your view controller as the progress view's `dataSource`:
   
   ![DataSource](https://raw.githubusercontent.com/mac-gallagher/MultiProgressView/master/Images/storyboard_data_source.gif)

6. Call `setProgress(section:to:)` to update your view's progress:

    ```swift
    progressView.setProgress(section: 0, to: 0.4) //animatable
    ```

## Customization

### MultiProgressView
Each `MultiProgressView` exposes the variables listed below. If using storyboards, many of these properties can be customized directly in the view's *Attribute Inspector*.


```swift
var cornerRadius: CGFloat = 0
var borderWidth: CGFloat = 0
var borderColor: UIColor? = .black
var lineCap: LineCapType = .square 

var trackInset: CGFloat = 0
var trackBackgroundColor: UIColor? = .clear
var trackBorderColor: UIColor? = .black
var trackBorderWidth: CGFloat = 0

var trackImageView: UIImageView

var trackTitleLabel: UILabel
var trackTitleEdgeInsets: UIEdgeInsets = .zero
var trackTitleAlignment: AlignmentType = .center
```

**Note**: To apply a corner radius (using `layer.cornerRadius` or the `cornerRadius` variable) the `lineCap` type must be set to `.round`.


### ProgressViewSection
Each `ProgressViewSection` exposes the following variables:

```swift
var imageView: UIImageView
var titleLabel: UILabel
var titleEdgeInsets: UIEdgeInsets = .zero
var titleAlignment: AlignmentType = .center
```

## Installation

### CocoaPods
MultiProgressView is available through [CocoaPods](<https://cocoapods.org/>). To install it, simply add the following line to your Podfile:

	pod 'MultiProgressView'

### Carthage

MultiProgressView is also available through [Carthage](<https://github.com/Carthage/Carthage>). To install it, simply add the following line to your Cartfile:

	github "mac-gallagher/MultiProgressView"

### Manual
Download and drop the `MultiProgressView` directory into your project.

## Requirements
* iOS 9.0+
* Xcode 10.2+
* Swift 5.0+

## Author
Mac Gallagher, jmgallagher36@gmail.com.

## License
MultiProgressView is available under the MIT license. See [LICENSE](LICENSE) for more infomation.
