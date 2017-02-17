Pod::Spec.new do |s|
  s.name         = "CHChatKit"
  s.version      = "0.9.6"
  s.summary      = "IM SDK FOR Objective-C ,implention EMHandler for Servive"
  s.homepage     = "https://github.com/chausson/CHChatKit"
  s.license      = "MIT"
  s.author       = { "Chausson" => "232564026@qq.com" } 
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/chausson/CHChatKit.git", :tag => s.version }
  s.source_files  = 'CHChatKit', 'CHChatKit/**/*.{h,m}'
  s.resources    = 'CHChatKit/Resource/*'
  s.requires_arc = true

  s.dependency "UITableView+FDTemplateLayoutCell"
  s.dependency "SDWebImage","~> 3.8.2"
  s.dependency "Masonry"
  s.dependency "Realm"
  s.dependency "CHProgressHUD"
  s.dependency "CHImagePicker"
  s.dependency "XEBEventBus"
  
end
