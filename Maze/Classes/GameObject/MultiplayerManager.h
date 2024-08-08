//
//  MultiplayerManager.h
//  Maze
//
//  Created by Ali Imran on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "MazeManager.h"
#import "GamePlayProtocol.h"


@interface MultiplayerManager : NSObject <GKMatchDelegate, GKSessionDelegate> {
    
    id <GamePlayProtocol> gamePlayDelegate;
    
    int gameState;
    
    GKMatch *newMatch;
    GKSession *session;
    
    long localPlayerSelectionTime;
    long remotePlayerSelectionTime;
    
    int multiplayerGameType;
    
    MazeManager *mazeManager;
    
    NSString *gameLevel;
    NSString *gameMode;
    
    int localGameFinishTime;
    int remoteGameFinishTime;
    
    BOOL isGameOver;
    
    int counter;
}


@property (nonatomic, readwrite) int gameState;
@property (nonatomic, retain) GKMatch *newMatch;
@property (nonatomic, retain) GKSession *session;
@property (nonatomic, readwrite) long localPlayerSelectionTime;
@property (nonatomic, readwrite) long remotePlayerSelectionTime;
@property (nonatomic, readwrite) int multiplayerGameType;
@property (nonatomic, retain) MazeManager *mazeManager;

@property (nonatomic, retain) NSString *gameLevel;
@property (nonatomic, retain) NSString *gameMode;

@property (nonatomic, retain) id <GamePlayProtocol> gamePlayDelegate;

@property (nonatomic, readwrite) int localGameFinishTime;
@property (nonatomic, readwrite) int remoteGameFinishTime;

@property (nonatomic, readwrite) BOOL isGameOver;

@property (nonatomic, readwrite) int counter;

- (void) startGame;
- (void) leaveMatch;

- (BOOL) sendHandShakeMessage;
- (void) sendStartGamePlayMessage;
- (void) sendStartHardGameMessage: (int) messageNo;
- (void) sendMovePlayerMessage:(float) posX andPosY:(float) posY;
- (void) sendGameWinMessage: (int) time;
- (void) sendGameLostMessage;


- (NSMutableArray *) fillArray:(int) messageNo;
- (void) generateGameStartTime;

- (BOOL) sendData:(NSData *) data;
- (BOOL) sendGameCenterData:(NSData *) data;
- (BOOL) sendLocalWifiData:(NSData *) data;

- (void) procressHardGameMessage:(NSDictionary *) messageDict;

- (void) setLocalWifiDataHandler;
- (void) invalidateSession;

- (void) otherPlayerLeft;

@end
