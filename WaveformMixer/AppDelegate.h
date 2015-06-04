//
//  AppDelegate.h
//  WaveformMixer
//
//  Created by Chris Penny on 6/3/15.
//  Copyright (c) 2015 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdAudioController.h"
#import "PdDispatcher.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic, readonly) PdAudioController *audioController;


@end
