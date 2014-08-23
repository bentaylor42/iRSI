//
//  iRSISettingsFeedbackViewController.h
//  iRSILastWorkingVersion
//
//  Created by Ben Taylor on 15/06/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>

@interface iRSISettingsFeedbackViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *facebookLinkButton;
- (IBAction)facebookLink:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *twitterLinkButton;
- (IBAction)twitterLink:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *googlePlusLinkButton;
- (IBAction)googlePlusLink:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *emailLinkButton;
- (IBAction) emailLink:(id)sender;

@end
