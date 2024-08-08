//
//  ClearScoreLayer.m
//  Maze
//
//  Created by Ali Imran on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClearScoreLayer.h"
#import "MazeSounds.h"
#import "Constant.h"


@implementation ClearScoreLayer

@synthesize delegate, btnOK, btnCancel;

- (id) init
{
    self = [super init];
    if (self) {
        
        self.isTouchEnabled = YES;
        
        CCSprite *background = [CCSprite spriteWithFile:@"popupScreen.png"];
        [background setPosition: CGPointMake(768/2, 1024/2)];
        [self addChild:background];
        
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Clear Score?" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TITLE_SIZE+8];
        [label setPosition:CGPointMake(768/2, 1024/2 + 90)];
        [label setColor:ccc3(89, 23, 0)];
        [self addChild:label z:3];
        
        
        CCLabelTTF *message = [CCLabelTTF labelWithString:@"Are you sure you want to clear all scores?" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE + 4];
        [message setPosition:CGPointMake(768/2, 1024/2 + 25)];
        [message setColor:ccc3(89, 23, 0)];
        [self addChild:message z:3];
        
        
        btnOK = [CCMenuItemImage itemFromNormalImage:@"btn_yes_unpress.png" selectedImage:@"btn_yes_press.png" target:self selector:@selector(okPressed:)];
        [btnOK setPosition:CGPointMake(768/2 + 110, 1024/2 - 75)];
        
        btnCancel = [CCMenuItemImage itemFromNormalImage:@"btn_no_unpress.png" selectedImage:@"btn_no_press.png" target:self selector:@selector(cancelPressed:)];
        [btnCancel setPosition:CGPointMake(768/2 - 110, 1024/2 - 75)];
        
        CCMenu *menu = [CCMenu menuWithItems:btnOK, btnCancel, nil];
        [menu setPosition:CGPointMake(0,0)];
        [self addChild:menu];
        
        
    }
    return self;
}



- (void) okPressed: (id) sender
{
    [MazeSounds playButtonTap];
    [delegate removeClearScoreLayer:1];
    
}


- (void) cancelPressed: (id) sender
{
    [MazeSounds playButtonTap];
    [delegate removeClearScoreLayer:0];
    
}

/*
- (void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:YES];
}


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGRect okArea = CGRectMake(btnOK.position.x, btnOK.position.y, [btnOK boundingBox].size.width, [btnOK boundingBox].size.height);
    CGRect cancelArea = CGRectMake(btnCancel.position.x, btnCancel.position.y, [btnCancel boundingBox].size.width, [btnCancel boundingBox].size.height);
    
    if (CGRectContainsPoint(okArea, touchLocation) || CGRectContainsPoint(cancelArea, touchLocation)) {
        
        return NO;
    }
	return YES;
}
 
 */

- (void) dealloc {
    
    NSLog(@"~ dealloc - ClearScoreLayer ~");
    
    [super dealloc];
}

@end
