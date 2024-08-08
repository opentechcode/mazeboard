//
//  MazeSounds.m
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MazeSounds.h"
#import "SimpleAudioEngine.h"
#import "GameSettings.h"
#import "CocosDenshion.h"

@implementation MazeSounds

+(void)preLoadSounds
{	
    
	SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];

	[engine preloadBackgroundMusic:@"background_music.mp3"];
	[engine preloadEffect:@"click2.caf"];
	
    [engine preloadEffect:@"bounce.wav"];
    [engine preloadBackgroundMusic:@"rolling.wav"];
    [engine preloadEffect:@"ball_putt.wav"];
    [engine preloadEffect:@"clapSound.mp3"];
}


+(void)playBackGroundSound
{	
	if([GameSettings sharedGameSettings].ambientSoundStatus) {
        
		SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
        //[engine setBackgroundMusicVolume:1.0];
		[engine playBackgroundMusic:@"background_music.mp3"];
        
        [engine setBackgroundMusicVolume:1.0];
        
    }
    
}


+(void)stopBackGroundSound
{
	SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
	[engine stopBackgroundMusic];
}



+(void)pauseBackGroundSound
{
    SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
    [engine pauseBackgroundMusic];
}


+(void) playButtonTap
{
	if([GameSettings sharedGameSettings].soundEffectsStatus) {
		SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
		[engine playEffect:@"click2.caf"];
		
	}
}



+(void) playCollisionSound:(float) volume
{
	if([GameSettings sharedGameSettings].soundEffectsStatus) {
        
		SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
		[engine setEffectsVolume:volume];
        [engine playEffect:@"bounce.wav"];
        
	}
}


+(void) playBallRollingSound
{
	if([GameSettings sharedGameSettings].soundEffectsStatus) {
		
        SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
        [engine playBackgroundMusic:@"rolling.wav"];
        
	}
}


+(void)playBallPuttSound
{
    if ([GameSettings sharedGameSettings].soundEffectsStatus) {
        
        SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
        [engine playEffect:@"ball_putt.wav"];
        
    }
}


+ (void) playWiningSound
{
	if([GameSettings sharedGameSettings].soundEffectsStatus) {

		SimpleAudioEngine *engine=[SimpleAudioEngine sharedEngine];
		[engine playEffect:@"clapSound.mp3"];
        
		
	}
}


@end
