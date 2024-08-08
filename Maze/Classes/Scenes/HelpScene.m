//
//  HelpScene.m
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelpScene.h"
#import "Constant.h"
#import "GameManager.h"
#import "MazeSounds.h"

@implementation HelpScene

@synthesize backgroundImage, mainMenuButton, supportEmail, logo, headerLayer;

- (id) init
{
    if ((self = [super init])) {
		
        headerLayer = [[HeaderLayer alloc] initWithHeading:@"h_about"];
        [self addChild:headerLayer];
        		
		self.backgroundImage = [CCSprite spriteWithFile:@"aboutScreen.png"];
		[self addChild:self.backgroundImage];
        
		CCLabelTTF *label = [CCLabelTTF labelWithString:CONST_ABOUT_TEXT dimensions:CGSizeMake(650, 650) alignment:UITextAlignmentLeft fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE+6];
		
		[self addChild:label z:100];
		[label setPosition:CGPointMake(387, 500)];
		[label setColor:ccc3(89, 23, 0)];
		
		self.logo = [CCSprite spriteWithFile:@"logo.png"];
		[self addChild:logo];
		
		self.mainMenuButton = [CCMenuItemImage itemFromNormalImage:@"btn_mainmenu_unpress.png" selectedImage:@"btn_mainmenu_press.png"
													   target:self selector:@selector(mainMenu:)];
		
		self.supportEmail = [CCLabelTTF labelWithString:@"support@envisionstudios.biz" fontName:@"Arial" fontSize:24];
        [supportEmail setColor:ccc3(0, 0, 0)];
		[self addChild:supportEmail];
		
		[self setComponentsPositions];
		
		CCMenu *menu =[CCMenu menuWithItems:mainMenuButton, nil];
		[menu setPosition:CGPointMake(0, 0)];
		[self addChild:menu];
		
	}
	return self;
}


- (void) setComponentsPositions
{
	
    [backgroundImage setPosition:CGPointMake(768/2, 1024/2 - 5)];
	[logo setPosition:CGPointMake(768/2, 230)];
	[supportEmail setPosition:CGPointMake(768/2, 180)];
	[mainMenuButton setPosition:CGPointMake(CONST_MAINMENU_POSITION_X, CONST_MAINMENU_POSITION_Y)];
	
}


- (void) mainMenu:(id) sender
{    
	[MazeSounds playButtonTap];
	[[GameManager sharedGameManager]  mainMenuScene];
}


- (void) dealloc
{
	NSLog(@"~ dealloc - AboutScene ~");
    [headerLayer release];
    [backgroundImage release];
    [mainMenuButton release];
    [logo release];
    [supportEmail release];
	[super dealloc];
}

@end
