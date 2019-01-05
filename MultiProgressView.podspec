Pod::Spec.new do |s|

s.name         = "MultiProgressView"
s.version      = "1.0.0"
s.platform     = :ios, "9.0"
s.summary      = "An animatable progress bar that depicts multiple progresses over time"

s.description  = <<-DESC
An animatable progress bar that depicts multiple progresses over time.
DESC

s.homepage     = "https://github.com/mac-gallagher/MultiProgressView"
s.documentation_url = "https://github.com/mac-gallagher/MultiProgressView/tree/master/README.md"
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.author       = { "Mac Gallagher" => "jmgallagher36@gmail.com" }
s.source       = { :git => "https://github.com/mac-gallagher/MultiProgressView.git", :tag => "v1.0.0" }

s.swift_version = "4.2"
s.source_files = "MultiProgressView/Classes/**/*"

end
