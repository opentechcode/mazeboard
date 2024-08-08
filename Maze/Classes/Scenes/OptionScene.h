//
//  AboutScene.h
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "HeaderLayer.h"


@interface OptionScene : CCScene {
	
    HeaderLayer *headerLayer;
    
    CCSprite *background;
    
    CCSprite *soundHeading;
    
	CCMenuItemToggle *ambientSound;
	CCMenuItemToggle *soundEffects;
    
    
    CCSprite *ambientSoundLabel;
    CCSprite *soundEffectsLabel;
    
	
	CCMenu *menu;
	
	CCMenuItemImage *mainMenu;
    
    CCSprite *counterHeading;
    
    CCMenuItemToggle *accelerometer;
    CCMenuItemToggle *manual;
    
    CCSprite *accelerometerLabel;
    CCSprite *manualLabel;
    
    BOOL isAcceleromterSelected;
    BOOL isManualSelected;
    
}

@property (nonatomic, retain) HeaderLayer *headerLayer;

@property (nonatomic, retain) CCSprite *background;

@property (nonatomic, retain) CCMenuItemImage *mainMenu;

@property (nonatomic, retain) CCSprite *soundHeading;

@property (nonatomic, retain) CCMenuItemToggle *ambientSound;
@property (nonatomic, retain) CCMenuItemToggle *soundEffects;
@property (nonatomic, retain) CCMenu *menu;

@property (nonatomic, retain) CCSprite *ambientSoundLabel;
@property (nonatomic, retain) CCSprite *soundEffectsLabel;

@property (nonatomic, retain) CCSprite *counterHeading;

@property (nonatomic, retain) CCMenuItemToggle *accelerometer;
@property (nonatomic, retain) CCMenuItemToggle *manual;

@property (nonatomic, retain) CCSprite *accelerometerLabel;
@property (nonatomic, retain) CCSprite *manualLabel;


@property (readwrite) BOOL isAcceleromterSelected;
@property (readwrite) BOOL isManualSelected;

- (void) setComponentsPositions;

@end