Pod::Spec.new do |s|

s.name         = "MGSegmentedProgressBar"
s.version      = "0.3.1"
s.platform     = :ios, "9.0"
s.summary      = "An animatable progress bar with support for multiple sections"

s.description  = <<-DESC
An animatable progress bar with support for multiple sections.
DESC

s.homepage     = "https://github.com/mac-gallagher/MGSegmentedProgressBar"
s.screenshots  = ["https://raw.githubusercontent.com/mac-gallagher/MGSegmentedProgressBar/master/Images/progress_bar.gif"]
s.documentation_url = "https://github.com/mac-gallagher/MGSegmentedProgressBar/tree/master/README.md"
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.author       = { "Mac Gallagher" => "jmgallagher36@gmail.com" }
s.source       = { :git => "https://github.com/mac-gallagher/MGSegmentedProgressBar.git", :tag => "v0.3.1" }

s.swift_version = "4.2"
s.source_files = "MGSegmentedProgressBar/Classes/**/*"

end
