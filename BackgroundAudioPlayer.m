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

#import "BackgroundAudioPlayer.h"

const double kDefaultFadeInInterval = 3.0; //3 seconds
const double kDefaultFadeOutInterval = 3.0; //3 seconds
const double kDefaultVolumeStepInterval = 0.05;

@interface BackgroundAudioPlayer()
-(void)fadeOut;
-(void)fadeIn;

@property (nonatomic, retain) NSOperationQueue *faderQueue;

@end

#pragma mark External interface

@implementation BackgroundAudioPlayer

+(instancetype) sharedInstance
{
    static BackgroundAudioPlayer *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[BackgroundAudioPlayer alloc] init];
        player.faderQueue = [[NSOperationQueue alloc] init];
        player.fadeInInterval = kDefaultFadeInInterval;
        player.fadeOutInterval = kDefaultFadeOutInterval;
        player.volumeStepper = kDefaultVolumeStepInterval;
    });
    return player;
}

-(void)setAudioNamed:(NSString *)name
{
    NSString *audioPath = [[NSBundle mainBundle]pathForResource:[name stringByDeletingPathExtension] ofType:[name pathExtension]];
    [self setAudioPath:audioPath];
}

-(void)setAudioPath:(nullable NSString *)path
{
    BOOL hadAudioBefore = _currentAudioFilePath != nil;
    _currentAudioFilePath = path;
    
    if (!hadAudioBefore)
    {
        [self createNewPlayer];
    }
    else
    {
        [self fadeOut]; //fade out the current player
        [self createNewPlayer]; //create the new player
    }
}

-(nullable NSString *)audioFile
{
    return [_currentAudioFilePath lastPathComponent];
}

#pragma mark -
#pragma mark Internal functions

-(void)createNewPlayer
{
    if (self.currentAudioFilePath != nil)
    {
        _currentPlayer = [[BackgroundAVPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.currentAudioFilePath] error:nil];
        _currentPlayer.volume = 0.0; //initially set the volume to zero so that we can do the fadeIn effect if required
        [_currentPlayer prepareToPlay];
        _currentPlayer.numberOfLoops = _looping ? -1 : 0;
        [_currentPlayer play];
        [self fadeIn]; //fade in the new player
    }
    else
    {
        _currentPlayer = nil; //no audio to play then release the player
    }
}

-(void)fadeIn
{
    //if the fade in interval is 0 then it means immediately play the sound with full volume.
    if (_fadeInInterval == 0) {
        _currentPlayer.volume = 1.0;
        return;
    }
    
    //otherwise gradually increase the volume by stepping up the volume at intervals
    NSBlockOperation *fadeIn = [NSBlockOperation blockOperationWithBlock:^ {
        while (_currentPlayer != nil && _currentPlayer.volume <= 1.0)
        {
            usleep(_fadeInInterval * USEC_PER_SEC * _volumeStepper);
            _currentPlayer.volume += _volumeStepper; //reduce the volume
        }
    }];
    
    [_faderQueue addOperation:fadeIn];
}

-(void)fadeOut
{
    _fadeOutPlayer = _currentPlayer;

    //if the fade in interval is 0 then it means immediately play the sound with full volume.
    if (_fadeOutInterval == 0) {
        _fadeOutPlayer.volume = 0.0;
        _fadeOutPlayer = nil; //release the fading out player at the end after the volume is zeroed since dont need it anymore
        return;
    }

    //otherwise slowly fade out the current player volume and once it reaches 0 create the new player and start playing the new sound
    NSBlockOperation *fadeOut = [NSBlockOperation blockOperationWithBlock:^ {
        while (_fadeOutPlayer != nil && _fadeOutPlayer.volume > 0.0)
        {
            usleep(_fadeOutInterval * USEC_PER_SEC * _volumeStepper); //100 ms delay to get the fade effect
            _fadeOutPlayer.volume -= _volumeStepper; //reduce the volume
        }
        _fadeOutPlayer = nil;
    }];

    [_faderQueue addOperation:fadeOut];
}

#pragma mark AVAudioPlayerDelegate

/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"audioPlayerDidFinishPlaying successfully:%@", flag ? @"Yes" : @"no");
}


@end

@implementation BackgroundAVPlayer

-(void)dealloc
{
    NSLog(@"Deallocating BackgroundAVPlayer");
}

@end
