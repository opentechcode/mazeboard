//
//  MainMenuScene.m
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"
#import "Constant.h"
#import "GameManager.h"
#import "MazeSounds.h"

#import "MailComposeViewController.h"

@implementation MainMenuScene

@synthesize newGameImage, optionsImage, aboutImage, inviteFriendsImage, moreGamesImage, menu, leaderboard, selectTheme, headerLayer, localHighScoreImage, multiplayerImage, facebookImage;
@synthesize twitterIcon,twitterManager;
- (id) init
{
    if ((self = [super init])) {
        
        headerLayer = [[HeaderLayer alloc] initWithHeading:@"txt_heading_mainMenu"];
        [headerLayer.headingSprite setPosition:CGPointMake(CONST_HEADING_X, CONST_HEADING_Y - 23)];
        [self addChild:headerLayer];
        
		[self drawComponents];
		[self setComponentsPositions];
		
		self.menu = [CCMenu menuWithItems: newGameImage, leaderboard, optionsImage, aboutImage, moreGamesImage, inviteFriendsImage, localHighScoreImage, multiplayerImage, facebookImage,twitterIcon, nil];
		[self.menu setPosition:CGPointMake(0, 0)];
		[self addChild:self.menu];
        
        [MazeSounds playBackGroundSound];
        
        [GameManager sharedGameManager].localWifiSelected = NO;
        [GameManager sharedGameManager].gameCenterSelected = NO;
        [GameManager sharedGameManager].gameCenter.multiplayerManager.isGameOver = NO;
        
        [GameManager sharedGameManager].isMuliplayerGame = NO;
        [GameManager sharedGameManager].gameCenter.isInvited = NO;
        [[GameManager sharedGameManager].gameCenter.multiplayerManager.mazeManager.cells removeAllObjects];
        
		self.twitterManager=[[TwitterManager alloc] init];
        
        
    }
    return self;
}



- (void) drawComponents
{
    self.newGameImage = [CCMenuItemImage itemFromNormalImage:@"newGame_unpress.png" selectedImage:@"newGame_press.png" 
                                                 target:self selector:@selector(levelSelectionScene:)];
    
    //self.selectTheme = [CCMenuItemImage itemFromNormalImage:@"createMaze_unpress.png" selectedImage:@"createMaze_press.png" target:self selector:@selector(selectThemeScene:)];
    
    self.leaderboard = [CCMenuItemImage itemFromNormalImage:@"leaderboard_unpress.png" selectedImage:@"leaderboard_press.png" 
                                                target:self selector:@selector(showLeaderboard:)];	
    
    self.optionsImage = [CCMenuItemImage itemFromNormalImage:@"options_unpress.png" selectedImage:@"options_press.png"
                                                 target:self selector:@selector(optionScene:)];
    
    self.aboutImage = [CCMenuItemImage itemFromNormalImage:@"about_unpress.png" selectedImage:@"about_press.png"
                                               target:self selector:@selector(helpScene:)];	
    
    self.moreGamesImage = [CCMenuItemImage itemFromNormalImage:@"moreGame_unpress.png" selectedImage:@"moreGame_press.png"
                                                   target:self selector:@selector(moregamesUrl:)];
    
    self.inviteFriendsImage = [CCMenuItemImage itemFromNormalImage:@"inviteFriends_unpress.png" selectedImage:@"inviteFriends_press.png"
                                                       target:self selector:@selector(inviteYourFriends:)];
    
    self.localHighScoreImage = [CCMenuItemImage itemFromNormalImage:@"localscoreboard_unpress.png" selectedImage:@"localscoreboard_press.png" target:self selector:@selector(highScoreScene:)];
    
    self.multiplayerImage = [CCMenuItemImage itemFromNormalImage:@"multiplayer_unpress.png" selectedImage:@"multiplayer_press.png" 
                                                     target:self selector:@selector(multiplayerPressed:)];
	
    self.facebookImage = [CCMenuItemImage itemFromNormalImage:@"facebook_logo.png" selectedImage:@"facebook_logo.png" target:self selector:@selector(facebookPressed:)];
    
	self.twitterIcon = [CCMenuItemImage itemFromNormalImage:@"twitter-icon.png" selectedImage:@"twitter-icon.png" target:self selector:@selector(twitterPressed:)];

}



