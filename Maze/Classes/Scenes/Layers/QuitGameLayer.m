//
//  QuitGameLayer.m
//  Maze
//
//  Created by Ali Imran on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuitGameLayer.h"
#import "MazeSounds.h"

@implementation QuitGameLayer

@synthesize delegate;


- (id) init
{
    self = [super init];
    if (self) {
        self.isTouchEnabled = YES;
        
        CCSprite *background = [CCSprite spriteWithFile:@"popupScreen.png"];
        [background setPosition: CGPointMake(768/2, 1024/2)];
        [self addChild:background];
        
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Quit Game!" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TITLE_SIZE+8];
        [label setPosition:CGPointMake(768/2, 1024/2 + 90)];
        [label setColor:ccc3(89, 23, 0)];
        [self addChild:label z:3];
        
        
        CCLabelTTF *message = [CCLabelTTF labelWithString:@"Are you sure you want to quit?" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE + 4];
        [message setPosition:CGPointMake(768/2, 1024/2 + 25)];
        [message setColor:ccc3(89, 23, 0)];
        [self addChild:message z:3];
        
        
        CCMenuItemImage *btnOK = [CCMenuItemImage itemFromNormalImage:@"btn_yes_unpress.png" selectedImage:@"btn_yes_press.png" target:self selector:@selector(yesPressed:)];
        [btnOK setPosition:CGPointMake(768/2 + 110, 1024/2 - 75)];
        
        CCMenuItemImage *btnCancel = [CCMenuItemImage itemFromNormalImage:@"btn_no_unpress.png" selectedImage:@"btn_no_press.png" target:self selector:@selector(noPressed:)];
        [btnCancel setPosition:CGPointMake(768/2 - 110, 1024/2 - 75)];
        
        CCMenu *menu = [CCMenu menuWithItems:btnOK, btnCancel, nil];
        [menu setPosition:CGPointMake(0,0)];
        [self addChild:menu];
    }
    return self;
}


- (void) yesPressed: (id) sender
{
    
    [MazeSounds playButtonTap];
    [delegate removeGameQuitLayer:1];
    
}



- (void) noPressed: (id) sender
{
    
    [MazeSounds playButtonTap];
    [delegate removeGameQuitLayer:0];
    
}



- (void)dealloc
{
    
    NSLog(@"~ dealloc - QuitGameLayer ~");
    [super dealloc];
    
}

@end
