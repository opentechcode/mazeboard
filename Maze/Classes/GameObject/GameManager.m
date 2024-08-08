//
//  GameManager.m
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameManager.h"
#import "MainMenuScene.h"
#import "HelpScene.h"
#import "OptionScene.h"
#import "GamePlayScene.h"
#import "GameSettings.h"
#import "AppDelegate.h"
#import "MazeSounds.h"
#import "LevelSelectionScene.h"
#import "HighScoreScene.h"
#import "SelectThemeScene.h"
#import "MultiplayerScene.h"
#import "ModeSelectionScene.h"
#import "TwitterManager.h"
#import "LaunchScene.h"
#import "SplashScene.h"
static GameManager *gameManager = nil;

@implementation GameManager


@synthesize isGamePaused, highScoreManager, gameCenter, mail, localWifiSelected, gameCenterSelected, isMuliplayerGame, localWifiManager, multiplayerGameMode, difficultyLevel, gameControl, finishTime, fbManager, webViewDisplayed, webView, closeButton, counter, facebookName;
@synthesize twitterManager;

+ (GameManager *) sharedGameManager
{
    @synchronized(self)
	{
		if (gameManager == nil) {
			gameManager = [[self alloc] init];
		}
	}
	return gameManager;
}


- (id) init
{
    if ((self = [super init])) {
        
        [MazeSounds preLoadSounds];
        [self loadGameSettings];
		
        self.isGamePaused = NO;
        
        HighScoreManager *temp = [[HighScoreManager alloc] init];
        self.highScoreManager = temp;
        [temp release];
		
		GameCenter *tempGameCenter = [[GameCenter alloc] init];
		self.gameCenter = tempGameCenter;
		[tempGameCenter release];
        
        LocalWifiManager *tempWifiManager = [[LocalWifiManager alloc] init];
        self.localWifiManager = tempWifiManager;
        [tempWifiManager release];
		
		MailComposeViewController *tempMail = [[MailComposeViewController alloc] init];
		
		self.mail=tempMail;
		
		[tempMail release];
		
        localWifiSelected = NO;
		gameCenterSelected = NO;
        isMuliplayerGame = NO;
        
        
        NSString *tempControl = [[NSString alloc] init];
        self.gameControl = tempControl;
        [tempControl release];
        
        if ([GameSettings sharedGameSettings].manualStatus) {
            self.gameControl = @"Drag";
        } else {
            self.gameControl = @"Accelerometer";
        }
        
        NSString *tempLevel = [[NSString alloc] init];
        self.difficultyLevel = tempLevel;
        [tempLevel release];
        
        self.finishTime = 0;
        
        self.webViewDisplayed = NO;
        self.counter = 0;
        
        [self initClosebutton];
        
        NSString *tempFBName = [[NSString alloc] init];
        self.facebookName = tempFBName;
        [tempFBName release];
    }
    
    return self;
}

-(void)splashScene
{
	SplashScene *splashScene=[[SplashScene alloc] init];
	[[CCDirector sharedDirector] runWithScene:splashScene];
	[splashScene release];
	[self performSelector:@selector(launchGame) withObject:nil afterDelay:1.0];
}

-(void)launchGame
{
	LaunchScene *launchScene=[[LaunchScene alloc] init];
	[[CCDirector sharedDirector] replaceScene:launchScene];
	[launchScene release];
	[self performSelector:@selector(startGame) withObject:nil afterDelay:2.0];
}

- (void) startGame
{	
    [gameCenter autheticatePlayer];
    //[MazeSounds playBackGroundSound];
	
	MainMenuScene *menuScene = [[MainMenuScene alloc] init];
	
	[[CCDirector sharedDirector] replaceScene:menuScene];
	
	
	[menuScene release];
}


#pragma mark Scene Launching Methods

-(void)inviteFriend
{
	if(![MFMailComposeViewController canSendMail])
	{
		UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Mail Not Configured" message:@"Please configure your email to use this functionality" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertview show];
		[alertview release];
		return ;
	}
		
	[mail sendEmail:EMAIL_SUBJECT message:EMAIL_MESSAGE imageFileName:@"Maze.png" andImage:[UIImage imageNamed:@"Default.png"]];
	mail.wantsFullScreenLayout=YES;
	
}

