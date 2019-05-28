#
# Be sure to run `pod lib lint Graphus.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PrettyCards'
  s.version          = '1.0.0'
  s.summary          = 'Powerfull tool for creating views like iOS 11 appstore cards or buttons.'
  s.homepage         = 'https://github.com/ilia3546/PrettyCards'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ilya Kharlamov' => 'ilia3546@me.com' }
  s.source           = { :git => 'https://github.com/ilia3546/PrettyCards.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.swift_version = ['4.2', '5.0']
  s.source_files  = 'Source/*.{swift,h,m}'
end
