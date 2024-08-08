//
//  MazeManager.m
//  Maze
//
//  Created by Ali Zafar on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MazeManager.h"


@implementation MazeManager
@synthesize cells,cellsPerLine;

- (id) init
{
	self = [super init];
	if (self != nil) {
		
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		self.cells = tempArray;
		[tempArray release];
		
        cellcount = 0;
	}
	return self;
}



- (void) createLevel: (NSString *) level
{
    if ([level isEqualToString:@"easy"]) {
        [self createCellsWithCellPerLine:15 Width:720 Height:840 StartPoint:CGPointMake(22, 76)]; 
		//[self createCellsWithCellPerLine:15 Width:750 Height:930 StartPoint:CGPointMake(9, 5)];
		
    } else if ([level isEqualToString:@"medium"]) {
        
		[self createCellsWithCellPerLine:20 Width:720 Height:840 StartPoint:CGPointMake(22, 76)];
		//[self createCellsWithCellPerLine:20 Width:740 Height:920 StartPoint:CGPointMake(14, 5)];
		
		
		
    } else {
		
        [self createCellsWithCellPerLine:24 Width:724 Height:844 StartPoint:CGPointMake(22, 76)];
		// [self createCellsWithCellPerLine:25 Width:750 Height:925 StartPoint:CGPointMake(9, 5)];
		
    }
    
    
    
    //NSLog(@"Level Created !!");
}

-(void)createCellsWithCellPerLine:(int)cellperline Width:(int)width Height:(int)height StartPoint:(CGPoint)startPoint
{
    
	self.cellsPerLine=cellperline;
	int cellwidth=width/cellperline;
	int cellheight=height/cellperline;
	
    //	
    //    NSLog(@"cellWidth = %d", cellwidth);
    //    NSLog(@"cellHeight = %d", cellheight);
    
    
	CGPoint centerOfFirstSquare = CGPointMake(startPoint.x+cellwidth/2, startPoint.y+cellheight/2);
	
	int count=1;
	for (int i=0; i<cellperline; i++) {
		
		for (int j=0; j<cellperline; j++) {
			
			CGPoint squareCenter= CGPointMake(centerOfFirstSquare.x+j*cellwidth, centerOfFirstSquare.y + i*cellheight); 
			
			//NSLog(@"squareNumber:%d....Position: (%f, %f)" , count ,  squareCenter.x  , squareCenter.y);
			
			Cell *cell=[[Cell alloc] initWithCenterPoint:squareCenter Width:cellwidth andHeight:cellheight];
			cell.cellNumber=count-1;
			
						
			count++;
			[cells addObject:cell];
			[cell release];
			
		}
	}
	
}


-(void)runBacktrackAlgorithm
{
	
	int startNumber=[Utility getRandomNumberWithMinValue:0 maxValue:([cells count]-1) andSeed:NO];
	
	[self backTrackForCell:startNumber];
	
	Cell *cell=[cells objectAtIndex:cellsPerLine-1];
	
		cell.leftline=NO;
		cell.topline=NO;
	
	cell=[cells objectAtIndex:cellsPerLine-2];
	
	cell.rightline=NO;
	cell=[cells objectAtIndex:cellsPerLine*2-1];
	
	cell.bottomline=NO;
    
    
    //NSLog(@"Backtrack Algorithm !!");
	
}


