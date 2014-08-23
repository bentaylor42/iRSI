//
//  ConfirmationViewController.h
//  irsi
//
//  Created by Ben Taylor on 15/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventLog.h"
#import "Alerts.h"
#import "Nationalities.h"
#import "Patient.h"
#import "Interactions.h"
#import "DrugLog.h"

@interface ConfirmationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *buttonGenerateReport;

@property (strong, nonatomic) IBOutlet UIButton *buttonFinished;

@property (strong, nonatomic) IBOutlet UITextField *textFieldOral;

@property (strong, nonatomic) IBOutlet UITextField *nasalLength;

@property (strong, nonatomic) IBOutlet UIButton *buttonGPS;

@property (strong, nonatomic) IBOutlet UILabel *labelTitleLabel;

@property (strong, nonatomic) IBOutlet UIButton *buttonBack;

@property (strong, nonatomic) IBOutlet UILabel *labelTubeLength;

@property (strong, nonatomic) IBOutlet UILabel *labelCLGrade;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedCLGrade;

@end
