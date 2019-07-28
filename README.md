<H1 align="center"> MultiProgressView
</H1>

<H4 align="center">
📊 An animatable view that depicts multiple progresses over time.
</br>
Modeled after UIProgressView.
</H4>

<p align="center">
<a href="https://developer.apple.com/swift"><img alt="Swift 5" src="https://img.shields.io/badge/language-Swift_5-orange.svg"/></a>
<a href="https://cocoapods.org/pods/MultiProgressView"><img alt="CocoaPods" src="https://img.shields.io/cocoapods/v/MultiProgressView.svg"/></a>
<a href="https://github.com/Carthage/Carthage"><img alt="Carthage" src="https://img.shields.io/badge/carthage-compatible-4BC51D.svg?style=flat)"/></a>
<a href="https://swift.org/package-manager"><img alt="Swift Package Manager" src="https://img.shields.io/badge/swift pm-compatible-yellow.svg"/></a>
</br>
<a href="https://travis-ci.org/mac-gallagher/MultiProgressView"><img alt="Build Status" src="https://travis-ci.com/mac-gallagher/MultiProgressView.svg?branch=master"/></a>
<a href="https://cocoapods.org/pods/MultiProgressView"><img alt="Platform" src="https://img.shields.io/cocoapods/p/MultiProgressView.svg"/></a>
<a href="https://codecov.io/gh/mac-gallagher/MultiProgressView"><img alt="Code Coverage" src="https://codecov.io/gh/mac-gallagher/MultiProgressView/branch/master/graph/badge.svg"></a>
<a href="https://github.com/mac-gallagher/MultiProgressView/blob/master/LICENSE"><img alt="LICENSE" src="https://img.shields.io/cocoapods/l/MultiProgressView"></a>
</p>

<p align="center">
Made with ❤️ by <a href="https://github.com/mac-gallagher">Mac Gallagher</a>
</p>

<p align="center">
<img src="https://raw.githubusercontent.com/mac-gallagher/MultiProgressView/master/Images/example1.gif" width="550">

<!--<img src="https://raw.githubusercontent.com/mac-gallagher/MultiProgressView/master/Images/example2.gif" width="400">
</p>-->

---

## Example

To run the example project, clone the repo and run the `MultiProgressViewExample` target.

## Basic Usage

### Programmatic
1. Add a `MultiProgressView` to your view hierarchy:

    ```swift
    let progressView = MultiProgressView()
    view.addSubview(progressView)
    ```
    
2. Conform your class to the `MultiProgressViewDataSource` protocol and set your progress view's `dataSource`:

    ```swift
    func numberOfSections(in progressView: MultiProgressView) -> Int
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection
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
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection
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

MultiProgressView is available through [Carthage](<https://github.com/Carthage/Carthage>). To install it, simply add the following line to your Cartfile:

	github "mac-gallagher/MultiProgressView"

### Swift Package Manager
MultiProgressView is available through [Swift PM](<https://swift.org/package-manager/>). To install it, simply add the package as a dependency in `Package.swift`:

```swift
dependencies: [
  .package(url: "https://github.com/mac-gallagher/MultiProgressView.git", from: "1.2.0"),
]
```

### Manual
Download and drop the `MultiProgressView` directory into your project.

## Requirements
* iOS 9.0+
* Xcode 10.2+
* Swift 5.0+

## License
MultiProgressView is available under the MIT license. See [LICENSE](LICENSE) for more infomation.
