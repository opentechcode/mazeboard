//
//  WinLayer.m
//  Maze
//
//  Created by Ali Imran on 6/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WinLayer.h"
#import "MazeSounds.h"
#import "GameSettings.h"
#import "GameManager.h"

@implementation WinLayer

@synthesize delegate, nameTextField, btnSave;

- (id) initWithTime: (int) seconds
{
    self = [super init];
	if (self != nil) {
        
        CCSprite *background=[CCSprite spriteWithFile:@"winScreen.png"];
        [background setPosition:CGPointMake(768/2,1024/2)];
        [self addChild:background z:2];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Well Done!!!" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TITLE_SIZE+8];
        [label setPosition:CGPointMake(768/2, 1024/2 + 100)];
        [label setColor:ccc3(89, 23, 0)];
        [self addChild:label z:3];
        
        
        CCLabelTTF *message = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You completed the Maze in %d seconds.", seconds] fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE + 6];
        [message setPosition:CGPointMake(768/2, 1024/2 + 25)];
        [message setColor:ccc3(89, 23, 0)];
        [self addChild:message z:3];
        
        CCLabelTTF *nameLabel = [CCLabelTTF labelWithString:@"Enter your name: " fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE + 6];
        [nameLabel setPosition:CGPointMake(768/2 - 170, 1024/2 - 50)];
        [nameLabel setColor:ccc3(89, 23, 0)];
        [self addChild:nameLabel z:3];
        
        CCSprite *nameTextSprite = [CCSprite spriteWithFile:@"img_text_box.png"];
        [nameTextSprite setPosition:CGPointMake(768/2 + 100, 1024/2 - 50)];
        [self addChild:nameTextSprite z:3];
        
        
        CCMenuItemImage *btnCancel = [CCMenuItemImage itemFromNormalImage:@"btn_cancel_unpress.png" 
                                                            selectedImage:@"btn_cancel_press.png"
                                                            target:self selector:@selector(cancelPressed:)]; 
        [btnCancel setPosition:CGPointMake(768/2 + 10, 1024/2 - 125)];
        
        btnSave = [CCMenuItemImage itemFromNormalImage:@"btn_save_unpress.png" selectedImage:@"btn_save_press.png"
                                                               target:self selector:@selector(savePressed:)]; 
        [btnSave setPosition:CGPointMake(768/2 + 210, 1024/2 - 125)];
        
        if ([[GameSettings sharedGameSettings].playerName isEqualToString:@""]) {
            btnSave.visible = NO;
        }
        
        CCMenu *menu = [CCMenu menuWithItems:btnCancel, btnSave, nil];
        [menu setPosition:CGPointMake(0, 0)];
        [self addChild:menu z:3];
        
        UITextField *tempTextField = [[UITextField alloc] initWithFrame:CGRectMake(325, 1024/2 + 38, 320, 27)];
		self.nameTextField = tempTextField;
		[tempTextField release];
		
		[nameTextField setBorderStyle:UITextBorderStyleNone];
		[nameTextField setFont:[UIFont systemFontOfSize:18]];
		[nameTextField setBackgroundColor:[UIColor clearColor]];
        [nameTextField setTextColor:[UIColor whiteColor]];
		[nameTextField setKeyboardType:UIKeyboardTypeASCIICapable];
		nameTextField.delegate = self;
        
    }
    
    return self;
}




- (id) initLostLayer
{
    self = [super init];
	if (self != nil) {
        
        CCSprite *background=[CCSprite spriteWithFile:@"winScreen.png"];
        [background setPosition:CGPointMake(768/2,1024/2)];
        [self addChild:background z:2];
        
        CCLabelTTF *goodJob = [CCLabelTTF labelWithString:@"Sorry!!!" fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TITLE_SIZE + 10];
        [goodJob setPosition:CGPointMake(768/2, 1024/2 + 100)];
        [goodJob setColor:ccc3(89, 23, 0)];
        [self addChild:goodJob z:3];
        
        CCLabelTTF *message = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You have lost the game."] fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE + 6];
        [message setPosition:CGPointMake(768/2, 1024/2 + 25)];
        [message setColor:ccc3(89, 23, 0)];
        [self addChild:message z:3];
        
        CCMenuItemImage *btnCancel = [CCMenuItemImage itemFromNormalImage:@"btn_OK_unpress.png" 
                                                            selectedImage:@"btn_OK_press.png"
                                                                   target:self selector:@selector(cancelPressed:)]; 
        [btnCancel setPosition:CGPointMake(768/2, 1024/2 - 125)];
        
        CCMenu *menu = [CCMenu menuWithItems:btnCancel, nil];
        [menu setPosition:CGPointMake(0, 0)];
        [self addChild:menu z:3];
        
    }
    
    return self;
}



