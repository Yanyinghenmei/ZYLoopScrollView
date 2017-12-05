Pod::Spec.new do |s|

  s.name         = "ZYLoopScrollView"
  s.version      = "0.0.1"
  s.summary      = "A short description of ZYLoopScrollView."

  s.description  = <<-DESC
									 Loop scroll view
                   DESC

  s.homepage     = "https://github.com/Yanyinghenmei/ZYLoopScrollView"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Yanyinghenmei" => "1113135372@qq.om" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "git@github.com:Yanyinghenmei/ZYLoopScrollView.git", :tag => s.version }

  s.source_files  = "ZYLoopView/**/*.{h,m}"

end
