//
//  MainMenuScene.h
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "HeaderLayer.h"
#import "TwitterManager.h"

@interface MainMenuScene : CCScene {
    
    HeaderLayer *headerLayer;
    
    CCMenu *menu;
	
	CCMenuItemImage *homeImage;
	CCMenuItemImage *leaderboard;
	CCMenuItemImage *newGameImage;
	CCMenuItemImage *optionsImage;
	CCMenuItemImage *aboutImage;
	CCMenuItemImage *inviteFriendsImage;
	CCMenuItemImage *moreGamesImage;
	CCMenuItemImage *selectTheme;
    CCMenuItemImage *localHighScoreImage;
    CCMenuItemImage *multiplayerImage;
    
    CCMenuItemImage *facebookImage;
	CCMenuItemImage *twitterIcon;
	
	TwitterManager *twitterManager;
	
    
}

@property (nonatomic, retain) HeaderLayer *headerLayer;

@property (nonatomic, retain) CCMenu *menu;

@property (nonatomic, retain) CCMenuItemImage *newGameImage;
@property (nonatomic, retain) CCMenuItemImage *optionsImage;
@property (nonatomic, retain) CCMenuItemImage *aboutImage;
@property (nonatomic, retain) CCMenuItemImage *moreGamesImage;
@property (nonatomic, retain) CCMenuItemImage *inviteFriendsImage;
@property (nonatomic, retain) CCMenuItemImage *leaderboard;
@property (nonatomic, retain) CCMenuItemImage *selectTheme;
@property (nonatomic, retain) CCMenuItemImage *localHighScoreImage;
@property (nonatomic, retain) CCMenuItemImage *multiplayerImage;

@property (nonatomic, retain) CCMenuItemImage *facebookImage;
@property (nonatomic, retain)CCMenuItemImage *twitterIcon;
@property (nonatomic, retain)TwitterManager *twitterManager;
- (void) drawComponents;
- (void) setComponentsPositions;
- (void) twitterPressed: (id) sender;

@end