- (id) initTiedLayer
{
    self = [super init];
	if (self != nil) {
        CCSprite *background=[CCSprite spriteWithFile:@"winScreen.png"];
        [background setPosition:CGPointMake(768/2,1024/2)];
        [self addChild:background z:2];
        
        CCLabelTTF *goodJob = [CCLabelTTF labelWithString:@" " fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TITLE_SIZE + 10];
        [goodJob setPosition:CGPointMake(768/2, 1024/2 + 100)];
        [goodJob setColor:ccc3(89, 23, 0)];
        [self addChild:goodJob z:3];
        
        CCLabelTTF *message = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"The match is tied."] fontName:CONST_STRING_FONT_NAME fontSize:CONST_FONT_TEXT_SIZE + 6];
        [message setPosition:CGPointMake(768/2, 1024/2 + 25)];
        [message setColor:ccc3(89, 23, 0)];
        [self addChild:message z:3];
        
        CCMenuItemImage *btnCancel = [CCMenuItemImage itemFromNormalImage:@"btn_OK_unpress.png" 
                                                            selectedImage:@"btn_OK_press.png"
                                                                   target:self selector:@selector(cancelPressed:)]; 
        [btnCancel setPosition:CGPointMake(768/2, 1024/2 - 125)];
        
        CCMenu *menu = [CCMenu menuWithItems:btnCancel, nil];
        [menu setPosition:CGPointMake(0, 0)];
        [self addChild:menu z:3];
    }
    return self;
}



- (BOOL)textField:(UITextField *) mytextField shouldChangeCharactersInRange:(NSRange) range replacementString:(NSString*) string
// return NO to not change text
{
	//NSLog(@"%@", string);
	
	if( ([mytextField.text length] > 12 && ![string isEqualToString:@""]) || ([string isEqualToString:@" "] && [mytextField.text length] == 0)) {
		return NO;
	} else if ([mytextField.text length] == 0 ) {
		
		btnSave.visible = YES;
		
	}   else if([mytextField.text length] == 1 && [string isEqualToString:@""] ){
        btnSave.visible = NO; 
	}  else {
		btnSave.visible = YES;
	}
	return YES;
	
}


- (void) addTextBox:(NSString *) name
{
	nameTextField.text = name;
	UIViewController *viewController=(UIViewController *)[(AppDelegate *)[UIApplication sharedApplication].delegate viewController];
	[viewController.view addSubview:nameTextField];
	[nameTextField becomeFirstResponder];
}


- (void) cancelPressed:(id) sender
{
    [MazeSounds playButtonTap];
	[delegate removeWinLayer];
}

- (void) savePressed:(id) sender
{
    [MazeSounds playButtonTap];
    
    [GameSettings sharedGameSettings].playerName = nameTextField.text;
    [[GameManager sharedGameManager] saveGameSettings];
    [delegate saveName:nameTextField.text];
    [self.nameTextField removeFromSuperview];
    [delegate removeWinLayer];
    
    // fb manager
    
    [[GameManager sharedGameManager] initFBManager:[GameManager sharedGameManager].finishTime andLevel:[GameManager sharedGameManager].difficultyLevel];
    
}


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}

- (void) dealloc
{
    NSLog(@"~ dealloc - WinLayer ~");
    [nameTextField removeFromSuperview];
    [nameTextField release];
    [super dealloc];
    
}

@end
