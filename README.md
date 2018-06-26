# MGSegmentedProgressBar
An animatable progress bar with support for multiple sections.

![ProgressBar](https://raw.githubusercontent.com/mac-gallagher/MGSegmentedProgressBar/master/Images/progress_bar.gif)

## Installation

### CocoaPods
MGSegmentedProgressBar is available through [CocoaPods](<https://cocoapods.org/>). To install it, simply add the following line to your `Podfile`:

	pod 'MGSegmentedProgressBar'


### Manual
Download and drop the `Classes` directory into your project.

## Usage

1. Add a `MGSegmentedProgressBar ` to your view.

    ```swift
    class ViewController: UIViewController {
    
        var progressBar = MGSegmentedProgressBar()
        
        override func viewDidLoad() {
            view.addSubview(progressBar)
            progressBar.frame = CGRect(x: 50, y: 50, width: 200, height: 50)
        }
        
    }
    ```

2. Conform your view controller to the protocol `MGSegmentedProgressBarDataSource` and complete the following functions:

    ```swift
    func progressBar(_ progressBar: MGSegmentedProgressBar, barForSection section: Int) -> MGBarView
    
    func numberOfSections(in progressBar: MGSegmentedProgressBar) -> Int
    
    func progressBar(_ progressBar: MGSegmentedProgressBar, numberOfStepsInSection section: Int) -> Int
    ```
    
3. Set your progress bar's `dataSource` property.

    ```swift
    progressBar.dataSource = self
    ```

## Customization

### Adding animations
To animate any changes, simply call your progress bar's `layoutIfNeeded()` function in your animation block.
	
```swift
UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
	self.progressBar.layoutIfNeeded()
}, completion: nil)
```

## Requirements
* iOS 9.0+
* Xcode 9.0+

## Author
Mac Gallagher, jmgallagher36@gmail.com

## License
MGSegmentedProgressBar is available under the [MIT License](LICENSE), see LICENSE for more infomation.
