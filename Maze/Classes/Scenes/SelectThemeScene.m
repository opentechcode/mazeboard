//
//  SelectThemeScene.m
//  Maze
//
//  Created by Ali Imran on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectThemeScene.h"
#import "MazeSounds.h"
#import "GameManager.h"
#import "CustomMenuItemToggle.h"
#import "GameSettings.h"
#import "Utility.h"

@implementation SelectThemeScene

@synthesize headerLayer, toggleItems, gameLevel, btnBack, btnNext;

- (id) initWithLevel: (NSString *) level
{
    self = [super init];
    if (self != nil) {
        
        self.gameLevel = level;
        
        headerLayer = [[HeaderLayer alloc] initWithHeading:@"h_selectTheme"];
        [self addChild:headerLayer z:0];
        
        
        self.btnNext = [CCMenuItemImage itemFromNormalImage:@"btn_next_unpress.png" selectedImage:@"btn_next_press.png" target:self selector:@selector(nextPressed:)];
        [btnNext setPosition:CGPointMake(CONST_MAINMENU_POSITION_X + 26, CONST_MAINMENU_POSITION_Y)];
        
        self.btnBack = [CCMenuItemImage itemFromNormalImage:@"btn_back_unpress.png" selectedImage:@"btn_back_press.png" target:self selector:@selector(backPressed:)];
        [btnBack setPosition:CGPointMake(130, CONST_MAINMENU_POSITION_Y)];
        
        [self drawToogleItems];
        
		CCMenu *menu = [CCMenu menuWithItems: [toggleItems objectAtIndex:0], [toggleItems objectAtIndex:1], [toggleItems objectAtIndex:2], [toggleItems objectAtIndex:3], [toggleItems objectAtIndex:4], [toggleItems objectAtIndex:5], [toggleItems objectAtIndex:6], [toggleItems objectAtIndex:7], [toggleItems objectAtIndex:8], [toggleItems objectAtIndex:9], [toggleItems objectAtIndex:10], [toggleItems objectAtIndex:11], btnNext, btnBack, nil];
        [menu setPosition:CGPointMake(0, 0)];
		[self addChild:menu z:999];
        
    }
    return self;
}


- (void) selectTheme: (id) sender
{
    [MazeSounds playButtonTap];
    CustomMenuItemToggle *mf = (CustomMenuItemToggle*) sender;
    
    if (mf.isSelected) {
        mf.selectedIndex = 1;
    } else {
        mf.selectedIndex = 1;
        mf.isSelected = YES;
        [GameSettings sharedGameSettings].themeNo = mf.tag;
        [[GameManager sharedGameManager] saveGameSettings];
        
        for (CustomMenuItemToggle *toggle in toggleItems) {
            if (toggle.tag != mf.tag) {
                toggle.selectedIndex = 0;
                toggle.isSelected = NO;
            }
        }
        
    }
}


- (void) nextPressed: (id) sender
{
    [MazeSounds playButtonTap];
    
    [[GameManager sharedGameManager] gamePlayScene:gameLevel];
}


- (void) backPressed: (id) sender
{
    [MazeSounds playButtonTap];
    [[GameManager sharedGameManager] levelSelectionScene];
}


- (void) drawToogleItems 
{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.toggleItems = array;
    [array release];
    
    float x = 138;
    float y = 1024 - 285;
    
    float xShift = 60 + 184;
    float yShift = 193;
    
    for (int i = 0; i < 12; i++) {
        
        NSString *unpressImage = [NSString stringWithFormat:@"theme_%d_unpress.png", i];
        NSString *pressImage = [NSString stringWithFormat:@"theme_%d_press.png", i];
                
        CustomMenuItemToggle *toggle = [CustomMenuItemToggle itemWithTarget:self selector:@selector(selectTheme:) items:
                                    [CCMenuItemImage itemFromNormalImage:unpressImage selectedImage:unpressImage],
                                    [CCMenuItemImage itemFromNormalImage:pressImage selectedImage:pressImage],
                                    nil];
        toggle.tag = i;
        [toggle setPosition:CGPointMake(x, y)];
        
        x = x + xShift;
        
        if (i == [GameSettings sharedGameSettings].themeNo) {
            toggle.isSelected = YES;
            toggle.selectedIndex = 1;
        }
        if (i == 2 || i == 5 || i == 8) {
            x = 138;
            y = y - yShift;
        }
        
        [toggleItems addObject:toggle];
        
    }
    
}

- (void) dealloc
{
    //NSLog(@"~ dealloc - SelectThemeScene ~");
    
    [headerLayer release];
    [toggleItems removeAllObjects];
    [toggleItems release];
    
    [gameLevel release];
    [btnBack release];
    [btnNext release];
    
    [super dealloc];
}

@end
