//
//  HeaderLayer.m
//  Maze
//
//  Created by Ali Imran on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "HeaderLayer.h"
#import "GameSettings.h"

@implementation HeaderLayer


@synthesize headerBar, background, headingSprite;

- (id) initWithHeading: (NSString *) heading
{
    self = [super init];
    if (self != nil) {
        
        self.background = [CCSprite spriteWithFile:@"bg_main.png"];
        [background setPosition:CGPointMake(768/2, 1024/2)];
        [self addChild:background];
        
        self.headingSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", heading]];
        [headingSprite setPosition:CGPointMake(CONST_HEADING_X, CONST_HEADING_Y)];
        [self addChild:headingSprite];
        
        //self.headerBar = [CCSprite spriteWithFile:@"header_bar.png"];
        //[headerBar setPosition:CGPointMake(CONST_HEADER_BAR_X, CONST_HEADER_BAR_Y)];
        //[self addChild:headerBar];
        
    }
    
    return self;
}


- (void) dealloc
{
    //NSLog(@"~ dealloc - HeaderLayer ~");
    
    [background release];
    [headingSprite release];
    //[headerBar release];
    [super dealloc];
}




@end
