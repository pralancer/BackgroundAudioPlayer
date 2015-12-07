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

#import "ViewController.h"
#import "BackgroundAudioPlayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [BackgroundAudioPlayer sharedInstance].fadeInInterval = 3;
    [BackgroundAudioPlayer sharedInstance].fadeOutInterval = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)play1:(UIButton *)sender
{
    [[BackgroundAudioPlayer sharedInstance] setAudioNamed:@"1.mp3"];
}

-(IBAction)play2:(UIButton *)sender
{
    [[BackgroundAudioPlayer sharedInstance] setAudioNamed:@"2.mp3"];
}


@end
