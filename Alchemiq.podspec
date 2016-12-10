
Pod::Spec.new do |s|
  s.name             = 'Alchemiq'
  s.version          = '1.0.0'
  s.summary          = 'Alchemiq is a framework which provides mixins to Objetive-C'

  s.description      = <<-DESC
Alchemiq provides possibility of using mixins (aka traits) in Objective-C. Inspired by mixins ideas in Ruby modules and Swift protocol extensions.
                       DESC

  s.homepage         = 'https://github.com/iaagg/Alchemiq'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aleksey Getman' => 'getmanag@gmail.com' }
  s.source           = { :git => 'https://github.com/iaagg/Alchemiq.git', :tag => s.version.to_s }
how to
  s.ios.deployment_target = '7.0'

  s.source_files = 'Alchemiq/Classes/**/*'
end
