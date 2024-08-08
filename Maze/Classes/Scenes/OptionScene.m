//
//  AboutScene.m
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OptionScene.h"
#import "GameManager.h"
#import "Constant.h"
#import "GameSettings.h"
#import "MazeSounds.h"

@implementation OptionScene


@synthesize ambientSound, soundEffects, menu, mainMenu, ambientSoundLabel, soundEffectsLabel, headerLayer, accelerometer, manual, isAcceleromterSelected, isManualSelected, accelerometerLabel, manualLabel, background, soundHeading, counterHeading;

- (id) init {
	self = [super init];
	if (self != nil) {
		
        
        headerLayer = [[HeaderLayer alloc] initWithHeading:@"h_options"];
        [self addChild:headerLayer];
        
        self.background = [CCSprite spriteWithFile:@"bg_options.png"];
        [self addChild:background];
        
        self.ambientSoundLabel = [CCSprite spriteWithFile:@"label_ambientsound.png"];
        [self addChild:ambientSoundLabel];
        
        self.soundEffectsLabel = [CCSprite spriteWithFile:@"label_soundeffects.png"];
        [self addChild:soundEffectsLabel];
        
        
        self.accelerometerLabel = [CCSprite spriteWithFile:@"label_accelerometer.png"];
        [self addChild:accelerometerLabel];
        
        self.manualLabel = [CCSprite spriteWithFile:@"label_manual.png"];
        [self addChild:manualLabel];
        
        self.soundHeading = [CCSprite spriteWithFile:@"h_sound.png"];
        [self addChild:soundHeading];
        
        self.counterHeading = [CCSprite spriteWithFile:@"h_counter.png"];
        [self addChild:counterHeading];
        
        
		self.soundEffects = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundEffectsSelection:) items:
                        [CCMenuItemImage itemFromNormalImage:@"btn_soundeffect_on.png" selectedImage:@"btn_soundeffect_on.png"], 
                        [CCMenuItemImage itemFromNormalImage:@"btn_soundeffect_off.png" selectedImage:@"btn_soundeffect_off.png"],
                        nil];
		
		self.ambientSound = [CCMenuItemToggle itemWithTarget:self selector:@selector(ambeintSoundoundSelection:) items:
                        [CCMenuItemImage itemFromNormalImage:@"btn_sound_on.png" selectedImage:@"btn_sound_on.png"], 
                        [CCMenuItemImage itemFromNormalImage:@"btn_sound_off.png" selectedImage:@"btn_sound_off.png"],
                        nil];
		
		
        if ([GameSettings sharedGameSettings].ambientSoundStatus) {
			ambientSound.selectedIndex = 0;
		} else {
			ambientSound.selectedIndex = 1;
		}
        
		
		if ([GameSettings sharedGameSettings].soundEffectsStatus) {
			soundEffects.selectedIndex = 0;		
		} else {
			soundEffects.selectedIndex = 1;
		}
        
        self.accelerometer = [CCMenuItemToggle itemWithTarget:self selector:@selector(selectGameType:) items:
                        [CCMenuItemImage itemFromNormalImage:@"accelerometer_on.png" selectedImage:@"accelerometer_on.png"], 
                        [CCMenuItemImage itemFromNormalImage:@"accelerometer_off.png" selectedImage:@"accelerometer_off.png"],
                        nil];
        
        accelerometer.tag = 1;
        self.isAcceleromterSelected = [GameSettings sharedGameSettings].accelerometerStatus;
        
        if ([GameSettings sharedGameSettings].accelerometerStatus) {
            accelerometer.selectedIndex = 0;
        } else {
            accelerometer.selectedIndex = 1;
        }
        
		
		self.manual = [CCMenuItemToggle itemWithTarget:self selector:@selector(selectGameType:) items:
                        [CCMenuItemImage itemFromNormalImage:@"manual_on.png" selectedImage:@"manual_on.png"], 
                        [CCMenuItemImage itemFromNormalImage:@"manual_off.png" selectedImage:@"manual_off.png"],
                        nil];
        
        manual.tag = 2;
        
        self.isManualSelected = [GameSettings sharedGameSettings].manualStatus;
        
        if ([GameSettings sharedGameSettings].manualStatus) {
            manual.selectedIndex = 0;
        } else {
            manual.selectedIndex = 1;
        }
        
		self.mainMenu = [CCMenuItemImage itemFromNormalImage:@"btn_mainmenu_unpress.png" selectedImage:@"btn_mainmenu_press.png"
												 target:self selector:@selector(mainMenu:)];
		
		
		self.menu =[CCMenu menuWithItems:self.ambientSound, self.soundEffects, self.accelerometer, self.manual ,mainMenu, nil];
		[menu setPosition:CGPointMake(0, 0)];
		[self addChild:menu];
		
		[self setComponentsPositions];
		
	}
	return self;
}

