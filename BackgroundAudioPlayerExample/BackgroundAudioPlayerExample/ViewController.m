//
//  ViewController.m
//  BackgroundAudioPlayerExample
//
//  Created by Pradeep Udupi on 04/12/15.
//  Copyright © 2015 Pralancer. All rights reserved.
//

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
