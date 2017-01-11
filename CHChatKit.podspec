Pod::Spec.new do |s|
  s.name         = "CHChatKit"
  s.version      = "1.0"
  s.summary      = "IM SDK FOR Objective-C ,implention EMHandler for Servive"
  s.homepage     = "https://github.com/chausson/CHChatKit""
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { "Chuasson" => "232564026@qq.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/chausson/CHChatKit.git", :tag => s.version.to_s }
  s.source_files  = 'CHChatKit'
  s.resources    = 'CHChatKit/ChatKit/Resources/*'

  s.requires_arc = true
  s.dependency "UITableView+FDTemplateLayoutCell"
  s.dependency "SDWebImage"
  s.dependency "Masonry"
  s.dependency "Realm"
  s.dependency "XEBEventBus"
  
end
