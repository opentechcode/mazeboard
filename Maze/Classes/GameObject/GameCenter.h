//
//  GameCenter.h
//  BattleshipiPhone
//
//  Created by Ali Zafar on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "MultiplayerManager.h"

@interface GameCenter : NSObject<GKLeaderboardViewControllerDelegate, GKMatchmakerViewControllerDelegate> {

	BOOL isPlayerAuthenticated;
	NSMutableArray *scores;
	
	UIAlertView *alertview;
	
    MultiplayerManager *multiplayerManager;
    
    BOOL isInvited;
    
}

@property (readwrite) BOOL isInvited;
@property (readwrite) BOOL isPlayerAuthenticated;
@property (nonatomic, retain) NSMutableArray *scores;
@property (nonatomic, retain) MultiplayerManager *multiplayerManager;

- (void) registerInviteHandler;

- (void) autheticatePlayer;
- (void) registerForAuthenticationNotification;
- (void) authentiacationChanged:(id)sender;

-(void)reportTheScore:(int)shots Category:(NSString *)category;
-(void)reportOutStandingScore;

-(void)authenticatePlayerToSubmitScore:(int)myscore Category:(NSString *)category;

-(void)loadScores;
-(void)saveScores;

-(void) showViewControllerLeaderBoard;
-(void) authenticatePlayerToShowLearderBoard;
-(void) launchAutoMatchingWithLevelType: (int) level;



@end
