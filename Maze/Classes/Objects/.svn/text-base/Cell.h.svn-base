//
//  Cell.h
//  Maze
//
//  Created by Ali Zafar on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Cell : NSObject <NSCoding> {

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
	
}

@property (readwrite)CGPoint centerPoint;
@property (readwrite)CGPoint point1;
@property (readwrite)CGPoint point2;
@property (readwrite)CGPoint point3;
@property (readwrite)CGPoint point4;

@property (readwrite)bool bottomline;
@property (readwrite)bool rightline;
@property (readwrite)bool topline;
@property (readwrite)bool leftline;

@property(readwrite)int cellNumber;
@property (readwrite)int visitState;



- (id) initWithCenterPoint:(CGPoint)center Width:(int)width andHeight:(int)height;

- (void) printCell;


@end
