//
//  MenuLayer.m
//  Maze
//
//  Created by Ali Imran on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "GameManager.h"
#import "MazeSounds.h"
#import "SimpleAudioEngine.h"
@implementation MenuLayer

@synthesize delegate, gameType;


- (id) init
{
    self = [super init];
    if (self != nil) {
        
        CCSprite *background = [CCSprite spriteWithFile:@"menuScreen.png"];
        [background setPosition:CGPointMake(768/2, 1024/2)];
        [self addChild:background];
        
        
        CCMenuItemImage *btnContinue = [CCMenuItemImage itemFromNormalImage:@"btn_continue_unpress.png" selectedImage:@"btn_continue_press.png"
                                                                  target:self selector:@selector(continuePressed:)];
        [btnContinue setPosition:CGPointMake(768/2, 1024/2 + 80)];
        
        CCMenuItemImage *newMaze = [CCMenuItemImage itemFromNormalImage:@"btn_newMaze_unpress.png" selectedImage:@"btn_newMaze_press.png"
                                                                     target:self selector:@selector(newMazePressed:)];
        [newMaze setPosition:CGPointMake(768/2, 1024/2)];
        
        CCMenuItemImage *quitGame = [CCMenuItemImage itemFromNormalImage:@"btn_quitGame_unpress.png" selectedImage:@"btn_quitGame_press.png"
                                                               target:self selector:@selector(quitGamePressed:)]; 
        [quitGame setPosition:CGPointMake(768/2, 1024/2 - 80)];
        
        CCMenu *menu = [CCMenu menuWithItems:btnContinue, newMaze, quitGame, nil];
        [menu setPosition:CGPointMake(0, 0)];
        [self addChild:menu z:3];
        
        
        NSString *string = [[NSString alloc] init];
        self.gameType = string;
        [string release];
        
        
    }
    
    return self;
}



- (void) continuePressed: (id) sender
{
    [MazeSounds playButtonTap];
    [delegate removeMenuLayer:1];
    [[CCDirector sharedDirector] resume];
    [GameManager sharedGameManager].isGamePaused = NO;
    
    [MazeSounds playBallRollingSound];
    
}



- (void) newMazePressed:(id) sender
{
    [MazeSounds playButtonTap];
    [delegate removeMenuLayer:0];
    
    [[GameManager sharedGameManager] gamePlayScene:gameType];
    [[CCDirector sharedDirector] resume];
    [GameManager sharedGameManager].isGamePaused = NO;

}


- (void) quitGamePressed:(id) sender
{
    
    [MazeSounds playButtonTap];
	[delegate removeMenuLayer:3];
    [[GameManager sharedGameManager] removeAd];
    
    [GameManager sharedGameManager].isGamePaused = NO;
    [[CCDirector sharedDirector] resume];
    
    //[GameManager sharedGameManager].gameCenter.multiplayerManager.gamePlayDelegate = nil;
    //[[GameManager sharedGameManager].gameCenter.multiplayerManager leaveMatch];
    
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:1.0];
    [[GameManager sharedGameManager] mainMenuScene];
    
}



-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}



- (void) dealloc
{
    NSLog(@"~ dealloc - MenuLayer ~");
    [gameType release];
    [super dealloc];
}


@end
