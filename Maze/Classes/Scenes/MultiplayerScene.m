//
//  MultiplayerScene.m
//  Maze
//
//  Created by Ali Imran on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MultiplayerScene.h"
#import "MazeSounds.h"
#import "GameManager.h"
#import "Constant.h"

@implementation MultiplayerScene


@synthesize headerLayer, gamecenter, localArea, mainMenu, gameType, back;



- (id) initWithGameType: (int) gameType1
{
    self = [super init];
    
    if (self != nil) {
        
        self.gameType = gameType1;
        
        headerLayer = [[HeaderLayer alloc] initWithHeading:@"h_multiplayer"];
        [self addChild:headerLayer];
        
        
        CCSprite *background = [CCSprite spriteWithFile:@"bg_localScore.png"];
        [background setPosition:CGPointMake(768/2, 1024/2 + 10)];
        [self addChild:background];
        
        
        self.localArea = [CCMenuItemImage itemFromNormalImage:@"localareaNetwork.png" selectedImage:@"localareaNetwork.png"
													   target:self
													 selector:@selector(localAreaPressed:)];
		
		
		self.gamecenter = [CCMenuItemImage itemFromNormalImage:@"gameCenter.png" selectedImage:@"gameCenter.png"
														target:self
													  selector:@selector(gameCenterPressed:)];
		
		self.mainMenu = [CCMenuItemImage itemFromNormalImage:@"btn_mainmenu_unpress.png" selectedImage:@"btn_mainmenu_press.png"
													  target:self
													selector:@selector(mainMenuPressed:)];
		
		self.back = [CCMenuItemImage itemFromNormalImage:@"btn_back_unpress.png" selectedImage:@"btn_back_press.png" target:self selector:@selector(backPressed:)];
        
        [self setPositions];
		
    
		CCMenu *menu = [CCMenu menuWithItems:gamecenter, localArea, mainMenu, back, nil];
		[menu setPosition:CGPointMake(0, 0)];
		[self addChild:menu];
        
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:CONST_MULTIPLAYER_TEXT dimensions:CGSizeMake(650, 200) alignment:UITextAlignmentLeft fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE+6];
		
		[self addChild:label z:100];
		[label setPosition:CGPointMake(387, 300)];
		[label setColor:ccc3(89, 23, 0)];
        
        
        
    }
    return self;
}



- (void) setPositions
{
	[localArea setPosition:CGPointMake(768/2 + 170, 1024 - 460)];
	[gamecenter setPosition:CGPointMake(768/2 - 170, 1024 - 460)];
	[mainMenu setPosition:CGPointMake(CONST_MAINMENU_POSITION_X + 10, CONST_MAINMENU_POSITION_Y)];
    [back setPosition:CGPointMake(100, CONST_MAINMENU_POSITION_Y)];
}



- (void) gameCenterPressed: (id) sender
{
    [MazeSounds playButtonTap];
    
    if([Utility getSystemVersionAsAnInteger]>= __IPHONE_4_1)
	{
    
        [[GameManager sharedGameManager].gameCenter launchAutoMatchingWithLevelType:gameType];
    }
    else {
        //[Utility showAlertViewWithTitle:<#(NSString *)#> andMessage:<#(NSString *)#>]
		[Utility showAlertViewWithTitle:CONST_IOS_VERSION_ERROR_TITLE andMessage:CONST_IOS_VERSION_ERROR_TEXT];
	}

    
}


- (void) generateGameStartTime
{
    NSTimeInterval date = [NSDate timeIntervalSinceReferenceDate];
    long val = date;
    int gameStartTime = val % 50000;
    
    [GameManager sharedGameManager].gameCenter.multiplayerManager.localPlayerSelectionTime = gameStartTime;
    
}

- (void) localAreaPressed: (id) sender
{
    [MazeSounds playButtonTap];
    
    //[GameManager sharedGameManager].gameCenter.multiplayerManager.multiplayerGameType = CONST_MULTIPLAYER_GAME_TYPE_LOCALWIFI;
    [[GameManager sharedGameManager].localWifiManager startPicker];
}


- (void) mainMenuPressed: (id) sender
{
    [MazeSounds playButtonTap];
    [[[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager cells] removeAllObjects];
    [[GameManager sharedGameManager] mainMenuScene];
}



- (void) backPressed: (id) sender
{
    [MazeSounds playButtonTap];
    
    if ([[GameManager sharedGameManager].gameCenter.multiplayerManager.gameLevel isEqualToString:@"easy"]) {
        
        [GameManager sharedGameManager].localWifiManager.sessionID = @"easy";
        [[GameManager sharedGameManager] modeSelectionScene:CONST_GAME_LEVEL_EASY];
        
    } else if ([[GameManager sharedGameManager].gameCenter.multiplayerManager.gameLevel isEqualToString:@"medium"]) {
        
        [GameManager sharedGameManager].localWifiManager.sessionID = @"mudium";
        [[GameManager sharedGameManager] modeSelectionScene:CONST_GAME_LEVEL_MEDIUM];
        
    } else {
        
        [GameManager sharedGameManager].localWifiManager.sessionID = @"hard";
        [[GameManager sharedGameManager] modeSelectionScene:CONST_GAME_LEVEL_HARD];
        
    }
    
    
}


- (void) dealloc {
    NSLog(@"~ dealloc - MultiplayerScene ~");
    [headerLayer release];
    
    [localArea release];
    [gamecenter release];
    [mainMenu release];
    [back release];
    [super dealloc];
}

@end
