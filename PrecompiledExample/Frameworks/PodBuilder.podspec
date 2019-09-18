Pod::Spec.new do |s|
  s.name             = "PodBuilder"
  s.version          = "0.0.1"
  s.summary          = "Prebuilt frameworks"
  
  s.description      = <<-DESC
  A set of prebuilt frameworks to make compilation faster
  DESC
  
  s.homepage         = "https://www.subito.it"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "Tomas Camin" => "tomas.camin@schibsted.com" }
  s.source           = { :git => "https://www.subito.it", :tag => s.version.to_s }
  
  s.platform     = :ios, '10.0'
  s.requires_arc = true
  
  s.subspec 'GCDWebServer' do |p|
    p.vendored_frameworks = 'Rome/GCDWebServer.framework'
  end

  s.subspec 'SBTUITestTunnel_Client' do |p|
    p.vendored_frameworks = 'Rome/SBTUITestTunnel/Client/SBTUITestTunnel.framework'
    p.frameworks = 'XCTest'
    p.libraries = 'z'
    p.resources = 'Rome/SBTUITestTunnel/Client/SBTUITestTunnel.framework/*.{nib,bundle,xcasset,strings,png,jpg,tif,tiff,otf,ttf,ttc,plist,json,caf,wav,p12,momd}'
    p.exclude_files = 'Rome/SBTUITestTunnel/Client/SBTUITestTunnel.framework/Info.plist', 'Rome/SBTUITestTunnel/Client/SBTUITestTunnel.framework/PodBuilder.plist'
    p.xcconfig = {"OTHER_LDFLAGS"=>"-ObjC"}
  end

  s.subspec 'SBTUITestTunnel_Server' do |p|
    p.vendored_frameworks = 'Rome/SBTUITestTunnel/Server/SBTUITestTunnel.framework','Rome/GCDWebServer.framework'
    p.libraries = 'z'
    p.resources = 'Rome/SBTUITestTunnel/Server/SBTUITestTunnel.framework/*.{nib,bundle,xcasset,strings,png,jpg,tif,tiff,otf,ttf,ttc,plist,json,caf,wav,p12,momd}'
    p.exclude_files = 'Rome/SBTUITestTunnel/Server/SBTUITestTunnel.framework/Info.plist', 'Rome/GCDWebServer.framework/PodBuilder.plist', 'Rome/SBTUITestTunnel/Server/SBTUITestTunnel.framework/PodBuilder.plist'
    p.xcconfig = {"OTHER_LDFLAGS"=>"-ObjC"}
  end
end