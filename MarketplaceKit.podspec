Pod::Spec.new do |s|
  s.name          = "MarketplaceKit"
  s.version       = "0.0.1"
  s.summary       = "SDK that provides marketplace related functionality to build 214 alpha applications."
  s.license       = { }
  s.homepage      = "https://github.com/214alpha/marketplace-ios-kit"
  s.author        = { "Andrii Selivanov" => "seland@214alpha.com" }
  s.platform      = :ios, "11.0"
  s.source        = { :git => "git@github.com:214alpha/marketplace-ios-kit.git" }
  s.source_files  = "MarketplaceKit/**/*.swift"
  s.framework     = "UIKit"
  s.dependency 'Apollo', '0.10.0'
  s.dependency 'FlowKit', '0.0.2'
  s.dependency 'RealmSwift', '3.16.1'
  s.dependency 'CommunityKit', '0.0.2'
end
