//
//  Cell.m
//  Maze
//
//  Created by Ali Zafar on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Cell.h"


@implementation Cell
@synthesize centerPoint, point1, point2, point3, point4;
@synthesize bottomline,rightline,topline,leftline;
@synthesize cellNumber,visitState;


- (id) initWithCenterPoint:(CGPoint)center Width:(int)width andHeight:(int)height
{
	self = [super init];
	if (self != nil) {
		
		self.centerPoint=center;
		self.point1=CGPointMake(center.x-width/2,center.y-height/2); // left bottom
		self.point2=CGPointMake(center.x+width/2,center.y-height/2); // right bottom
		self.point3=CGPointMake(center.x+width/2,center.y+height/2); // right upper			
		self.point4=CGPointMake(center.x-width/2,center.y+height/2); // left upper
		
		self.visitState=CONST_CELL_VISITED_STATE_NOT_VISITED;
		
		self.bottomline=YES;
		self.rightline=YES;
		self.topline=YES;
		self.leftline=YES;
		
								
	}
	return self;
}


- (void) printCell
{
    NSLog(@"cellNumber = %d", self.cellNumber);
    NSLog(@"centerPoint.x = %f", self.centerPoint.x);
    NSLog(@"centerPoint.y = %f", self.centerPoint.y);

}



/*
 CGPoint centerPoint;
 CGPoint point1;
 CGPoint point2;
 CGPoint point3;
 CGPoint point4;
 
 // The following boolean variable defines which line to draw and which to skip
 bool bottomline;    // point 1 and point 2
 bool rightline;     // point 2 and point 3
 bool topline;       // point 3 and point 4
 bool leftline ;     // point 4 and point 1
 
 int cellNumber;
 int visitState;
 
 */

- (void) encodeWithCoder: (NSCoder *) aCoder
{
    
    [aCoder encodeCGPoint:centerPoint forKey:@"centerPoint"];
    [aCoder encodeCGPoint:point1 forKey:@"point1"];
    [aCoder encodeCGPoint:point2 forKey:@"point2"];
    [aCoder encodeCGPoint:point3 forKey:@"point3"];
    [aCoder encodeCGPoint:point4 forKey:@"point4"];
    
    [aCoder encodeBool:bottomline forKey:@"bottomline"];
    [aCoder encodeBool:rightline forKey:@"rightline"];
    [aCoder encodeBool:topline forKey:@"topline"];
    [aCoder encodeBool:leftline forKey:@"leftline"];
    
    [aCoder encodeInt:cellNumber forKey:@"cellNumber"];
    [aCoder encodeInt:visitState forKey:@"visitState"];
    
}

- (id) initWithCoder: (NSCoder *) aDecoder
{
	self = [super init];
	
	if (self != nil) {
		
        self.centerPoint = [aDecoder decodeCGPointForKey:@"centerPoint"];
        self.point1 = [aDecoder decodeCGPointForKey:@"point1"];
        self.point2 = [aDecoder decodeCGPointForKey:@"point2"];
        self.point3 = [aDecoder decodeCGPointForKey:@"point3"];
        self.point4 = [aDecoder decodeCGPointForKey:@"point4"];
        
        self.bottomline = [aDecoder decodeBoolForKey:@"bottomline"];
        self.rightline = [aDecoder decodeBoolForKey:@"rightline"];
        self.topline = [aDecoder decodeBoolForKey:@"topline"];
        self.leftline = [aDecoder decodeBoolForKey:@"leftline"];
        
        self.cellNumber = [aDecoder decodeIntForKey:@"cellNumber"];
        self.visitState = [aDecoder decodeIntForKey:@"visitState"];
        
	}
	
	return self;
	
}


- (void) dealloc
{
    
    [super dealloc];
}


@end
