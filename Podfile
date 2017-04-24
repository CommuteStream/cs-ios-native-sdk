# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'
use_frameworks!

target 'CSNative' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks

  # Pods for CSNative
  pod 'Protobuf', '~> 3.2.1'

  target 'CSNativeTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'OHHTTPStubs', '~> 5.2'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.new_shell_script_build_phase.shell_script = "mkdir -p $PODS_CONFIGURATION_BUILD_DIR/#{target.name}"
    target.build_configurations.each do |config|
      config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
    end
  end
end
