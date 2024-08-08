//
//  GamePlayScene.m
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GamePlayScene.h"
#import "MazeSounds.h"
#import "GameManager.h"
#import "HighScore.h"
#import "GameSettings.h"
#import "SimpleAudioEngine.h"


@implementation GamePlayScene

@synthesize gameLayer, pauseButton, level, background, timerBackground, winLayer, menuLayer, quitLayer;

- (id) initWithLevel: (NSString *) level1
{
    if ((self = [super init])) {
		
        if ([GameManager sharedGameManager].isMuliplayerGame) {
            self.background = [CCSprite spriteWithFile:@"theme0.png"];
        } else {
            self.background = [CCSprite spriteWithFile:[NSString stringWithFormat:@"theme%d.png", [GameSettings sharedGameSettings].themeNo]];
        }
        
        
        [background setPosition:CGPointMake(768/2, 1024/2)];
        [self addChild:background];
        
		self.timerBackground = [CCSprite spriteWithFile:@"bg_timer.png"];
        [timerBackground setPosition:CGPointMake(117, 30)];
        [self addChild:timerBackground];
        
        GameLayer *tempLayer=[[GameLayer alloc] initWithLevel:level1];
		self.gameLayer=tempLayer;
		[tempLayer release];
        
        self.gameLayer.winDelegate = self;
        
		[self addChild:gameLayer];
		
        self.level = level1;
        
        self.pauseButton = [CCMenuItemImage itemFromNormalImage:@"btn_pause_unpress.png" selectedImage:@"btn_pause_press.png" target:self selector:@selector(pausePressed:)];
        [pauseButton setPosition:CGPointMake(768 - 96, 30)];
        
        CCMenu *menu = [CCMenu menuWithItems:pauseButton, nil];
        [menu setPosition:CGPointMake(0, 0)];
        [self addChild:menu];
        
        if ([GameManager sharedGameManager].gameCenterSelected || [GameManager sharedGameManager].localWifiSelected) {
			[GameManager sharedGameManager].gameCenter.multiplayerManager.gamePlayDelegate = self;
		}
        
        QuitGameLayer *tempQuitLayer = [[QuitGameLayer alloc] init];
        self.quitLayer = tempQuitLayer;
        [tempQuitLayer release];
        
        /*
        WinLayer *tempWinLayer = [[WinLayer alloc] init];
        self.winLayer = tempWinLayer;
        [tempWinLayer release];
        */
        
    }
    return self;
}


- (void) pausePressed: (id) sender
{
    [MazeSounds playButtonTap];
    [MazeSounds pauseBackGroundSound];
    
    [[CCDirector sharedDirector] pause];
    
    [GameManager sharedGameManager].isGamePaused = YES;
    
    if ([GameManager sharedGameManager].gameCenterSelected || [GameManager sharedGameManager].localWifiSelected) {
        
        self.pauseButton.visible = NO;
        [self addQuitGameLayer];
        
    } else {
        
        self.gameLayer.menuDelegate = self;
        [self addMenuLayer];
        
    }
    
}


#pragma mark AlertView Delegate Methods


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1) {
        self.gameLayer.winDelegate = nil;
		[menuLayer.delegate removeMenuLayer:0];
        [[CCDirector sharedDirector] resume];
        [GameManager sharedGameManager].isGamePaused = NO;
        
        [GameManager sharedGameManager].gameCenter.multiplayerManager.gamePlayDelegate = nil;
        [[GameManager sharedGameManager].gameCenter.multiplayerManager leaveMatch];
        
        [MazeSounds playBackGroundSound];
        SimpleAudioEngine *engine = [SimpleAudioEngine sharedEngine];
        [engine setBackgroundMusicVolume:1.0];
        
        [[GameManager sharedGameManager] mainMenuScene];
		
	}
}


#pragma mark WinLayerProtocol Methods


