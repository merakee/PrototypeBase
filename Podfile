# Podfile
platform :ios, '8.0'

# Uncomment this line if you're using Swift
use_frameworks!

def pods_ui
    pod 'PureLayout'
    pod 'MBProgressHUD'
end

def pods_ml
    pod 'ApiAI'
    pod 'ApiAI/Core'
    pod 'ApiAI/VoiceRequest'
    pod 'ApiAI/UIKit'
    pod 'ApiAI/ResponseMapping'
end

def pods_networking
    pod 'AFNetworking', '1.1.0'
    pod 'Reachability', '~> 3.1.0'
end


target 'PrototypeBase' do
    pods_ui
    pods_ml
end

target 'PrototypeBaseTests' do

end

target 'PrototypeBaseUITests' do

end