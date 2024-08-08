//
//  ModeSelectionScene.m
//  Maze
//
//  Created by Ali Imran on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ModeSelectionScene.h"
#import "MazeSounds.h"
#import "GameManager.h"


@implementation ModeSelectionScene

@synthesize headerLayer, accelerometer, drag, background, mainMenu, accelerometerLabel, dragLabel, gameLevel, back;


- (id) initWithGameLevel: (int) gameLevel1 {
    self = [super init];
    if (self) {
        
        self.gameLevel = gameLevel1;
        
        headerLayer = [[HeaderLayer alloc] initWithHeading:@"h_control"];
        [self addChild:headerLayer];
        
        self.background = [CCSprite spriteWithFile:@"bg_localScore.png"];
        [self addChild:background];
        
        self.accelerometerLabel = [CCSprite spriteWithFile:@"label_accelerometer.png"];
        [self addChild:accelerometerLabel];
        
        self.dragLabel = [CCSprite spriteWithFile:@"label_manual.png"];
        [self addChild:dragLabel];
        
        self.accelerometer = [CCMenuItemImage itemFromNormalImage:@"accelerometer_off.png" selectedImage:@"accelerometer_on.png" target:self selector:@selector(selectGameType:)];
        accelerometer.tag = 1;
		
        self.drag = [CCMenuItemImage itemFromNormalImage:@"manual_off.png" selectedImage:@"manual_on.png" target:self selector:@selector(selectGameType:)];
        drag.tag = 4;
        
        self.mainMenu = [CCMenuItemImage itemFromNormalImage:@"btn_mainmenu_unpress.png" selectedImage:@"btn_mainmenu_press.png" target:self selector:@selector(mainMenuPressed:)];
        
        self.back = [CCMenuItemImage itemFromNormalImage:@"btn_back_unpress.png" selectedImage:@"btn_back_press.png" target:self selector:@selector(backPressed:)];
        
        
		CCMenu *menu =[CCMenu menuWithItems:accelerometer, drag, mainMenu, back, nil];
		[menu setPosition:CGPointMake(0, 0)];
		[self addChild:menu];
		
		[self setComponentPositions];
        
    }
    return self;
}


- (void) setComponentPositions
{
    [background setPosition:CGPointMake(768/2, 1024/2 + 10)];
    
    [accelerometer setPosition:CGPointMake(768/2 - 150, 1024 - 510)];
	[drag setPosition:CGPointMake(768/2 + 150, 1024 - 510)];
    
    [accelerometerLabel setPosition:CGPointMake(768/2 - 150, 1024 - 600)];
    
    [dragLabel setPosition:CGPointMake(768/2 + 150, 1024 - 600)];
    
    [mainMenu setPosition:CGPointMake(CONST_MAINMENU_POSITION_X + 10, CONST_MAINMENU_POSITION_Y)];
    
    [back setPosition:CGPointMake(100, CONST_MAINMENU_POSITION_Y)];
}




- (void) selectGameType: (id) sender
{
    [MazeSounds playButtonTap];
    
    CCMenuItemImage *mf = (CCMenuItemImage *) sender;
    
    [[GameManager sharedGameManager] multiplayerScene:mf.tag * gameLevel];
    
    if (mf.tag == 1) {
        [GameManager sharedGameManager].localWifiManager.sessionID = [NSString stringWithFormat:@"acc_%@", [GameManager sharedGameManager].localWifiManager.sessionID];
        [GameManager sharedGameManager].multiplayerGameMode = CONST_MULTIPLAYER_GAME_MODE_ACCELEROMETER;
        [GameManager sharedGameManager].gameCenter.multiplayerManager.gameMode = @"acc";
    } else if (mf.tag == 4) {
        [GameManager sharedGameManager].localWifiManager.sessionID = [NSString stringWithFormat:@"drag_%@", [GameManager sharedGameManager].localWifiManager.sessionID];
        [GameManager sharedGameManager].multiplayerGameMode = CONST_MULTIPLAYER_GAME_MODE_DRAG;
        [GameManager sharedGameManager].gameCenter.multiplayerManager.gameMode = @"drag";

    }
    
}



- (void) backPressed: (id) sender
{
    [MazeSounds playButtonTap];
    [[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager.cells removeAllObjects];
    [[GameManager sharedGameManager] levelSelectionScene];
}



- (void) mainMenuPressed: (id) sender
{
    [MazeSounds playButtonTap];
    
    [[[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager cells] removeAllObjects];
    
    [[GameManager sharedGameManager] mainMenuScene];
}


- (void) dealloc {
    
    NSLog(@"~ dealloc - ModeSelectionScene ~");
    
    [headerLayer release];
    [background release];
    
    [accelerometerLabel release];
    [accelerometer release];
    
    [dragLabel release];
    [drag release];
    
    [mainMenu release];
    [back release];
    
    [super dealloc];
    
}


@end
