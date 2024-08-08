//
//  GameScene.m
//  Maze
//
//  Created by Ali Zafar on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

@synthesize gameLayer;


- (id) init
{
	self = [super init];
	if (self != nil) {
		
		GameLayer *tempLayer=[[GameLayer alloc] init];
		self.gameLayer=tempLayer;
		[tempLayer release];
		[self addChild:gameLayer];
		
	}
	return self;
}



- (void) dealloc
{
	[gameLayer release];
	[super dealloc];
	
}


@end
