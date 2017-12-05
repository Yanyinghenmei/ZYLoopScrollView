Pod::Spec.new do |s|
  s.name         = "ZYLoopView"
  s.version      = "0.0.2"
	s.summary      = "loop scroll view."
	s.description  = <<-DESC
	                 Loop scroll view, local images and web image.
									 DESC
	s.homepage     = "https://github.com/Yanyinghenmei/ZYLoopView"
	s.license      = { :type => "MIT", :file => "LICENSE" }
	s.author       = { "Yanyinghenmei" => "1113135372@qq.om" }
	s.platform     = :ios, "8.0"
	s.source       = { :git => "git@github.com:Yanyinghenmei/ZYLoopView.git", :tag => s.version }
	s.source_files  = "ZYLoopView/**/*.{h,m}"
end
