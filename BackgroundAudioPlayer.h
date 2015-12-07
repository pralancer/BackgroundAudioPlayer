/*
 
//  BackgroundAudioPlayer.h

 Copyright 2015 Pralancer. All rights reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
*/

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackgroundAVPlayer : AVAudioPlayer

@end

@interface BackgroundAudioPlayer : NSObject

#pragma mark Methods

// Creates a shared instance of the player. Any app will require at the most one background audio player anyways.
+(nullable instancetype)sharedInstance;

// Sets the audio file name to be played. This will search for the audio file in the main bundle
-(void)setAudioNamed:(NSString *)name;

// Sets the audio file path to be played. The path should be a full path to the file
-(void)setAudioPath:(nullable NSString *)path;

// Returns the current audio file being played. Nil if nothing is being played
-(nullable NSString *)audioFile;

#pragma mark Properties

//Set the fadeout interval between currently playing and new audio file setting
@property (nonatomic, assign) double fadeOutInterval;

//Set the fade in interval between currently playing and new audio file setting
@property (nonatomic, assign) double fadeInInterval;

//defines by how much the volume should be stepped in each fade interval. Higher the value more abrupt the volume change will be, lower the value more gradual the volume change
@property (nonatomic, assign) double volumeStepper;

//Sets whether the audio should be played in looping mode. If true the sound will be looped, else it will be played just once
@property (nonatomic, assign) BOOL looping;

//Contains the current audio file path being played
@property (nonatomic, retain, nullable) NSString *currentAudioFilePath;

//AVPlayer instance used by the player for direct manipulation of the player if required
@property (nonatomic, retain, nullable) BackgroundAVPlayer *currentPlayer;

//AVPlayer instance used by the player for direct manipulation of the player if required
@property (nonatomic, retain, nullable) BackgroundAVPlayer *fadeOutPlayer;

@end

NS_ASSUME_NONNULL_END