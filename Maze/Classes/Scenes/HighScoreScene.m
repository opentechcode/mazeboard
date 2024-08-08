//
//  HighScoreScene.m
//  Maze
//
//  Created by Ali Imran on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HighScoreScene.h"
#import "MazeSounds.h"
#import "GameManager.h"

@implementation HighScoreScene

@synthesize headerLayer, background, accelerometer, drag, easy, medium, hard, mainMenu, isAcceleromterSelected, isManualSelected, rank, name, time, easySelected, mediumSelected, hardSelected, highScoreLayer, clearScore, clearScoreLayer, menu;



- (id) init
{
    self = [super init];
    if (self != nil) {
        
        self.isAcceleromterSelected = YES;
        self.isManualSelected = NO;
        
        headerLayer = [[HeaderLayer alloc] initWithHeading:@"h_localhighscore"];
        [self addChild:headerLayer];
        
        self.background = [CCSprite spriteWithFile:@"bg_localScore.png"];
        [background setPosition:CGPointMake(768/2, 1024/2 + 10)];
        [self addChild:background];
        
        
        self.accelerometer = [CCMenuItemToggle itemWithTarget:self selector:@selector(displayScores:) items:
                         [CCMenuItemImage itemFromNormalImage:@"tab_accelerometer_press.png" selectedImage:@"tab_accelerometer_press.png"], 
                         [CCMenuItemImage itemFromNormalImage:@"tab_accelerometer_unpress.png" selectedImage:@"tab_accelerometer_unpress.png"],
                         nil];
        
        accelerometer.tag = 1;
        accelerometer.selectedIndex = 0;
        
        [accelerometer setPosition:CGPointMake(220, 1024 - 180 - 50)];
        
        
        self.drag = [CCMenuItemToggle itemWithTarget:self selector:@selector(displayScores:) items:
                [CCMenuItemImage itemFromNormalImage:@"tab_drag_press.png" selectedImage:@"tab_drag_press.png"], 
                [CCMenuItemImage itemFromNormalImage:@"tab_drag_unpress.png" selectedImage:@"tab_drag_unpress.png"],
                nil];
        
        drag.tag = 2;
        drag.selectedIndex = 1;
        
        [drag setPosition:CGPointMake(230 + 140 + 80, 1024 - 180 - 50)];
        
        self.easy = [CCMenuItemToggle itemWithTarget:self selector:@selector(displayScores:) items:
                [CCMenuItemImage itemFromNormalImage:@"btn_easy_unpress.png" selectedImage:@"btn_easy_unpress.png"], 
                [CCMenuItemImage itemFromNormalImage:@"btn_easy_press.png" selectedImage:@"btn_easy_press.png"],
                nil];
        [easy setPosition:CGPointMake(768/2, 200 + 30)];
        easy.tag = 3;
        easy.selectedIndex = 1;
        
        self.easySelected = YES;
        self.mediumSelected = NO;
        self.hardSelected = NO;
        
        
        self.medium = [CCMenuItemToggle itemWithTarget:self selector:@selector(displayScores:) items:
                  [CCMenuItemImage itemFromNormalImage:@"btn_medium_unpress.png" selectedImage:@"btn_medium_unpress.png"], 
                  [CCMenuItemImage itemFromNormalImage:@"btn_medium_press.png" selectedImage:@"btn_medium_press.png"],
                  nil];
        [medium setPosition:CGPointMake(768/2, 140 + 30)];
        medium.tag = 4;
        
        
        self.hard = [CCMenuItemToggle itemWithTarget:self selector:@selector(displayScores:) items:
                [CCMenuItemImage itemFromNormalImage:@"btn_hard_unpress.png" selectedImage:@"btn_hard_unpress.png"], 
                [CCMenuItemImage itemFromNormalImage:@"btn_hard_press.png" selectedImage:@"btn_hard_press.png"],
                nil];
        [hard setPosition:CGPointMake(768/2, 82 + 30)];
        hard.tag = 5;
        
        self.mainMenu = [CCMenuItemImage itemFromNormalImage:@"btn_mainmenu_unpress.png" selectedImage:@"btn_mainmenu_press.png"
												 target:self selector:@selector(mainMenu:)];
        [mainMenu setPosition:CGPointMake(CONST_MAINMENU_POSITION_X + 10, CONST_MAINMENU_POSITION_Y)];
        
        
        
        self.clearScore = [CCMenuItemImage itemFromNormalImage:@"btn_clearscore_unpress.png" selectedImage:@"btn_clearscore_press.png"
                                                   target:self selector:@selector(clearScorePressed:)];
        [clearScore setPosition:CGPointMake(530 + 95, 295 + 24)];
        
        
        self.menu = [CCMenu menuWithItems:mainMenu, accelerometer, drag, easy, medium, hard, clearScore, nil];
        [menu setPosition:CGPointMake(0, 0)];
        [self addChild:menu];
        
        self.rank = [CCLabelTTF labelWithString:@"Rank" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE + 10];
        [rank setPosition:CGPointMake(150, 1024 - 300)];
        [rank setColor:ccc3(0, 0, 0)];
        [self addChild:rank];
        
        self.name = [CCLabelTTF labelWithString:@"Name" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE + 10];
        [name setPosition:CGPointMake(350, 1024 - 300)];
        [name setColor:ccc3(0, 0, 0)];
        [self addChild:name];
        
        self.time = [CCLabelTTF labelWithString:@"Time" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE + 10];
        [time setPosition:CGPointMake(550, 1024 - 300)];
        [time setColor:ccc3(0, 0, 0)];
        [self addChild:time];
        
        
        HighScoreLayer *layer = [[HighScoreLayer alloc] init];
        self.highScoreLayer = layer;
        [layer release];
        
        [self addChild:highScoreLayer z:3];
        [self displayScore];
        
        ClearScoreLayer *clearLayer = [[ClearScoreLayer alloc] init];
        self.clearScoreLayer = clearLayer;
        [clearLayer release];
        
    }
    return self;
}


