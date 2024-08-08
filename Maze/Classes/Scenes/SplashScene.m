//
//  SplashScene.m
//  Maze
//
//  Created by Ali Zafar on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SplashScene.h"


@implementation SplashScene
@synthesize background;

- (id) init
{
	self = [super init];
	if (self != nil) {
		self.background=[CCSprite spriteWithFile:@"Default.png"];
		[background setPosition:CGPointMake(768/2, 1024/2)];
		[self addChild:background];
	}
	return self;
}

- (void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	[background release];
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
	[super dealloc];
}


@end
