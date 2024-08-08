//
//  Wall.m
//  Maze
//
//  Created by Ali Imran on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Wall.h"


@implementation Wall

@synthesize wallorientation;


-(id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location spriteFrameName:(NSString *)spriteFrameName andOrientation:(int)orientation
{
	
	wallorientation=orientation;
	self = [super initWithSpace:theSpace location:location spriteFrameName:spriteFrameName];
	return self;
}


-(void)createBodyAtLocation:(CGPoint)location
{	
    
    body = cpBodyNewStatic();
    body->data = self;
    body->p = location;
    
    int num = 4;
	
	// varibles to adjust shading
	int heightdivisor=2;
	int widthdivisor=2;
	
	if (wallorientation==CONST_WALL_ORIENTATION_VERTICAL) {
		widthdivisor=6;
	}
	else {
		heightdivisor=6;
	}
	
    
    CGPoint verts[] =
    {   
        ccp(-self.contentSize.width/widthdivisor, -self.contentSize.height/heightdivisor),
        ccp(-self.contentSize.width/widthdivisor, self.contentSize.height/heightdivisor),
        ccp(self.contentSize.width/widthdivisor, self.contentSize.height/heightdivisor),
        ccp(self.contentSize.width/widthdivisor, -self.contentSize.height/heightdivisor)
        
    };
    
    shape = cpPolyShapeNew(body, num, verts, CGPointZero);
    shape->e = 0.6;
    shape->u = 0.0;
    shape->data = self;
    shape->group = 1;
    shape->collision_type = 1;
    cpSpaceAddShape(space, shape);
	
	[self setPosition:location];
	
	
}


- (void) dealloc
{
    //NSLog(@"~ dealloc - Wall ~");
    
    cpBodyFree(body);
    
    [super dealloc];
}


@end
