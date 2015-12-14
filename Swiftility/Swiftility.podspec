Pod::Spec.new do |s|

  s.name         = "Swiftility"
  s.version      = "0.1"
  s.summary      = "allbto utility libs to use across projects."
  s.homepage     = "https://github.com/allbto/ios-swiftility"
  s.license      = { :type => "MIT" }
  s.author    	 = "Allan Bto"

  s.platform     = :ios
  s.platform     = :ios, "8.0"

  s.source   = { :git => "https://github.com/allbto/ios-swiftility.git", :tag => "0.1"}

  s.source_files  = "Classes", "Classes/**/*.{m,swift}"

  s.public_header_files = "Classes/**/*.h"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.requires_arc = true

  # s.dependency "JSONKit", "~> 1.4"

end
