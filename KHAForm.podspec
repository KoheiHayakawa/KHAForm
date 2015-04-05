Pod::Spec.new do |s|
  s.name         = "KHAForm"
  s.version      = "0.0.3"
  s.summary      = "KHAForm is a simple swift library to build tableview form"
  s.homepage     = "https://github.com/KoheiHayakawa/KHAForm"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Kohei Hayakawa" => "hayakawa.kohei@itolab.nitech.ac.jp" }
  s.platform     = :ios
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/KoheiHayakawa/KHAForm.git", :tag => "0.0.3" }
  s.source_files  = "KHAForm"
end