- (void) mainMenuScene
{
    [[CCTextureCache sharedTextureCache] removeAllTextures];
    MainMenuScene *mainMenuScene = [[MainMenuScene alloc] init];
    [[CCDirector sharedDirector] replaceScene:mainMenuScene];
    [mainMenuScene release];
}



- (void) gamePlayScene:(NSString*) level
{
    GamePlayScene *gamePlayScene = [[GamePlayScene alloc] initWithLevel:level];
    [[CCDirector sharedDirector] replaceScene:gamePlayScene];
    [gamePlayScene release];
}



- (void) optionScene
{
    OptionScene *optionScene = [[OptionScene alloc] init];
    [[CCDirector sharedDirector] replaceScene:optionScene];
    [optionScene release];
}



- (void) helpScene
{
    HelpScene *helpScene = [[HelpScene alloc] init];
    [[CCDirector sharedDirector] replaceScene:helpScene];
    [helpScene release];
}


- (void) levelSelectionScene
{
    LevelSelectionScene *selectLevel = [[LevelSelectionScene alloc] init];
    [[CCDirector sharedDirector] replaceScene:selectLevel];
    [selectLevel release];
}


- (void) highScoreScene
{
    HighScoreScene *highScoreScene = [[HighScoreScene alloc] init];
    [[CCDirector sharedDirector] replaceScene:highScoreScene];
    [highScoreScene release];
}


- (void) selectThemeScene: (NSString *) gameLevel
{
    SelectThemeScene *selectThemeScene = [[SelectThemeScene alloc] initWithLevel:gameLevel];
    [[CCDirector sharedDirector] replaceScene:selectThemeScene];
    [selectThemeScene release];
}


- (void) multiplayerScene:(int) gameType
{
    MultiplayerScene *multiplayerScene = [[MultiplayerScene alloc] initWithGameType:gameType];
    [[CCDirector sharedDirector] replaceScene:multiplayerScene];
    [multiplayerScene release];
}


- (void) modeSelectionScene:(int) gameLevel
{
    ModeSelectionScene *modeScene = [[ModeSelectionScene alloc] initWithGameLevel:gameLevel];
    [[CCDirector sharedDirector] replaceScene:modeScene];
    [modeScene release];
}

#pragma mark Game Load and Save Functions

-(void)loadGameSettings
{	
	
	NSMutableDictionary *game = [NSKeyedUnarchiver unarchiveObjectWithFile:[AppDelegate pathForApplicationFile:@"GameSetting.plist"]];
	if ( game != nil ) {
		//Assign the attributes
		GameSettings *tempGameSettings=(GameSettings *)[game objectForKey:@"Settings"];
		if(tempGameSettings != nil) {
			[GameSettings sharedGameSettings].soundEffectsStatus = tempGameSettings.soundEffectsStatus;
			[GameSettings sharedGameSettings].ambientSoundStatus = tempGameSettings.ambientSoundStatus;
            [GameSettings sharedGameSettings].accelerometerStatus = tempGameSettings.accelerometerStatus;
            [GameSettings sharedGameSettings].manualStatus = tempGameSettings.manualStatus;
            [GameSettings sharedGameSettings].playerName = tempGameSettings.playerName;
            [GameSettings sharedGameSettings].themeNo = tempGameSettings.themeNo;
            [GameSettings sharedGameSettings].selectedTheme = tempGameSettings.selectedTheme;
		}
	}
	
}

-(void)saveGameSettings
{
	NSMutableDictionary * gameDictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:[AppDelegate pathForApplicationFile:@"GameSetting.plist"]];
	
	if(gameDictionary != nil) {
		[gameDictionary setObject:[GameSettings sharedGameSettings] forKey:@"Settings"];
		if([NSKeyedArchiver archiveRootObject: gameDictionary toFile:[AppDelegate pathForApplicationFile:@"GameSetting.plist"]]) {
			NSLog(@"Game Save SUCCESSFUL");
		} else {
			NSLog(@"Game Save FAILED");
		}
		
	} else {
		
		NSMutableDictionary *gameDictionary=[[NSMutableDictionary alloc] init];
		
		[gameDictionary setObject:[GameSettings sharedGameSettings] forKey:@"Settings"];
		if([NSKeyedArchiver archiveRootObject: gameDictionary toFile:[AppDelegate pathForApplicationFile:@"GameSetting.plist"]]) {
			NSLog(@"Game Save SUCCESSFUL");
		} else {
			NSLog(@"Game Save FAILED");
		}
		[gameDictionary release];
	}
}


