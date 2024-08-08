//
//  GamePlayProtocol.h
//  Maze
//
//  Created by Ali Imran on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GamePlayProtocol <NSObject>



- (void) updateRemotePlayerPositionX: (float) posX andPositionY:(float) posY;

- (void) addMatchLostLayer;

- (void) addMatchTiedLayer;

- (void) addMatchWinLayer: (int) time;

- (void) otherPlayerLeft;

@end