- (void) setComponentsPositions
{
    float yGap = -80;
    
	[background setPosition:CGPointMake(768/2, 1024/2 - 85 - yGap)];
    
    [soundHeading setPosition:CGPointMake(76 + 72, 1024 - 288 - 30 - yGap)];
    [counterHeading setPosition:CGPointMake(76 + 85, 1024 - 632 - 25- yGap)];
    
    
	[ambientSound setPosition:CGPointMake(768 - 140 - 70, 1024 - 363 - 70 - yGap)];
    [ambientSoundLabel setPosition:CGPointMake(768 - 140 - 70, 1024 - 510 - 30 - yGap)];
	
    [soundEffects setPosition:CGPointMake(140 + 70, 1024 - 363 - 70 - yGap)];
    [soundEffectsLabel setPosition:CGPointMake(140 + 70, 1024 - 510 - 30 - yGap)];
    
    
    [accelerometer setPosition:CGPointMake(140 + 70, 1024 - 706 - 70 - yGap)];
    [accelerometerLabel setPosition:CGPointMake(140 + 70, 1024 - 864 - 30 - yGap)];
    
    
    [manual setPosition:CGPointMake(768 - 140 - 70, 1024 - 706 - 70 - yGap)];
	[manualLabel setPosition:CGPointMake(768 - 140 - 70, 1024 - 864 - 30 - yGap)];
    
    [mainMenu setPosition:CGPointMake(CONST_MAINMENU_POSITION_X, CONST_MAINMENU_POSITION_Y)];
	
}

-(void) mainMenu:(id) sender
{   
	[MazeSounds playButtonTap];
	[[GameManager sharedGameManager] mainMenuScene];
}


-(void) ambeintSoundoundSelection:(id) sender
{    
    
    CCMenuItemToggle *toggle = (CCMenuItemToggle *)sender;
	
	if(toggle.selectedIndex == 1) {
		[MazeSounds stopBackGroundSound];
        
		[GameSettings sharedGameSettings].ambientSoundStatus = NO;
	} else {
		
		[GameSettings sharedGameSettings].ambientSoundStatus = YES;
		[MazeSounds playBackGroundSound];
	}
	[[GameManager sharedGameManager] saveGameSettings];
		
}

- (void) soundEffectsSelection:(id) sender
{    
    
	CCMenuItemToggle *toggle=(CCMenuItemToggle *)sender;
	
	if(toggle.selectedIndex == 1) {
		[GameSettings sharedGameSettings].soundEffectsStatus = NO;
	} else {
		[GameSettings sharedGameSettings].soundEffectsStatus = YES;
	}
	[[GameManager sharedGameManager] saveGameSettings];
    
}



- (void) selectGameType: (id) sender
{
    
    [MazeSounds playButtonTap];
    
    CCMenuItemToggle *mf = (CCMenuItemToggle*) sender;
        
    if (isAcceleromterSelected && mf.tag == 1) {
        mf.selectedIndex = 0;
    } else if (isManualSelected && mf.tag == 2) {
        mf.selectedIndex = 0;
    } else if (!isAcceleromterSelected && mf.tag == 1 && isManualSelected) {
        mf.selectedIndex = 0;
        manual.selectedIndex = 1;
        isAcceleromterSelected = YES;
        isManualSelected = NO;
        [GameSettings sharedGameSettings].accelerometerStatus = YES;
        [GameSettings sharedGameSettings].manualStatus = NO;
        
        [GameManager sharedGameManager].gameControl = @"Accelerometer";
        
        [[GameManager sharedGameManager] saveGameSettings];
        
    } else if (!isManualSelected && mf.tag == 2 && isAcceleromterSelected) {
        
        mf.selectedIndex = 0;
        accelerometer.selectedIndex = 1;
        isManualSelected = YES;
        isAcceleromterSelected = NO;
        [GameSettings sharedGameSettings].accelerometerStatus = NO;
        [GameSettings sharedGameSettings].manualStatus = YES;
        
        [GameManager sharedGameManager].gameControl = @"Drag";
        
        [[GameManager sharedGameManager] saveGameSettings];
    }
    
}


- (void) dealloc
{
	NSLog(@"~ dealloc - OptionScene ~");
	
    [headerLayer release];
    [background release];
    [ambientSoundLabel release];
    [soundEffectsLabel release];
    [accelerometerLabel release];
    [manualLabel release];
    [counterHeading release];
    [soundHeading release];
    
    [soundEffects release];
    [ambientSound release];
    
    [accelerometer release];
    [manual release];
    
    [mainMenu release];
    [menu release];
    
	[super dealloc];
}

@end
