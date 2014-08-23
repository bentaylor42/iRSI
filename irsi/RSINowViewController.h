//
//  RSINowViewController.h
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "EventLog.h"
#import "Interactions.h"
#import "IndicationsViewController.h"
#import "Nationalities.h"
#import "Alerts.h"
#import "DrugLog.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface RSINowViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *demographicsDropDown;

@property (strong, nonatomic) IBOutlet UILabel *labelDisplayWeight;

@property (strong, nonatomic) IBOutlet UILabel *labelBack;

@property (strong, nonatomic) IBOutlet UILabel *labelForward;

@property (strong, nonatomic) IBOutlet UILabel *labelPageTitle;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UIView *viewIndications;

@property (strong, nonatomic) IBOutlet UIView *viewDrugs;

@property (strong, nonatomic) IBOutlet UIView *viewEquipment;

@property (strong, nonatomic) IBOutlet UIView *viewTeam;

@property (strong, nonatomic) IBOutlet UIView *viewFinal;

@property (strong, nonatomic) IBOutlet UIView *viewScroll;

@property (strong, nonatomic) IBOutlet UIButton *buttonTabIndications;

@property (strong, nonatomic) IBOutlet UIButton *buttonTabDrugs;

@property (strong, nonatomic) IBOutlet UIButton *buttonTabEquipmet;

@property (strong, nonatomic) IBOutlet UIButton *buttonTabTeam;

@property (strong, nonatomic) IBOutlet UIButton *buttonTabFinal;

@property (strong, nonatomic) IBOutlet UILabel *labelMoveOn;

@property (strong, nonatomic) IBOutlet UILabel *labelDisplayVT;

@property (strong, nonatomic) IBOutlet UILabel *labelWeightSource;

@property (strong, nonatomic) IBOutlet UILabel *labelTubeSizeTitle;

@property (strong, nonatomic) IBOutlet UITextField *textFieldTubeSize;

@property (strong, nonatomic) IBOutlet UILabel *labelTubeLarger;

@property (strong, nonatomic) IBOutlet UILabel *labelTubeSmaller;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedCuffed;
@end
