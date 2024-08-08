//
//  GameLayer.h
//  Maze
//
//  Created by Ali Zafar on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "chipmunk.h"

#import "Ball.h"

#import "Cell.h"
#import "MazeManager.h"
#import "cpMouse.h"

#import "WinLayerProtocol.h"
#import "MenuLayerProtocol.h"

@interface GameLayer : CCLayer {

	cpSpace *space;
	cpMouse *mouse;
    
    Ball *ball;
    
	MazeManager *mazeManager;
    
	NSString *level;
	
    CCLabelTTF *timerLabel;
    int timeLeft;
    
	int gameType;
    float gravity;
    
    id <LayerProtcol> winDelegate;
    id <MenuProtocol> menuDelegate;
    
    
    CCSprite *remoteBall;
    
    BOOL winLayerAdded;
    
}

@property (nonatomic, retain) Ball *ball;

@property (nonatomic, retain) id <LayerProtcol> winDelegate;
@property (nonatomic, retain) id <MenuProtocol> menuDelegate;

@property (nonatomic, retain) MazeManager *mazeManager;

@property (nonatomic, retain) NSString *level;

@property (nonatomic, retain) CCLabelTTF *timerLabel;
@property (nonatomic, readwrite) int timeLeft;

@property (nonatomic, readwrite) int gameType;
@property (nonatomic, readwrite) float gravity;

@property (nonatomic, retain) CCSprite *remoteBall;

@property (nonatomic, readwrite) BOOL winLayerAdded;

- (id) initWithLevel:(NSString *) levelType;

- (void) step: (ccTime) dt;
- (void) test: (id) sender;

- (void) drawMaze: (NSString *) level;
- (void) drawDestinationSprite;

- (float) calcDistancePointA:(CGPoint) pointA andPointB:(CGPoint) pointB;

- (void) startTimer:(id) sender;

- (void) hasWonGame;
- (BOOL) ifHasWonGame;
- (void) setupChipmunk;

- (void) drawConnectors;
- (void) drawBorder;


- (void) saveScore;


- (void) playCollisionSound: (float) volume;

- (void) playBallRollingSound: (id) sender;

- (void) setSoundVolume;

- (float) setCollisonVolumeFromVelocityX: (float) velocityX andVelocityY:(float) velocityY;

- (void) playerWinAnimationWithSprite:(NSString *) spriteName;

- (void) drawRemoteBall;

- (void) setGameMode;
- (void) setGameModeAccelerometer;
- (void) setGameModeDrag;

- (void) addWinLayer;


@end
