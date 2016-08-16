Pod::Spec.new do |s|

  s.name         = "Swiftility"
  s.version      = "0.9"
  s.summary      = "allbto utility library to use across my projects."
  s.homepage     = "https://github.com/allbto/ios-swiftility"
  s.license      = { :type => "MIT" }
  s.author    	 = "Allan Bto"

  s.platform     = :ios
  s.platform     = :ios, "8.0"

  s.source   = { :git => "https://github.com/allbto/ios-swiftility.git", :tag => s.version}

  s.public_header_files = "Swiftility/Swiftility/**/*.h"
  s.source_files  = "Swiftility/Swiftility/Classes/**/*.{h,m,swift}"

  s.requires_arc = true

end
