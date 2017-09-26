Pod::Spec.new do |s|

  s.name         = "SpotifyKit"
  s.version      = "0.0.1"
  s.summary      = "A iOS and Mac client for Spotify Web API"

  s.description  = <<-DESC
  SpotifyKit allows access to Spotify Web API calls in your iOS or Mac app.
                   DESC

  s.homepage	 = "https://github.com/xzzz9097/SpotifyKit"
  s.license 	 = { :type => 'MIT', :file => 'LICENSE' }
  s.author 		 = { "John Doe" => "xzzz9097@gmail.com" }

  s.source       = { :git => "https://github.com/xzzz9097/SpotifyKit.git", :tag => "#{s.version}" }

  s.source_files  = "Sources/*.swift"

  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.12'
end
