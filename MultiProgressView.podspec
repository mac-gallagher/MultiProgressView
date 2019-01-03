Pod::Spec.new do |s|

s.name         = "MultiProgressView"
s.version      = "0.4.1"
s.platform     = :ios, "9.0"
s.summary      = "An animatable progress bar with support for multiple sections"

s.description  = <<-DESC
An animatable progress bar with support for multiple sections.
DESC

s.homepage     = "https://github.com/mac-gallagher/MultiProgressView"
s.screenshots  = ["https://raw.githubusercontent.com/mac-gallagher/MultiProgressView/master/Images/progress_bar.gif"]
s.documentation_url = "https://github.com/mac-gallagher/MultiProgressView/tree/master/README.md"
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.author       = { "Mac Gallagher" => "jmgallagher36@gmail.com" }
s.source       = { :git => "https://github.com/mac-gallagher/MultiProgressView", :tag => "v0.4.1" }

s.swift_version = "4.2"
s.source_files = "MultiProgressView/Classes/**/*"

end