-(void)backTrackForCell:(int)cellNumber
{
	
	Cell *cell=[cells objectAtIndex:cellNumber];
	cell.visitState=CONST_CELL_VISITED_STATE_VISITED;
	
	cellcount++;
	
	NSMutableArray *neighbors=[self getNeighborsofCell:cellNumber];
	
	[Utility simpleShuffle:neighbors];
    
	for (NSDictionary *dict in neighbors) {
		
		Cell *cellNeighbor=[dict objectForKey:CONST_CELL_KEY_CELL];
		
		if (cellNeighbor.visitState==CONST_CELL_VISITED_STATE_NOT_VISITED) {
			int neighbor_type=[[dict objectForKey:CONST_CELL_KEY_NEIGHBOR] intValue];
			
			
            if (neighbor_type == CONST_CELL_NEIGHBOR_BOTTOM) {
                cell.bottomline = NO;
                cellNeighbor.topline = NO;
                
            }
            else if (neighbor_type == CONST_CELL_NEIGHBOR_RIGHT) {
                cell.rightline = NO;
                cellNeighbor.leftline = NO;
                
            }
            else if (neighbor_type == CONST_CELL_NEIGHBOR_TOP) {
                cell.topline = NO;
                cellNeighbor.bottomline = NO;
            }
            else if (neighbor_type == CONST_CELL_NEIGHBOR_LEFT) {
                cell.leftline = NO;
                cellNeighbor.rightline = NO;
            }
			
			
            [self backTrackForCell:cellNeighbor.cellNumber];
            
		}
		
	}
	
}

-(NSMutableArray *)getNeighborsofCell:(int)cellNumber{
    
    
	NSMutableArray *neighbors = [[NSMutableArray alloc] init];
	
	int leftNeighbor=-1;
	int rightNeighbor=-1;
	int bottomNeighbor=-1;
	int topNeighbor=-1;
	
	
	if (cellNumber>=cellsPerLine) {
		bottomNeighbor=cellNumber-cellsPerLine;
		
		NSDictionary *dict=[[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:[cells objectAtIndex:bottomNeighbor],[NSNumber numberWithInt:CONST_CELL_NEIGHBOR_BOTTOM],nil] forKeys:[NSArray arrayWithObjects:CONST_CELL_KEY_CELL,CONST_CELL_KEY_NEIGHBOR,nil]];
		[neighbors addObject:dict];
        [dict release];
        
	}
	
	if ((cellNumber)%cellsPerLine != (cellsPerLine-1)) {
		rightNeighbor=cellNumber+1;
		
		NSDictionary *dict=[[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:[cells objectAtIndex:rightNeighbor],[NSNumber numberWithInt:CONST_CELL_NEIGHBOR_RIGHT],nil] forKeys:[NSArray arrayWithObjects:CONST_CELL_KEY_CELL,CONST_CELL_KEY_NEIGHBOR,nil]];
		[neighbors addObject:dict];
        [dict release];
		
	}
	
	if (cellNumber<=([cells count]-1-cellsPerLine )) {
		
		topNeighbor=cellNumber+cellsPerLine;
		
		NSDictionary *dict=[[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:[cells objectAtIndex:topNeighbor],[NSNumber numberWithInt:CONST_CELL_NEIGHBOR_TOP],nil] forKeys:[NSArray arrayWithObjects:CONST_CELL_KEY_CELL,CONST_CELL_KEY_NEIGHBOR,nil]];
		[neighbors addObject:dict];
		[dict release];
	}
	
	if ((cellNumber)%cellsPerLine != 0) {
		
		leftNeighbor=cellNumber-1;
		
		NSDictionary *dict=[[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:[cells objectAtIndex:leftNeighbor],[NSNumber numberWithInt:CONST_CELL_NEIGHBOR_LEFT],nil] forKeys:[NSArray arrayWithObjects:CONST_CELL_KEY_CELL,CONST_CELL_KEY_NEIGHBOR,nil]];
		[neighbors addObject:dict];
		[dict release];
	}
	
    
    //	NSLog(@"CellNumber: %d........Neighbore: Bottom:%d, Right:%d, Top:%d, Left:%d",cellNumber, bottomNeighbor,rightNeighbor, topNeighbor,leftNeighbor);
    
	return [neighbors autorelease];
}



