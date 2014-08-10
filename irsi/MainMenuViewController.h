//
//  MainMenuViewController.h
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventLog.h"
#import "Nationalities.h"

@interface MainMenuViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelVersion;

@property (strong, nonatomic) IBOutlet UILabel *labelCopyright;

@property (strong, nonatomic) IBOutlet UISwitch *switchPHEM;

@property (strong, nonatomic) IBOutlet UILabel *labelPHEM;

@property (strong, nonatomic) IBOutlet UILabel *labelMissionStatement;

@property (strong, nonatomic) IBOutlet UIButton *buttonEmergency;

@property (strong, nonatomic) IBOutlet UIButton *buttonTools;

@property (strong, nonatomic) IBOutlet UIButton *buttonRSI;

@property (strong, nonatomic) IBOutlet UIButton *buttonSettings;

@property (strong, nonatomic) IBOutlet UILabel *labelAppTitle;

@end
