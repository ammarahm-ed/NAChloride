Pod::Spec.new do |s|

  s.name         = "NAChlorideUpdated"
  s.version      = "2.3.2"
  s.summary      = "Objective-C library for libsodium (NaCl)"
  s.homepage     = "https://github.com/ammarahm-ed/NAChloride"
  s.license      = { :type => "MIT" }
  s.author       = { "Gabriel Handford" => "gabrielh@gmail.com" }
  s.source       = { :git => "https://github.com/ammarahm-ed/NAChloride.git", :tag => s.version.to_s }
  s.dependency 'libsodium'
  s.requires_arc = true

  s.ios.deployment_target = "7.0"
  s.ios.source_files = 'NAChloride/**/*.{c,h,m}'
  
  s.tvos.deployment_target = "10.0"
  s.tvos.source_files = 'NAChloride/**/*.{c,h,m}'

  s.osx.deployment_target = "10.8"
  s.osx.source_files = 'NAChloride/**/*.{c,h,m}'

end
