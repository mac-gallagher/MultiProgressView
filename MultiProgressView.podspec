Pod::Spec.new do |s|

s.name         = "MultiProgressView"
s.version      = "1.3.0"
s.platform     = :ios, "9.0"
s.summary      = "A replacement for UIProgressView that depicts multiple progresses over time"

s.description  = <<-DESC
A replacement for UIProgressView that depicts multiple progresses over time.
DESC

s.homepage     = "https://github.com/mac-gallagher/MultiProgressView"
s.documentation_url = "https://github.com/mac-gallagher/MultiProgressView/tree/master/README.md"
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.author       = { "Mac Gallagher" => "jmgallagher36@gmail.com" }
s.source       = { :git => "https://github.com/mac-gallagher/MultiProgressView.git", :tag => "v1.3.0" }

s.swift_version = "5.0"
s.source_files = "Sources/**/*.{h,swift}"

end
