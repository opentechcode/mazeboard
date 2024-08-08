//
//  CPSprite.m
//  Maze
//
//  Created by Ali Zafar on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CPSprite.h"


@implementation CPSprite

@synthesize body;

-(id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location spriteFrameName:(NSString *)spriteFrameName
{
	CCTexture2D *tex=[[CCTexture2D alloc] initWithImage:[UIImage imageNamed:spriteFrameName]];
		self=[super initWithTexture:tex];
	[tex release];
	
	if (self!=nil) {
		space=theSpace;
		[self createBodyAtLocation:location];
		
	}
	
	return self;
	
}




-(void)createBodyAtLocation:(CGPoint)location
{
	float mass=1.0;
	body=cpBodyNew(mass, cpMomentForBox(mass, self.contentSize.width, self.contentSize.height));
	
	body->p=location;
	body->data=self;
	
	cpSpaceAddBody(space, body);
	
	// now create the shape
	
	shape=cpBoxShapeNew(body, self.contentSize.width, self.contentSize.height);
	shape->e=0.3;
	shape->u=1.0;
	shape->data=self;
	cpSpaceAddShape(space, shape);
	

	self.position=location;
}


-(void)setBodyLocationWithAccelerationFactor:(float)accel_filter andAcceleration:(UIAcceleration*)acceleration
{
	body->p=CGPointMake(body->p.x * accel_filter + acceleration.x * (1.0f - accel_filter) * 500.0f,body->p.y * accel_filter + acceleration.y * (1.0f - accel_filter) * 500.0f);
	
	
}

- (void) update
{

	
//	self.rotation=CC_RADIANS_TO_DEGREES(-1* body->a);
}



- (void) dealloc
{
    //NSLog(@"~ dealloc - CPSprite ~");
    
    [super dealloc];
}

@end
