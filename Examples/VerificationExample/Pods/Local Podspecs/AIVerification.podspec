Pod::Spec.new do |s|
  s.name     = 'AIVerification'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = ''
  s.homepage = 'https://github.com/WideEyeLabs/AIVerification'
  s.authors  = {'Brian Thomas' => 'brian@wideeyelabs.com'}
  s.source   = { :git => 'https://github.com/WideEyeLabs/AIVerification.git', :tag => '1.0.0'}
  s.source_files = 'AIVerification'
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
end