- (void) setComponentsPositions
{
	float x = 768/2;
	float y = 760.0;    // initially 650.0
    float yGap = 85.0f;
    
	[newGameImage setPosition:CGPointMake(x, y)];
	y = y - yGap;
    
    [multiplayerImage setPosition:CGPointMake(x, y)];
    y = y - yGap;
	
	[leaderboard setPosition:CGPointMake(x, y)];
	y = y - yGap;
    
	[optionsImage setPosition:CGPointMake(x, y)];
	y = y - yGap;
	
	[aboutImage setPosition:CGPointMake(x, y)];
	y = y - yGap;
	
	[moreGamesImage setPosition:CGPointMake(x, y)];
	y = y - yGap;
	
	[inviteFriendsImage setPosition:CGPointMake(x, y)];
    y = y - yGap;
    
    [localHighScoreImage setPosition:CGPointMake(x, y)];
    y = y - yGap;
    
    //[selectTheme setPosition:CGPointMake(x, y)];
	//y = y - yGap;
    
    [facebookImage setPosition:CGPointMake(CONST_MAINMENU_POSITION_X + 20, CONST_MAINMENU_POSITION_Y + 30)];
	[twitterIcon setPosition:CGPointMake(CONST_MAINMENU_POSITION_X + 110, CONST_MAINMENU_POSITION_Y + 30)];
    
}





- (void) levelSelectionScene:(id) sender
{
    [MazeSounds playButtonTap];
    [[GameManager sharedGameManager] levelSelectionScene];
}


- (void) selectThemeScene:(id) sender
{
    [MazeSounds playButtonTap];
    //[[GameManager sharedGameManager] selectThemeScene];
}


- (void) showLeaderboard: (id) sender
{
    [MazeSounds playButtonTap];
    [[GameManager sharedGameManager].gameCenter showViewControllerLeaderBoard];
    
}


- (void) multiplayerPressed: (id) sender
{
    [MazeSounds playButtonTap];
    [[GameManager sharedGameManager] levelSelectionScene];
    [GameManager sharedGameManager].isMuliplayerGame = YES;
        
}

-(void) inviteYourFriends:(id) sender
{
	
    [MazeSounds playButtonTap];
	[[GameManager sharedGameManager] inviteFriend];
    
}

- (void) moregamesUrl:(id) sender
{
	[MazeSounds playButtonTap];
	
	NSURL *url = [ [ NSURL alloc ] initWithString: @"http://www.envisionstudios.biz" ];
	
	[[UIApplication sharedApplication] openURL:url];
}




- (void) optionScene:(id) sender
{
	[MazeSounds playButtonTap];
	
	[[GameManager sharedGameManager] optionScene];
    
}


-(void ) helpScene:(id) sender
{
	[MazeSounds playButtonTap];
    
	[[GameManager sharedGameManager] helpScene];
}


- (void) highScoreScene: (id) sender
{
    [MazeSounds playButtonTap];
    [[GameManager sharedGameManager] highScoreScene];
}




- (void) facebookPressed: (id) sender
{
    
    [MazeSounds playButtonTap];
    
   // if (![GameManager sharedGameManager].webViewDisplayed) {
        [[GameManager sharedGameManager] displayWebView];
    //}
    
}


- (void) twitterPressed: (id) sender
{
    
    [MazeSounds playButtonTap];
	[twitterManager twitterUpdateStatus];
   // [[GameManager sharedGameManager] showTwitterPage];
	
	/*
    if (![GameManager sharedGameManager].webViewDisplayed) {
        [[GameManager sharedGameManager] displayWebView];
    }
    */
}


- (void) dealloc
{
    NSLog(@"~ dealloc - MainMenuScene ~");
    [self removeAllChildrenWithCleanup:YES];
    [headerLayer release];
    
    [newGameImage release];
    [multiplayerImage release];
    [leaderboard release];
    [aboutImage release];
    [optionsImage release];
    [inviteFriendsImage release];
    [moreGamesImage release];
    [localHighScoreImage release];
	
    [menu release];
    [twitterManager release];
    [super dealloc];
}

@end