- (void) displayScores: (id) sender
{
    [MazeSounds playButtonTap];
    
    CCMenuItemToggle *mf = (CCMenuItemToggle*) sender;
    
    if (isAcceleromterSelected && mf.tag == 1) {
        mf.selectedIndex = 0;
    } else if (isManualSelected && mf.tag == 2) {
        mf.selectedIndex = 0;
    } else if (!isAcceleromterSelected && mf.tag == 1 && isManualSelected) {
        
        mf.selectedIndex = 0;
        drag.selectedIndex = 1;
        isAcceleromterSelected = YES;
        isManualSelected = NO;
        
    } else if (!isManualSelected && mf.tag == 2 && isAcceleromterSelected) {
        
        mf.selectedIndex = 0;
        accelerometer.selectedIndex = 1;
        isManualSelected = YES;
        isAcceleromterSelected = NO;
    
    }
    
    
    if (easySelected && mf.tag == 3) {
        mf.selectedIndex = 1;
    } else if (mediumSelected && mf.tag == 4) {
        mf.selectedIndex = 1;
    } else if (hardSelected && mf.tag == 5) {
        mf.selectedIndex = 1;
    } else if (!easySelected && mf.tag == 3 && (mediumSelected || hardSelected)) {
        
        mf.selectedIndex = 1;
        medium.selectedIndex = 0;
        hard.selectedIndex = 0;
        
        easySelected = YES;
        mediumSelected = NO;
        hardSelected = NO;
        
    } else if (!mediumSelected && mf.tag == 4 && (easySelected || hardSelected)) {
        
        mf.selectedIndex = 1;
        easy.selectedIndex = 0;
        hard.selectedIndex = 0;
        
        easySelected = NO;
        mediumSelected = YES;
        hardSelected = NO;
        
    } else if (!hardSelected && mf.tag == 5 && (easySelected || mediumSelected)) {
        mf.selectedIndex = 1;
        easy.selectedIndex = 0;
        medium.selectedIndex = 0;
        
        easySelected = NO;
        mediumSelected = NO;
        hardSelected = YES;
    }
    
    
    [self displayScore];
    
}



