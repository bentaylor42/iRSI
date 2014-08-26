//
//  GenerateReportViewController.h
//  irsi
//
//  Created by Ben Taylor on 17/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "EventLog.h"
#import "Alerts.h"
#import "DrugLog.h"
#import "Nationalities.h"
#import "Interactions.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreText/CoreText.h>
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"

@interface GenerateReportViewController : UIViewController <UITextViewDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelTitleLabel;

@property (strong, nonatomic) IBOutlet UIButton *buttonBack;

@property (strong, nonatomic) IBOutlet UIButton *buttonFinished;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollerContent;

@property (strong, nonatomic) IBOutlet UIView *viewContent;

@property (strong, nonatomic) IBOutlet UITextView *textViewOne;

@end
