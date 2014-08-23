//
//  RocClockViewController.h
//  irsi
//
//  Created by Ben Taylor on 17/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Nationalities.h"
#import <QuartzCore/QuartzCore.h>
#import "EventLog.h"
#import "Alerts.h"
#import "Interactions.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface RocClockViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (strong, nonatomic) IBOutlet UIButton *buttonBack;

@property (strong, nonatomic) NSString *sourcePage;

@property (strong, nonatomic) IBOutlet UIView *viewDrugsGiven;

@property (strong, nonatomic) IBOutlet UIButton *buttonStartTube;

@property (strong, nonatomic) IBOutlet UIButton *buttonSuccessTube1;

@property (strong, nonatomic) IBOutlet UIView *viewIntubation;

@property (strong, nonatomic) IBOutlet UIButton *buttonSuccessTube2;

@property (strong, nonatomic) IBOutlet UIButton *buttonBig;

@property (strong, nonatomic) IBOutlet UIView *viewDisplayTime;

@property (strong, nonatomic) IBOutlet UILabel *labelInstructions;

@property (strong, nonatomic) IBOutlet UILabel *labelOtherInstructions;

@property (strong, nonatomic) IBOutlet UILabel *labelTimeDisplay;

@property (strong, nonatomic) IBOutlet UIButton *buttonStop;

@property (strong, nonatomic) IBOutlet UILabel *labelBigButton;

@property (strong, nonatomic) IBOutlet UIImageView *imageButtonBackground;

@property (strong, nonatomic) IBOutlet UIImageView *viewImageBorder;

@end