-(NSMutableArray *)getConnectorsDetails
{
    
	NSMutableArray *connectors = [[NSMutableArray alloc] init];
    
    
    float leftTeeOffsetX = -5.0;
    float leftTeeOffsetY = 3;
    
    //float rightTeeOffsetX = 10;
    //float rightTeeOffsetY = .5;
    
    float topTeeOffsetX = 0;
    float topTeeOffsetY = 5;
    
    //float bottomTeeOffsetX = 10;
    //float bottomTeeOffsetY = 10;
    
    //////
    
    float bottomRightElbowOffsetX = 5.25;
    float bottomRightElbowOffsetY = 2.25;
    
    float bottomLeftElbowOffsetX = 1;
    float bottomLeftElbowOffsetY = 2;
    
    float topRightElbowOffsetX = 1;
    float topRightElbowOffsetY = 0;
    
    float topLeftElbowOffsetX = 2;
    float topLeftElbowOffsetY = 6;
	
	for (Cell *cell in cells) {
        
        
		int bottomNeighbor=-1;
		int rightNeighbor=-1;
		int leftNeighbor=-1;
		
		BOOL rightLineExist=NO;
		BOOL leftLineExist=NO;
        
        
        Cell *rightCell = nil;
        Cell *leftCell = nil;
        
		
		if ((cell.cellNumber)%cellsPerLine != (cellsPerLine-1)) {
			rightNeighbor=cell.cellNumber+1;
			rightCell=[cells objectAtIndex:rightNeighbor];
			
			if (rightCell.bottomline) {
				rightLineExist=YES;
			}
		}
		
		if ((cell.cellNumber)%cellsPerLine != 0) {
			
			leftNeighbor=cell.cellNumber-1;
			leftCell=[cells objectAtIndex:leftNeighbor];
			
			if (leftCell.bottomline) {
				leftLineExist=YES;
			}
			
		}
		
		if (cell.cellNumber >= cellsPerLine) {
			bottomNeighbor=cell.cellNumber-cellsPerLine;
		} else {
            /*
            if (cell.bottomline && cell.rightline && rightCell.bottomline ) {
                [self fillConnectorArray:connectors withType:@"topTee" andPosX:cell.point2.x + topTeeOffsetX andPosY:cell.point2.y + topTeeOffsetY];
                NSLog(@"topTee");
                
            }*/
            
            continue;
		}
        
		Cell *bottomCell=[cells objectAtIndex:bottomNeighbor];
		
		// This is for right part (point 2 of cell)
		
		if (bottomCell.rightline && cell.rightline && cell.bottomline && !rightLineExist) {
			
			// left tee connector  at cell.point2
            
            [self fillConnectorArray:connectors withType:@"leftTee" andPosX:cell.point2.x + leftTeeOffsetX andPosY:cell.point2.y + leftTeeOffsetY];
            
		} else if (cell.rightline && cell.bottomline && !rightLineExist) {
			//top right elbow connector
            
            [self fillConnectorArray:connectors withType:@"topRightElbow" andPosX:cell.point2.x + topRightElbowOffsetX andPosY:cell.point2.y - topRightElbowOffsetY];
			
		} else if(bottomCell.rightline && cell.bottomline && !rightLineExist) {
			//bottom right elbow
            
            [self fillConnectorArray:connectors withType:@"bottomRightElbow" andPosX:cell.point2.x + bottomRightElbowOffsetX andPosY:cell.point2.y + bottomRightElbowOffsetY];
            
		} else if(bottomCell.rightline && cell.rightline && cell.bottomline && rightLineExist) {
			// tee top and tee bottom both
            
            [self fillConnectorArray:connectors withType:@"topTee" andPosX:cell.point2.x andPosY:cell.point2.y + topTeeOffsetY];
            //[self fillConnectorArray:connectors withType:@"bottomTee" andPosX:cell.point2.x andPosY:cell.point2.y - bottomTeeOffsetY];
            
		} else if( cell.rightline && cell.bottomline && rightLineExist) {
			// tee top 
            
            [self fillConnectorArray:connectors withType:@"topTee" andPosX:cell.point2.x + topTeeOffsetX andPosY:cell.point2.y + topTeeOffsetY];
            
        } else if(bottomCell.rightline  && cell.bottomline && rightLineExist) {
			// tee bottom
            
            //[self fillConnectorArray:connectors withType:@"bottomTee" andPosX:cell.point2.x andPosY:cell.point2.y - bottomTeeOffsetY];
            
		} else if (cell.rightline && cell.bottomline && rightCell.leftline && rightCell.bottomline ) {
            [self fillConnectorArray:connectors withType:@"topTee" andPosX:cell.point2.x andPosY:cell.point2.y + topTeeOffsetY];
        }
        
        
        
        /////////////   
        
        
        if (cell.bottomline && rightCell.bottomline) {
            [self fillConnectorArray:connectors withType:@"v_line" andPosX:cell.point2.x andPosY:cell.point2.y];
        }
        
        if (cell.leftline && bottomCell.leftline) {
            [self fillConnectorArray:connectors withType:@"h_line" andPosX:cell.point1.x andPosY:cell.point1.y];
        }
        
        
        ////////////////
        
        
        
		//////// This is for left side (Point 1)
        
		if (bottomCell.leftline && cell.leftline && cell.bottomline && !leftLineExist) {
			
			// right tee connector
            
            //[self fillConnectorArray:connectors withType:@"rightTee" andPosX:cell.point1.x + rightTeeOffsetX andPosY:cell.point1.y - rightTeeOffsetY];
            
		} else if (cell.leftline && cell.bottomline && !leftLineExist) {
			//top left elbow connector
            
            [self fillConnectorArray:connectors withType:@"topLeftElbow" andPosX:cell.point1.x - topLeftElbowOffsetX andPosY:cell.point1.y - topLeftElbowOffsetY];
            
		} else if (bottomCell.leftline && cell.bottomline && !leftLineExist) {
			
			// bottom left elbow
            
            [self fillConnectorArray:connectors withType:@"bottomLeftElbow" andPosX:cell.point1.x - bottomLeftElbowOffsetX andPosY:cell.point1.y + bottomLeftElbowOffsetY];
            
		} else if (bottomCell.leftline && cell.leftline && cell.bottomline && leftLineExist) {
			// tee connector top and bottom
            
            [self fillConnectorArray:connectors withType:@"topTee" andPosX:cell.point1.x andPosY:cell.point1.y + topTeeOffsetY];
            //[self fillConnectorArray:connectors withType:@"bottomTee" andPosX:cell.point1.x andPosY:cell.point1.y - bottomTeeOffsetY];
            
		} else if (cell.leftline && cell.bottomline && leftLineExist) {
			// tee connector top
            
            [self fillConnectorArray:connectors withType:@"topTee" andPosX:cell.point1.x andPosY:cell.point1.y + topTeeOffsetY];
            
		} else if (bottomCell.leftline && cell.bottomline && leftLineExist) {
			// tee connector bottom
            
            //[self fillConnectorArray:connectors withType:@"bottomTee" andPosX:cell.point1.x andPosY:cell.point1.y - bottomTeeOffsetY];
        }    
        
	}
    
  	return [connectors autorelease];
    
}


- (void) fillConnectorArray: (NSMutableArray *) connectors withType: (NSString *) type andPosX: (float) posX andPosY: (float) posY
{
    NSMutableDictionary *connectorDetails = [[NSMutableDictionary alloc] init];
    
    [connectorDetails setObject:[NSNumber numberWithFloat:posX] forKey:@"posX"];
    [connectorDetails setObject:[NSNumber numberWithFloat:posY] forKey:@"posY"];
    [connectorDetails setObject:type forKey:@"type"];
    
    [connectors addObject:connectorDetails];
    
    [connectorDetails release];
}


- (void) dealloc
{
    NSLog(@"~ dealloc - MazeManager ~");
    
	[cells removeAllObjects];
	[cells release];
	[super dealloc];
}


@end

