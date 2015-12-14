Pod::Spec.new do |s|

  s.name         = "Swiftility"
  s.version      = "0.2"
  s.summary      = "allbto utility libs to use across projects."
  s.homepage     = "https://github.com/allbto/ios-swiftility"
  s.license      = { :type => "MIT" }
  s.author    	 = "Allan Bto"

  s.platform     = :ios
  s.platform     = :ios, "8.0"

  s.source   = { :git => "https://github.com/allbto/ios-swiftility.git", :tag => "0.1"}

  s.public_header_files = "Swiftility/Swiftility/**/*.h"
  s.source_files  = "Swiftility/Swiftility/Classes/**/*.{h,m,swift}"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.requires_arc = true

  # s.dependency "JSONKit", "~> 1.4"

end
