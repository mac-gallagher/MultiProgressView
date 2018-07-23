# MGSegmentedProgressBar
![Swift-Version](https://img.shields.io/badge/Swift-4.1-orange.svg)
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
     - [Updating your progress](#updating-your-progress)
      - [Data source & delegates](#data-source-&-delegates)
   - [MGBarView](#mgbarview)
- [Author](#author)
- [License](#license)

# Requirements
* iOS 9.0+
* Xcode 9.0+
* Swift 4.1+

# Installation

### CocoaPods
MGSegmentedProgressBar is available through [CocoaPods](<https://cocoapods.org/>). To install it, simply add the following line to your `Podfile`:

	pod 'MGSegmentedProgressBar'

### Manual
Download and drop the `MGSegmentedProgressBar ` directory into your project.

# Contributing
- If you **found a bug**, open an issue and tag as bug.
- If you **have a feature request**, open an issue and tag as feature.
- If you **want to contribute**, submit a pull request.
	- In order to submit a pull request, please fork this repo and submit a pull request from your forked repo.
	- Have a detailed message as to what your pull request fixes/enhances/adds.

# Quick Start
The following example produces a progress bar with two sections and buttons to advance each.

```swift
class ViewController: UIViewController {

    let progressBar = MGSegmentedProgressBar()
    
    let button1: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 1
        button.setTitle("Advance section 1", for: .normal)
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 2
        button.setTitle("Advance section 1", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //configure progress bar
        view.addSubview(progressBar)
        progressBar.frame = CGRect(x: 50, y: 50, width: view.bounds.width - 100, height: 50)
        progressBar.dataSource = self
        
        //configure buttons
        view.addSubview(button1)
        button1.frame = CGRect(x: 50, y: 100, width: view.bounds.width - 100, height: 50)
        button1.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
        
        view.addSubview(button2)
        button2.frame = CGRect(x: 50, y: 150, width: view.bounds.width - 100, height: 50)
        button2.addTarget(self, action: #selector(handleTouch), for: .touchUpInside)
    }	
    
    @objc func handleTouch(_ sender: UIButton) {
        progressBar.advance(section: sender.tag - 1)
    }
    
}

//MARK: Data Source

extension ViewController: MGSegmentedProgressBarDataSource {

    func progressBar(_ progressBar: MGSegmentedProgressBar, barForSection section: Int) -> MGBarView {
        let bar =  MGBarView()
        bar.backgroundColor = section % 2 == 0 ? .red : .blue
        return bar
    }
    
    func numberOfSections(in progressBar: MGSegmentedProgressBar) -> Int {
        return 2
    }
    
    func numberOfSteps(in progressBar: MGSegmentedProgressBar) -> Int {
        return 10
    }

}

```

# Architecture
There are two major components in the `MGSegmentedProgressBar` framework. The first is the `MGSegmentedProgressBar` which displays the individual bars. It is responsible for maintaining the overall progress and controlling the width of each bar. The second component is the bars themselves. Each `MGBarView` has an optional title which can be set via data source and delegate methods.

## MGSegmentedProgressBar
To use a `MGSegmentedProgressBar `, add it to your view and implement the `MGSegmentedProgressBarDataSource` protocol. Each `MGSegmentedProgressBar` exposes the following variables:

```swift
var dataSource: MGSegmentedProgressBarDataSource?
var trackInset: CGFloat = 0
var trackBackgroundColor: UIColor?
var titleLabel: UILabel?
var labelEdgeInsets: UIEdgeInsets = .zero
var labelAlignment: MGLabelAlignment = .center
var lineCap: MGLineCap = .round
```

### Updating your progress
There are two methods in `MGSegmentedProgressBar` you can call to update your bar's progress. Both of these methods are animatable.

The first method resets the progress in the given section to the provided step count.

```swift
func setProgress(section: Int, steps: Int)
```

The second method advances the current section by the given number of steps.

```swift
func advance(section: Int, by numberOfSteps: Int = 1)
```

The method below resets your bar's progress entirely. It is also animatable.

```swift
func resetProgress()
```

### Data source & delegates
To load your bar views into your `MGSegmentedProgressBar`, you must conform your view controller to the `MGSegmentedProgressBarDataSource` protocol and implement the following functions:

```swift
func numberOfSteps(in progressBar: MGSegmentedProgressBar) -> Int
func numberOfSections(in progressBar: MGSegmentedProgressBar) -> Int
func progressBar(_ progressBar: MGSegmentedProgressBar, barForSection section: Int) -> MGBarView
```

The protocol also has a number of optional methods:

```swift
func progressBar(_ progressBar: MGSegmentedProgressBar, maximumNumberOfStepsForSection section: Int) -> Int
func progressBar(_ progressBar: MGSegmentedProgressBar, attributedTitleForSection section: Int) -> NSAttributedString?
func progressBar(_ progressBar: MGSegmentedProgressBar, titleForSection section: Int) -> String?

```

To customize your bar titles, conform your view controller to the `MGSegmentedProgressBarDelegate` protocol. All the methods in this protocol are optional.

```swift
func progressBar(_ progressBar: MGSegmentedProgressBar, titleInsetsForSection section: Int) -> UIEdgeInsets
func progressBar(_ progressBar: MGSegmentedProgressBar, titleAlignmentForSection section: Int) -> MGLabelAlignment
func progressBar(_ progressBar: MGSegmentedProgressBar, titleAlwaysVisibleForSection section: Int) -> Bool
```

## MGBarView
The `MGBarView` is essentially a UIView with an optional title. Titles will only be visible if bar is large enough to fit the label. To change this behavior, set `titleAlwaysVisible ` to `true`. Each`MGBarView` exposes the following variables:

```swift
var titleLabel: UILabel?
var labelEdgeInsets: UIEdgeInsets = .zero
var labelAlignment: MGLabelAlignment = .center
var titleAlwaysVisible: Bool = false
```

# Author
Mac Gallagher, jmgallagher36@gmail.com

# License
MGSegmentedProgressBar is available under the [MIT License](LICENSE), see LICENSE for more infomation.
