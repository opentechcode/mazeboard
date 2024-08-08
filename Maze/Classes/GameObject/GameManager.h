//
//  GameManager.h
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HighScoreManager.h"
#import "MailComposeViewController.h"
#import "GameCenter.h"
#import "LocalWifiManager.h"
#import "FBManager.h"
#import "TwitterManager.h"


@interface GameManager : NSObject <UIWebViewDelegate> {
    
    
    FBManager *fbManager;
    
    BOOL isGamePaused;

	GameCenter *gameCenter;
    
	MailComposeViewController *mail;
	
    HighScoreManager *highScoreManager;
    
    BOOL localWifiSelected;
    BOOL gameCenterSelected;
    BOOL isMuliplayerGame;
    
    int multiplayerGameMode;
    
    LocalWifiManager *loacalWifiManager;
    
    NSString *gameControl;
    NSString *difficultyLevel;
    int finishTime;
    
    BOOL webViewDisplayed;
    
    UIWebView *webView;
    UIButton *closeButton;
    
    int counter;
    
    UIAlertView *alertView;
    NSString *facebookName;
	
	
	TwitterManager *twitterManager;
}

@property (nonatomic, retain) NSString *facebookName;

@property (nonatomic, retain) FBManager *fbManager;

@property (nonatomic, retain) NSString *gameControl;
@property (nonatomic, retain) NSString *difficultyLevel;
@property (nonatomic, readwrite) int finishTime;

@property (readwrite) BOOL isGamePaused;
@property(nonatomic, retain)MailComposeViewController *mail;
@property (nonatomic, retain) GameCenter *gameCenter;

@property (nonatomic, retain) HighScoreManager *highScoreManager;

@property (readwrite) BOOL localWifiSelected;
@property (readwrite) BOOL gameCenterSelected;
@property (readwrite) BOOL isMuliplayerGame;

@property (nonatomic, retain) LocalWifiManager *localWifiManager;
@property (nonatomic, readwrite) int multiplayerGameMode;

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIButton *closeButton;
@property (nonatomic, readwrite) BOOL webViewDisplayed;
@property (nonatomic, readwrite) int counter;

@property (nonatomic, retain)TwitterManager *twitterManager;

+ (GameManager *) sharedGameManager;

-(void)splashScene;
-(void)launchGame;
- (void) startGame;
- (void) inviteFriend;
- (void) mainMenuScene;
- (void) optionScene;
- (void) helpScene;



- (void) modeSelectionScene:(int) gameLevel;
- (void) gamePlayScene:(NSString*) level;
- (void) levelSelectionScene;


- (void) saveGameSettings;
- (void) loadGameSettings;

- (void) highScoreScene;

- (void) selectThemeScene: (NSString *) gameLevel;

- (void) multiplayerScene: (int) gameType;

- (void) initFBManager:(int) seconds andLevel:(NSString *) level;
- (void) postToWall:(int) seconds andLevel:(NSString *) level;

-(void)showTwitterPage;

- (void) initClosebutton;
- (void) drawCloseButton;
- (void) removeCloseButton;

- (void) initWebView;
- (void) loadWebView;
- (void) displayWebView;
- (void) removeWebView;



@end
