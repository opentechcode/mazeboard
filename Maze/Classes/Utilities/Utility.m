//
//  Utility.m
//  iBattleships
//
//  Created by Sajjad Raza on 9/29/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//

#import "Utility.h"


@implementation Utility


+(int) getRandomNumberWithMinValue:(int)min maxValue:(int)max andSeed:(BOOL)seed
{
	int randmnumber=arc4random()%(max-min+1);
	randmnumber+=min;
	if (randmnumber>max) {
		randmnumber=max;
	}
	if (randmnumber<min) {
		randmnumber=min;
	}
	return randmnumber;
	
	
	
	int	number;	
	seed=NO;
	if(seed)
		srand( (unsigned)time( NULL ) );
	
    number = (((abs(rand())%(max-min+1))+min));    
    
    if(number>max)
		number = max;
	
    if(number<min)
    	number = min;
	
	return number;
	
	
	
}


+(void)simpleShuffle:(NSMutableArray *)array
{
	
	for (int i=0; i<[array count]; i++) {
		
		int randNumber=[Utility getRandomNumberWithMinValue:0 maxValue:[array count]-1 andSeed:NO];
		
		[array exchangeObjectAtIndex:i withObjectAtIndex:randNumber];	
		
		
	}
	
}

#pragma mark functio to get Neighbor cells

/*
 upper cell of the given cell number
 */


+(int)upperCell:(int)cellNumber
{
	cellNumber-=10;
	
	if (cellNumber<0) {
		return -1;
	}
	
	return cellNumber;
	
}


+(float) getDistanceCentrePointandTouch :(CGPoint)objPoint  TouchLocation:(CGPoint)point
{
	//CCSprite *dotSprite  = [CCSprite spriteWithFile:@"dot.png"];
	//[dotSprite setPosition:CGPointMake(ship.shipSprite.position.x,ship.shipSprite.position.y)];
	//[self addChild:dotSprite z:5];
	float shipCenterX = objPoint.x ;
	float shipCenterY = objPoint.y ;//- (ship.shipSprite.textureRect.size.height/2);
	
	float squareX = (point.x  - shipCenterX)*(point.x - shipCenterX);
	float squareY = (point.y  - shipCenterY)*(point.y - shipCenterY);
	
	return squareX + squareY ;
	
}

+(NSString *)integerToThreeDigitConversion:(int)number
{
	NSString *returnString;
	if (number<10) {
		returnString =[NSString stringWithFormat:@"00%d",number];
	}
	else if(number<100){
		returnString =[NSString stringWithFormat:@"0%d",number];
	}
	else {
		returnString =[NSString stringWithFormat:@"%d",number];
	}

	return [returnString retain];

	
}

+(NSString *)secondsToTimeConversion:(int)seconds
{
	int remainingseconds=seconds%60;
	int minutes=seconds/60;
	int hours=minutes/60;
	minutes=minutes%60;
	
	
	NSString *secondsString;
	NSString *minutesString;
	
	NSString *hoursString;
	
	
	if (remainingseconds<10) {
		
		secondsString=[NSString stringWithFormat:@"0%d",remainingseconds];
		
	}else {
		
		secondsString=[NSString stringWithFormat:@"%d",remainingseconds];
	}
	
	
	if (minutes<10) {
		minutesString=[NSString stringWithFormat:@"0%d",minutes];
	}else {
		
		minutesString=[NSString stringWithFormat:@"%d",minutes];
	}
	
	if (hours<10) {
		hoursString=[NSString stringWithFormat:@"0%d",hours];
	}else {
		
		hoursString=[NSString stringWithFormat:@"%d",hours];
	}
	
	NSString *timeString=[NSString stringWithFormat:@"%@:%@:%@",hoursString,minutesString,secondsString];
	
	//return [timeString autorelease];
    
    return timeString;
}

+(UIAlertView *)alertViewWithActivityIndicatorWithTitle:(NSString*)title andMessage:(NSString*)msg{
	
	UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
	[alertView addSubview:activityIndicator];
	[activityIndicator setFrame:CGRectMake(130, 90, 25, 25)];
	[activityIndicator startAnimating];
	[activityIndicator release];
	[alertView show];
	return [alertView autorelease];
	
}

+(void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString*)msg{
	
	UIAlertView *aV =[[UIAlertView alloc] initWithTitle:title message:msg 
											   delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[aV show];
	[aV release];
	
}

+(float)calculateAngleBetweenPoints:(CGPoint)firstTouch SecondTouch:(CGPoint) secondTouch
{
	NSLog(@"The First Point is x=%f y=%f",firstTouch.x,firstTouch.y);
	NSLog(@"The second Point is x=%f y=%f",secondTouch.x,secondTouch.y);
	
	float y = secondTouch.y - firstTouch.y;
	float x = secondTouch.x - firstTouch.x;
	
	float theta = atan(y/x);
	//convering the radian value to degrees
	theta =(theta *(180/3.142));
	NSLog(@"The value of the Theta %f",theta);
	return theta;
	
}

+(UIAlertView *)alertViewWithTitle:(NSString*)title andMessage:(NSString*)msg{
	
	UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
	[alertView show];
	return [alertView autorelease];
	
}

+(NSString*)getDeviceModel
{
	NSString *modelString = (NSString*)[UIDevice currentDevice].model;
	if([modelString rangeOfString:@"iPad"].location != NSNotFound)
	{
		return [NSString stringWithFormat:@"iPad"];
	}
	else 
	{
		return [NSString stringWithFormat:@"iPhone"];
	}
	
	
	return [UIDevice currentDevice].model;
}

+ (NSInteger) getSystemVersionAsAnInteger{
    int index = 0;
    NSInteger version = 0;
	
    NSArray* digits = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    NSEnumerator* enumer = [digits objectEnumerator];
    NSString* number=[enumer nextObject];
    while (number) {
        if (index>2) {
            break;
        }
        NSInteger multipler = powf(100, 2-index);
        version += [number intValue]*multipler;
        index++;
        number = [enumer nextObject];
    }
	return version;
}


@end
