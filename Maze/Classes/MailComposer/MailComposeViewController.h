//
//  MailComposeViewController.h
//  QuraniAyaat
//
//  Created by Ashar Samdani on 11/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MailComposeViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	NSString *errorMessage;

}

@property(nonatomic,retain) NSString *errorMessage;
-(void)displayComposerSheetWith:(NSString*)subject message:(NSString*)message imageFileName:(NSString*)imageName andImage:(UIImage*)image;

-(void)sendEmail:(NSString*)subject message:(NSString*)message imageFileName:(NSString*)imageName andImage:(UIImage*)image;
@end
