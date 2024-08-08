//
//  CPSprite.h
//  Maze
//
//  Created by Ali Zafar on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chipmunk.h"

@interface CPSprite : CCSprite {
	
	cpBody *body;
	cpShape *shape;
	cpSpace *space;
    
}



@property (assign) cpBody *body;

-(id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location spriteFrameName:(NSString *)spriteFrameName;
-(void)update;
-(void)createBodyAtLocation:(CGPoint)location;
-(void)setBodyLocationWithAccelerationFactor:(float)accel_filter andAcceleration:(UIAcceleration*)acceleration;

@end
