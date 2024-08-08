//
//  Ball.m
//  Maze
//
//  Created by Ali Zafar on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"


@implementation Ball


-(id)initWithSpace:(cpSpace *)theSpace location:(CGPoint)location spriteFrameName:(NSString *)spriteFrameName
{
	self = [super initWithSpace:theSpace location:location spriteFrameName:spriteFrameName];
	
	return self;
}

-(void)createBodyAtLocation:(CGPoint)location
{
	
	float mass = 1.0;
    body = cpBodyNew(mass, cpMomentForBox(mass, self.contentSize.width, self.contentSize.height));
    body->p = location;
    body->data = self;
    cpSpaceAddBody(space, body);
	
    shape = cpCircleShapeNew(body, self.contentSize.width/2, cpvzero);
    shape->e = 0.4; 
    shape->u = 0.5;
    shape->data = self;
    shape->group = 3;
    shape->collision_type = 3;
    cpSpaceAddShape(space, shape);
	
	[self setPosition:location];
	
}

- (void)update {    
    self.position = body->p;
    self.rotation = CC_RADIANS_TO_DEGREES(-1 * body->a);
}

-(void)applyForce:(CGPoint)force
{
	body->f = force;
}

/*
-(void) setPosition:(CGPoint) p{
    [super setPosition:p];
    if (self->body != nil) {
        self->body->p.x = p.x;
        self->body->p.y = p.y;
        //Note: also call cpSpaceRehash to let Chipmunk know about the new position
        
        //cpSpaceRehash();
    }
}
*/



- (void) dealloc
{
    NSLog(@"~ dealloc - Ball ~");
    
    [super dealloc];
}

@end
