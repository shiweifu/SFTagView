Pod::Spec.new do |s|
  s.name         = "SFTagView"
  s.version      = "0.5"
  s.summary      = "SFTagView is a a view for display tags"

  s.description  = <<-DESC
                    SFTagView is a view for display tags
                     - flexible layout, dynamic view height
                     - support depends autolayout constraints to get SFTagView's width, It's useful
                     - support specify set view's width of frame
                   DESC


  s.homepage     = "http://github.com/zsk425/SFTagView"
  s.license      = "MIT"
  s.author       = { "Shaokang Zhao" => "zsk425@hotmail.com" }
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/zsk425/SFTagView.git" }
  s.source_files  = "SFTagView/*"
  s.framework  = "UIKit", "Foundation"
  s.requires_arc = true
  s.dependency "Masonry"

end
