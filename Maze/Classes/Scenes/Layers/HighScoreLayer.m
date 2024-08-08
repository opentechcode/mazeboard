//
//  HighScoreLayer.m
//  Maze
//
//  Created by Ali Imran on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HighScoreLayer.h"
#import "HighScore.h"


@implementation HighScoreLayer


- (id) init {
    self = [super init];
    if (self != nil) {
        
    }
    return self;
}


- (void) populateLayerWithArray: (NSMutableArray *) scores;
{
    [self removeAllChildrenWithCleanup:YES];
		
	int x = 150;
	int y = 1024 - 350;
	//int xShift = 200;
	int count = 0;
    
	for (HighScore *score in scores) {	
		x = 150;
		count += 1;
		
		CCLabelTTF *rank = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",count] fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE];
		[rank setColor:ccBLACK];
		[rank setPosition:CGPointMake(x, y)];
		[self addChild:rank];
		
		x = 385;
		
		CCLabelTTF *name = [CCLabelTTF labelWithString:score.name dimensions:CGSizeMake(150, 30) alignment:UITextAlignmentLeft fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE];
		[name setColor:ccBLACK];
		[name setPosition:CGPointMake(x, y - 7)];
		[self addChild:name];
		x = 550;
		
		
		CCLabelTTF *time=[CCLabelTTF labelWithString:[[Utility secondsToTimeConversion:score.time] retain] fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE];
		[time setColor:ccBLACK];
		[time setPosition:CGPointMake(x, y)];
		[self addChild:time];
		//x += xShift;
		
		
		y -= 35;
		
	}
}

- (void) dealloc {
    
    NSLog(@"~ dealloc - HighScoreLayer ~");
    
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}


@end
