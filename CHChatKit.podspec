Pod::Spec.new do |s|
  s.name         = "CHChatKit"
  s.version      = "0.6"
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
  s.dependency "SDWebImage"
  s.dependency "Masonry"
  s.dependency "Realm"
  s.dependency "XEBEventBus"
  
end
