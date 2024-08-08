//
//  HighScore.m
//  Maze
//
//  Created by Ali Imran on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HighScore.h"


@implementation HighScore

@synthesize name, time;


- (id) init
{
    self = [super init];
    if (self != nil) {
        
    }
    
    return self;
}


- (HighScore *) initwithName: (NSString *) scorername Time: (int) scorertime
{
	
	self = [super init];
	
	if (self != nil) {
		
		self.name=scorername;
		self.time=scorertime;
	}
	
	return self;
	
	
}


- (void) encodeWithCoder: (NSCoder *) aCoder
{

	[aCoder encodeObject:name forKey:@"name"];
	[aCoder encodeInt:time forKey:@"time"];
	
	
}

- (id) initWithCoder: (NSCoder *) aDecoder
{
	self = [super init];
	
	if (self != nil) {
		
		self.name = [aDecoder decodeObjectForKey:@"name"];
		self.time = [aDecoder decodeIntForKey:@"time"];		
	}
	
	return self;
	
}



- (HighScore *) initwithDictionary: (NSDictionary *) dict
{
	
	self = [super init];
	
	if (self != nil) {
        self.name=[dict objectForKey:@"name"];
		self.time=[[dict objectForKey:@"time"] intValue];
	}
	
	return self;
	
}


- (void) dealloc
{
    [name release];
    [super dealloc];
}


@end
