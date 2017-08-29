Pod::Spec.new do |s|
s.name = 'LFPopupMenu'
s.version = '1.1.3'
s.license = { :type => "MIT", :file => "LICENSE" }
s.summary = '带箭头的弹出菜单窗，样式灵活，使用简单'
s.homepage = 'https://github.com/zhanglinfeng/LFPopupMenu'
s.authors = { '张林峰' => '1051034428@qq.com' }
s.source = { :git => 'https://github.com/zhanglinfeng/LFPopupMenu.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'LFPopupMenu/LFPopupMenu/*.{h,m}'
end
