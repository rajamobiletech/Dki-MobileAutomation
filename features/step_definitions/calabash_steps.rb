require 'calabash-android/calabash_steps'
if ENV['DEVICE_ENDPOINT']
  STEP_PAUSE= 1.0
else if ENV['ANDROID_HOME']
  STEP_PAUSE= 5
else
      STEP_PAUSE=0.5
end
end

if ENV['STEP_PAUSE']
  STEP_PAUSE = ENV['STEP_PAUSE'].to_f
end