#pragma mark FBManager Methods


- (void) initFBManager:(int) seconds andLevel:(NSString *) level
{
    if (!self.fbManager) {
        
        FBManager *temp = [[FBManager alloc] init];
        self.fbManager = temp;
        [temp release];
		[fbManager authorizeFacebook];
	
        //[[GameManager sharedGameManager].fbManager postToWall:seconds andLevel:level];
				
		
    } else {
		[fbManager authorizeFacebook];
        [[GameManager sharedGameManager].fbManager postToWall:seconds andLevel:level];
		
    }
    
}

- (void) postToWall:(int) seconds andLevel:(NSString *) level
{
    [[GameManager sharedGameManager].fbManager postToWall:seconds andLevel:level];
}



#pragma mark UIButton Helper Methods

- (void) initClosebutton
{
    CGRect frame = CGRectMake(626, 112, 33, 33);
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    closeButton.frame = frame;
    
    UIImage *snap_picture = [UIImage imageNamed:@"close.png"];
    
    [closeButton setBackgroundImage:snap_picture forState:UIControlStateNormal];
    [closeButton setBackgroundImage:snap_picture forState:UIControlStateSelected];
    
    closeButton.userInteractionEnabled = YES;
    
    [closeButton addTarget:self action:@selector(closePressed:) forControlEvents:UIControlEventTouchUpInside];
}


- (void) drawCloseButton
{
    
    UIViewController *viewController = (UIViewController *)[(AppDelegate *)[UIApplication sharedApplication].delegate viewController];
    [viewController.view addSubview:closeButton];
    
}


- (void) removeCloseButton
{
    [closeButton removeFromSuperview];
}


- (void) closePressed: (id) sender
{
    [MazeSounds playButtonTap];
    
    [self removeWebView];
    [webView release];
    
    [self removeCloseButton];
    
}

#pragma mark UIWebView Helper Methods

- (void) initWebView
{
    
    CGRect webFrame = CGRectMake(109, 112, 550, 800);
    webView = [[UIWebView alloc] initWithFrame:webFrame];
    webView.backgroundColor = [UIColor whiteColor];
    webView.delegate = self;
    [webView setOpaque:NO];
    
}


- (void) loadWebView
{
    
    NSString *urlAddress = @"http://www.facebook.com/pages/Envision-Studios-Inc/200376043352155";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3];
    
    [webView loadRequest:requestObj];
    
}

- (void) displayWebView
{
	if (fbManager==nil) {
		self.fbManager=[[FBManager alloc] init];
		
	}
    [fbManager showEnvisionStudiosPage];
	/*
    [self initWebView];
    
    //alertView = [Utility alertViewWithActivityIndicatorWithTitle:@"Wait" andMessage:@" ... "];

    [self loadWebView];
    
    UIViewController *viewController = (UIViewController *)[(AppDelegate *)[UIApplication sharedApplication].delegate viewController];
    [viewController.view addSubview:webView];
    
    self.webViewDisplayed = YES;
    
    [self drawCloseButton];
    */
}

- (void) removeWebView
{
    [webView removeFromSuperview];
    webView.delegate = nil;
    self.webViewDisplayed = NO;
}


#pragma mark UIWebViewDelegate Method

- (void) webViewDidFinishLoad:(UIWebView *) webView
{
    
    //[alertView dismissWithClickedButtonIndex:0 animated:YES];
	//alertView = nil;
    
    //[self drawCloseButton];
    
    NSLog(@"webViewDidFinishLoad");
    
}


- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError");
}


-(void)showTwitterPage
{
	if (twitterManager==nil) {
		self.twitterManager=[[TwitterManager alloc] init];
		
	}
	
	[twitterManager showEnvisionStudiosFeed];
}

- (void) dealloc {
    
    [gameControl release];
    [difficultyLevel release];
	if (twitterManager !=nil) {
		[twitterManager release];
	}
    
    [super dealloc];
}



@end