- (void) addWinLayer:(int) seconds
{
    [MazeSounds playWiningSound];
    
    WinLayer *layer = [[WinLayer alloc] initWithTime:seconds];
    self.winLayer = layer;
    [layer release];
    
    
    //[self.winLayer initWithTime:seconds];
    self.winLayer.delegate = self;
    [self addChild:winLayer z:2];
    
    [self.winLayer addTextBox:[GameSettings sharedGameSettings].playerName];
    
    self.gameLayer.isTouchEnabled = NO;
    self.winLayer.isTouchEnabled = YES;
    //pauseButton.visible = NO;
    [pauseButton setIsEnabled:NO];
}



- (void) addLostLayer
{
    gameLayer.isAccelerometerEnabled = NO;
    gameLayer.remoteBall.visible = NO;
    
    //[MazeSounds playBallPuttSound];
    [gameLayer playerWinAnimationWithSprite:[NSString stringWithFormat:@"%@_ball_remote.png", gameLayer.level]];
    
    
    WinLayer *layer = [[WinLayer alloc] initLostLayer];
    self.winLayer = layer;
    [layer release];
    
    //[self.winLayer initLostLayer];
    self.winLayer.delegate = self;
    [self addChild:winLayer z:2];

    self.gameLayer.isTouchEnabled = NO;
    self.winLayer.isTouchEnabled = YES;
    //pauseButton.visible = NO;
    [pauseButton setIsEnabled:NO];

}

- (void) addTiedLayer
{
    gameLayer.isAccelerometerEnabled = NO;
    
    //gameLayer.ball.visible = NO;
    
    gameLayer.remoteBall.visible = NO;
    
    //[MazeSounds playBallPuttSound];
    //[gameLayer playerWinAnimationWithSprite:[NSString stringWithFormat:@"%@_ball.png", gameLayer.level]];
    [gameLayer playerWinAnimationWithSprite:[NSString stringWithFormat:@"%@_ball_remote.png", gameLayer.level]];
    
    
    WinLayer *layer = [[WinLayer alloc] initTiedLayer];
    self.winLayer = layer;
    [layer release];
    
    //[self.winLayer initTiedLayer];
    self.winLayer.delegate = self;
    [self addChild:winLayer z:2];
    
    self.gameLayer.isTouchEnabled = NO;
    self.winLayer.isTouchEnabled = YES;
    //pauseButton.visible = NO;
    [pauseButton setIsEnabled:NO];
}

- (void) removeWinLayer
{	
    
    NSLog(@"remove Win Layer");
	
    //self.winLayer.nameTextField.delegate = nil;
	self.winLayer.delegate = nil;
    self.gameLayer.winDelegate = nil;
    self.gameLayer.menuDelegate = nil;
    [winLayer.nameTextField removeFromSuperview];
	[self removeChild:self.winLayer cleanup:YES];
    
    if ([GameManager sharedGameManager].gameCenterSelected || [GameManager sharedGameManager].localWifiSelected) {
        [GameManager sharedGameManager].gameCenter.multiplayerManager.gamePlayDelegate = nil;
        [[GameManager sharedGameManager].gameCenter.multiplayerManager leaveMatch];
    }
    
	[[GameManager sharedGameManager] mainMenuScene];
}


- (void) saveName: (NSString*) name
{
    HighScore *score = [[HighScore alloc] initwithName:name Time:self.gameLayer.timeLeft];
    
    BOOL isAccelerometerSelected = [GameSettings sharedGameSettings].accelerometerStatus;
    BOOL isDragSelected = [GameSettings sharedGameSettings].manualStatus;
    
    if (isAccelerometerSelected && [level isEqualToString:@"easy"]) {
        [[GameManager sharedGameManager].highScoreManager.easyAccelerometer addObject:score];
    } else if (isAccelerometerSelected && [level isEqualToString:@"medium"]) {
        [[GameManager sharedGameManager].highScoreManager.mediumAccelerometer addObject:score];
    } else if (isAccelerometerSelected && [level isEqualToString:@"hard"]) {
        [[GameManager sharedGameManager].highScoreManager.hardAccelerometer addObject:score];
    } else if (isDragSelected && [level isEqualToString:@"easy"]) {
        [[GameManager sharedGameManager].highScoreManager.easyDrag addObject:score];
        
    } else if (isDragSelected && [level isEqualToString:@"medium"]) {
        [[GameManager sharedGameManager].highScoreManager.mediumDrag addObject:score];
    } else if (isDragSelected && [level isEqualToString:@"hard"]) {
        [[GameManager sharedGameManager].highScoreManager.hardDrag addObject:score];
    }
    
    
    [[GameManager sharedGameManager].highScoreManager saveAllScores];
    
}



