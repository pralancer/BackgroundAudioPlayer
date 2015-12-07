# BackgroundAudioPlayer
A simple class to play audio files with fade in and fade out support for switching the audio files. The file is in objective-C. Swift version is in the works.

You use this module by creating a shared instance using the shared instance call.

`[BackgroundAudioPlayer sharedInstance]`

You set the audio file to be played using `setAudioNamed` or `setAudioPath`. 

The setAudioNamed uses the name that is set to find the resource in the app's main bundle. The name should include the file name. 

    [[BackgroundAudioPlayer sharedInstance] setAudioNamed:@"intro.mp3"]

The setAudioPath version uses the full path to the file.

The `looping` property is used to control whether the audio should be looped. Setting it to true will loop indefinitely. Setting it to false will play the video file once.

The audio file that is set can be faded in by setting a `fadeInInterval`. To play it at full volume immediately set it to 0. Otherwise set it to the number of seconds it has to fade in until it reaches the full volume. Similarly the `fadeOutInterval` can be set to fade out the current audio file being played when a new audio file is set to the instance.
