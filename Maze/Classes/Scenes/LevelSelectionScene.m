//
//  LevelSelectionScene.m
//  Maze
//
//  Created by Ali Imran on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectionScene.h"
#import "MazeSounds.h"
#import "GameManager.h"
#import "GameSettings.h"
#import "Constant.h"

@implementation LevelSelectionScene

@synthesize easy, medium, hard, mainMenu, headerLayer;


- (id) init
{
    if ((self = [super init])) {
        
        int x = 80;
        
        headerLayer = [[HeaderLayer alloc] initWithHeading:@"h_selectLevel"];
        [self addChild:headerLayer z:0];
        
        self.easy = [CCMenuItemImage itemFromNormalImage:@"btn_easy_unpress.png" selectedImage:@"btn_easy_press.png" target:self selector:@selector(easyLevel:)];
        [easy setPosition:CGPointMake(768/2, 650 + x)];
        
        self.medium = [CCMenuItemImage itemFromNormalImage:@"btn_medium_unpress.png" selectedImage:@"btn_medium_press.png" target:self selector:@selector(mediumLevel:)];
        [medium setPosition:CGPointMake(768/2, 550 + x)];
        
        self.hard = [CCMenuItemImage itemFromNormalImage:@"btn_hard_unpress.png" selectedImage:@"btn_hard_press.png" target:self selector:@selector(hardLevel:)];
        [hard setPosition:CGPointMake(768/2, 450 + x)];
        
        self.mainMenu = [CCMenuItemImage itemFromNormalImage:@"btn_mainmenu_unpress.png" selectedImage:@"btn_mainmenu_press.png"
												 target:self selector:@selector(mainMenu:)];
        [mainMenu setPosition:CGPointMake(CONST_MAINMENU_POSITION_X, CONST_MAINMENU_POSITION_Y)];
        
        CCMenu *menu = [CCMenu menuWithItems:easy, medium, hard, mainMenu, nil];
        [menu setPosition:CGPointMake(0, 0)];
        [self addChild:menu];
        
    }
    return self;
}



- (void) easyLevel: (id) sender
{
    [MazeSounds playButtonTap];
    
    
    [GameManager sharedGameManager].difficultyLevel = @"Easy";
    
    if ([GameManager sharedGameManager].isMuliplayerGame) {
        
        [GameManager sharedGameManager].gameCenter.multiplayerManager.gameLevel = @"easy";
        
        [[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager createLevel:@"easy"];
        [[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager runBacktrackAlgorithm];
        //[self getSize];
        [[GameManager sharedGameManager] modeSelectionScene:CONST_GAME_LEVEL_EASY];
        
        [GameManager sharedGameManager].localWifiManager.sessionID = @"easy";
        
    } else {
        //[[GameManager sharedGameManager] gamePlayScene:@"easy"];
        [[GameManager sharedGameManager] selectThemeScene:@"easy"];
    }
    
}


- (void) mediumLevel: (id) sender
{
    [MazeSounds playButtonTap];
    
    [GameManager sharedGameManager].difficultyLevel = @"Medium";
    
    if ([GameManager sharedGameManager].isMuliplayerGame) {
        
        [GameManager sharedGameManager].gameCenter.multiplayerManager.gameLevel = @"medium";
        
        [[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager createLevel:@"medium"];
        [[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager runBacktrackAlgorithm];
        //[self getSize];
        [[GameManager sharedGameManager] modeSelectionScene:CONST_GAME_LEVEL_MEDIUM];
        [GameManager sharedGameManager].localWifiManager.sessionID = @"medium";
        
    } else {
        [[GameManager sharedGameManager] selectThemeScene:@"medium"];
    }
    
}


- (void) hardLevel: (id) sender
{
    [MazeSounds playButtonTap];
    
    [GameManager sharedGameManager].difficultyLevel = @"Hard";
    
    if ([GameManager sharedGameManager].isMuliplayerGame) {
        
        [[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager createLevel:@"hard"];
        [[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager runBacktrackAlgorithm];
        
        [GameManager sharedGameManager].gameCenter.multiplayerManager.gameLevel = @"hard";
        //[self getSize];
        [[GameManager sharedGameManager] modeSelectionScene:CONST_GAME_LEVEL_HARD];
        [GameManager sharedGameManager].localWifiManager.sessionID = @"hard";
        
    } else {
        [[GameManager sharedGameManager] selectThemeScene:@"hard"];
    }
    
}


- (void) generateGameStartTime
{
    NSTimeInterval date = [NSDate timeIntervalSinceReferenceDate];
	long val = date;
	int gameStartTime = val % 50000;
    
    [GameManager sharedGameManager].gameCenter.multiplayerManager.localPlayerSelectionTime = gameStartTime;
    
}


- (void) mainMenu:(id) sender
{   
	[MazeSounds playButtonTap];
	[[GameManager sharedGameManager] mainMenuScene];
}



- (void) getSize
{
    //int size = [[[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager cells] count];
    
    /*
    
    for (int i = size-1; i >= 455; i--) {
        [[[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager cells] removeObjectAtIndex:i];
    }
    
    size = [[[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager cells] count];
    */
    //NSLog(@"size = %d", size);
}


- (void) dealloc
{
    //NSLog(@"~ dealloc - LevelSelectionScene ~");
    //[self removeAllChildrenWithCleanup:YES];
    [headerLayer release];
    
    [easy release];
    [medium release];
    [hard release];
    [mainMenu release];
    
    [super dealloc];
}



@end