#pragma mark MenuLayerProtocol Methods

- (void) addMenuLayer
{
    MenuLayer *layer = [[MenuLayer alloc] init];
    self.menuLayer = layer;
    [layer release];
    
    self.menuLayer.gameType = self.level;
    
    self.menuLayer.delegate = self;
    [self addChild:menuLayer z:2];
    
    self.menuLayer.isTouchEnabled = YES;
    //pauseButton.visible = NO;
    //self.gameLayer.isTouchEnabled = NO;
    
    
    [pauseButton setIsEnabled:NO];
}


- (void) removeMenuLayer:(int) tag;
{
    
    if (tag == 3) {
        [[CCScheduler sharedScheduler] unscheduleAllSelectorsForTarget:gameLayer];
    }
    
    [pauseButton setIsEnabled:YES];
    pauseButton.visible = YES;
    self.menuLayer.delegate = nil;
    
    if (tag != 1) {
        self.gameLayer.winDelegate = nil;
    }
    
    self.gameLayer.menuDelegate = nil;
    [self removeChild:self.menuLayer cleanup:YES];
    
}


#pragma mark GamePlayProtocol Method


- (void) updateRemotePlayerPositionX: (float) posX andPositionY:(float) posY
{
    [gameLayer.remoteBall setPosition:CGPointMake(posX, posY)];
}

- (void) addMatchWinLayer: (int) time
{
    [gameLayer.winDelegate addWinLayer:time];
}

- (void) addMatchLostLayer
{
    [gameLayer.winDelegate addLostLayer];
}

- (void) addMatchTiedLayer
{
    [gameLayer.winDelegate addTiedLayer];
}


- (void) otherPlayerLeft
{
    menuLayer.delegate = nil;
    winLayer.delegate = nil;
    gameLayer.winDelegate = nil;
    [GameManager sharedGameManager].gameCenter.multiplayerManager.gamePlayDelegate = nil;
    [[GameManager sharedGameManager].gameCenter.multiplayerManager leaveMatch];
    
}



#pragma mark QuitGameLayerProtocol delegate methods

- (void) addQuitGameLayer
{
    self.quitLayer.delegate = self;
    [self addChild:quitLayer z:999];
    [pauseButton setIsEnabled:NO];
}

- (void) removeGameQuitLayer: (int) tag
{
    
    if (tag == 1) {
        
        self.gameLayer.winDelegate = nil;
		[menuLayer.delegate removeMenuLayer:0];
        [[CCDirector sharedDirector] resume];
        [GameManager sharedGameManager].isGamePaused = NO;
        
        [GameManager sharedGameManager].gameCenter.multiplayerManager.gamePlayDelegate = nil;
        [[GameManager sharedGameManager].gameCenter.multiplayerManager leaveMatch];
        
        [[GameManager sharedGameManager] mainMenuScene];
    } else {
        //self.pauseButton.visible = YES;
        [pauseButton setIsEnabled:YES];
    }
    
    self.quitLayer.delegate = nil;
    [self removeChild:quitLayer cleanup:YES];
}


- (void) dealloc
{
    NSLog(@"~ dealloc - GamePlayScene ~");
    
    [pauseButton release];
    [timerBackground release];
    [background release];
    [level release];
    [gameLayer release];
    [winLayer release];
    [menuLayer release];
    [quitLayer release];
    [super dealloc];
}

@end
