//
//  GamePlayScene.h
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "GameLayer.h"
#import "WinLayer.h"
#import "MenuLayer.h"
#import "GamePlayProtocol.h"
#import "QuitLayerProtocol.h"
#import "QuitGameLayer.h"



@interface GamePlayScene : CCScene <LayerProtcol, MenuProtocol, GamePlayProtocol, UIAlertViewDelegate, QuitLayerProtocol> {
    
    GameLayer *gameLayer;
    CCMenuItemImage *pauseButton;
    NSString *level;
    
    CCSprite *background;
    CCSprite *timerBackground;
    
    WinLayer *winLayer;
    MenuLayer *menuLayer;
    QuitGameLayer *quitLayer;
}

@property (nonatomic, retain) CCSprite *background;
@property (nonatomic, retain) CCSprite *timerBackground;

@property (nonatomic, retain) GameLayer *gameLayer;
@property (nonatomic, retain) CCMenuItemImage *pauseButton;
@property (nonatomic, retain) NSString *level;

@property (nonatomic, retain) WinLayer *winLayer;
@property (nonatomic, retain) MenuLayer *menuLayer;
@property (nonatomic, retain) QuitGameLayer *quitLayer;

- (id) initWithLevel: (NSString *) level1;

- (void) addQuitGameLayer;

@end
