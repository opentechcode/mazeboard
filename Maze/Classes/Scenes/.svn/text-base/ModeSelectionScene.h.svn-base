//
//  ModeSelectionScene.h
//  Maze
//
//  Created by Ali Imran on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HeaderLayer.h"


@interface ModeSelectionScene : CCScene {
    
    HeaderLayer *headerLayer;
    
    CCSprite *background;
    
    CCMenuItemImage *accelerometer;
    CCMenuItemImage *drag;
    
    
    CCSprite *accelerometerLabel;
    CCSprite *dragLabel;
    
    CCMenuItemImage *mainMenu;
    CCMenuItemImage *back;
    
    int gameLevel;
    
}

@property (nonatomic, readwrite) int gameLevel;

@property (nonatomic, retain) HeaderLayer *headerLayer;

@property (nonatomic, retain) CCSprite *background;

@property (nonatomic, retain) CCSprite *accelerometerLabel;
@property (nonatomic, retain) CCSprite *dragLabel;

@property (nonatomic, retain) CCMenuItemImage *accelerometer;
@property (nonatomic, retain) CCMenuItemImage *drag;
@property (nonatomic, retain) CCMenuItemImage *mainMenu;
@property (nonatomic, retain) CCMenuItemImage *back;

- (id) initWithGameLevel: (int) gameLevel;
- (void) setComponentPositions;

@end
