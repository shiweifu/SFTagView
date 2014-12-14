Pod::Spec.new do |s|
  s.name         = "SFTagView"
  s.version      = "0.5"
  s.summary      = "SFTagView is a powerful UIView subclass"

  s.description  = <<-DESC
                    SFTagView is a view for display tags
                     - flexible layout, dynamic view height
                     - support depends autolayout constraints to get SFTagView's width, It's useful
                     - support specify set view's width of frame

                   DESC

  s.homepage     = "http://github.com/shiweifu/SFTagView"
  s.license      = "MIT"

  s.author       = { "shiweifu" => "shiweifu@gmail.com" }

  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/shiweifu/SFTagView.git", :tag => "0.5" }

  s.source_files  = "WrapViewWithAutolayout/*.{h,m}"
  s.exclude_files = "WrapViewWithAutolayout/AppDelegate.{h,m}", "WrapViewWithAutolayout/ViewController.{h,m}", "WrapViewWithAutolayout/main.m"
  s.framework  = "UIKit", "Foundation"
  
  s.requires_arc = true

  s.dependency "PureLayout"

end