- (void) displayScore
{
    if (isAcceleromterSelected && easySelected) {
        [highScoreLayer populateLayerWithArray:[GameManager sharedGameManager].highScoreManager.easyAccelerometer];
    } else if (isAcceleromterSelected && mediumSelected) {
        [highScoreLayer populateLayerWithArray:[GameManager sharedGameManager].highScoreManager.mediumAccelerometer];
    } else if (isAcceleromterSelected && hardSelected) {
        [highScoreLayer populateLayerWithArray:[GameManager sharedGameManager].highScoreManager.hardAccelerometer];
    } else if (isManualSelected && easySelected) {
        [highScoreLayer populateLayerWithArray:[GameManager sharedGameManager].highScoreManager.easyDrag];
    } else if (isManualSelected && mediumSelected) {
        [highScoreLayer populateLayerWithArray:[GameManager sharedGameManager].highScoreManager.mediumDrag];
    } else if (isManualSelected && hardSelected) {
        [highScoreLayer populateLayerWithArray:[GameManager sharedGameManager].highScoreManager.hardDrag];
    }
}



- (void) clearScorePressed: (id) sender
{
    
    [MazeSounds playButtonTap];
    [self addClearScoreLayer];
    
}


- (void) clearScores
{
    if (isAcceleromterSelected && easySelected) {
        
        [[GameManager sharedGameManager].highScoreManager.easyAccelerometer removeAllObjects];
        [highScoreLayer populateLayerWithArray:[GameManager sharedGameManager].highScoreManager.easyAccelerometer];
        
    } else if (isAcceleromterSelected && mediumSelected) {
        
        [[GameManager sharedGameManager].highScoreManager.mediumAccelerometer removeAllObjects];
        [highScoreLayer populateLayerWithArray:[GameManager sharedGameManager].highScoreManager.mediumAccelerometer];
        
    } else if (isAcceleromterSelected && hardSelected) {
        
        [[GameManager sharedGameManager].highScoreManager.hardAccelerometer removeAllObjects];
        [highScoreLayer populateLayerWithArray:[GameManager sharedGameManager].highScoreManager.hardAccelerometer];
        
    } else if (isManualSelected && easySelected) {
        
        [[GameManager sharedGameManager].highScoreManager.easyDrag removeAllObjects];
        [highScoreLayer populateLayerWithArray:[GameManager sharedGameManager].highScoreManager.easyDrag];
        
    } else if (isManualSelected && mediumSelected) {
        
        [[GameManager sharedGameManager].highScoreManager.mediumDrag removeAllObjects];
        [highScoreLayer populateLayerWithArray:[GameManager sharedGameManager].highScoreManager.mediumDrag];
        
    } else if (isManualSelected && hardSelected) {
        
        [[GameManager sharedGameManager].highScoreManager.hardDrag removeAllObjects];
        [highScoreLayer populateLayerWithArray:[GameManager sharedGameManager].highScoreManager.hardDrag];
        
    }
    
    [[GameManager sharedGameManager].highScoreManager saveAllScores];
}



- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [MazeSounds playButtonTap];
	if (buttonIndex == 1) {
		[self clearScores];
	}
}



- (void) mainMenu:(id) sender
{   
	[MazeSounds playButtonTap];
	[[GameManager sharedGameManager]  mainMenuScene];
}



#pragma mark ClearLayer delegate methods


- (void) addClearScoreLayer
{
    
    self.clearScoreLayer.delegate = self;
    [self addChild:clearScoreLayer z:999];
    
    [menu setIsTouchEnabled:NO];
}


- (void) removeClearScoreLayer:(int) tag
{
    
    if (tag == 1) {
        [self clearScores];
    }
    
    [self removeChild:self.clearScoreLayer cleanup:YES];
    self.clearScoreLayer.delegate = nil;
    [menu setIsTouchEnabled:YES];
}



- (void) dealloc
{
     NSLog(@"~ dealloc - HighScoreScene ~");
    
    [headerLayer release];
    
    [background release];
    
    [accelerometer release];
    [drag release];
    
    [easy release];
    [medium release];
    [hard release];
    
    [mainMenu release];
    [clearScore release];
    [menu release];
    
    [name release];
    [rank release];
    [time release];
    
    [highScoreLayer release];
    [clearScoreLayer release];
    [super dealloc];
}



@end
