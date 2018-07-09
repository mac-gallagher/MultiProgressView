# MGSegmentedProgressBar
An animatable progress bar with support for multiple sections.

![ProgressBar](https://raw.githubusercontent.com/mac-gallagher/MGSegmentedProgressBar/master/Images/progress_bar.gif)

## Requirements
* iOS 9.0+
* Xcode 9.0+
* Swift 4.1+

## Installation

### CocoaPods
MGSegmentedProgressBar is available through [CocoaPods](<https://cocoapods.org/>). To install it, simply add the following line to your `Podfile`:

	pod 'MGSegmentedProgressBar'


### Manual
Download and drop the `MGSegmentedProgressBar ` directory into your project.

## Quick Start

```swift
class ViewController: UIViewController {

	var progressBar = MGSegmentedProgressBar()

	override func viewDidLoad() {
		view.addSubview(progressBar)
		progressBar.frame = CGRect(x: 50, y: 50, width: 200, height: 50)
		
		progressBar.dataSource = self
	}	
	
}

extension ViewController: MGSegmentedProgressBarDataSource {

	func progressBar(_ progressBar: MGSegmentedProgressBar, barForSection section: Int) -> MGBarView {
		return MGBarView()
	}
	
	func numberOfSections(in progressBar: MGSegmentedProgressBar) -> Int {
		return 3
	}
	
	func progressBar(_ progressBar: MGSegmentedProgressBar, numberOfStepsInSection section: Int) -> Int {
		return 4
	}
	
	//optional
	func progressBar(_ progressBar: MGSegmentedProgressBar, titleForSection section: Int) -> String? {
        return "Bar \(section + 1)"
    }

}

```

## Customization

### Adding animations
To animate any changes, simply call your progress bar's `layoutIfNeeded()` function in your animation block.
	
```swift
UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
	self.progressBar.layoutIfNeeded()
}, completion: nil)
```

## Author
Mac Gallagher, jmgallagher36@gmail.com

## License
MGSegmentedProgressBar is available under the [MIT License](LICENSE), see LICENSE for more infomation.
