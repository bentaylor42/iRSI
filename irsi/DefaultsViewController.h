//
//  DefaultsViewController.h
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventLog.h"
#import "Patient.h"
#import "Nationalities.h"
#import "InductionAgents.h"
#import "DrugLog.h"

@interface DefaultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UISwitch * switchPHEM;

@property (strong, nonatomic) IBOutlet UISegmentedControl * segmentedHeight;

@property (strong, nonatomic) IBOutlet UISegmentedControl * segmentedWeight;

@property (strong, nonatomic) IBOutlet UITableView *tableDrugSelector;
@property (strong, nonatomic) IBOutlet UISegmentedControl * segmentedDrugDoseDisplayType;

@property (strong, nonatomic) IBOutlet UISwitch *switchCricoid;

@property (strong, nonatomic) IBOutlet UITextField *textFieldPreO2Min;

@property (strong, nonatomic) IBOutlet UITextField *textFieldPreO2Max;

@property (strong, nonatomic) IBOutlet UITextField *textFieldRocMin;

@property (strong, nonatomic) IBOutlet UITextField *textFieldRocMax;

@property (strong, nonatomic) IBOutlet UISwitch *switchBeepOn;

@property (strong, nonatomic) IBOutlet UISwitch *switchVibrateOn;

@property (strong, nonatomic) IBOutlet UISwitch *switchFlashOn;

@property (strong, nonatomic) IBOutlet UITextField *textFieldBeepInterval;

@property (strong, nonatomic) IBOutlet UITextField *textFieldVibrateInterval;

@property (strong, nonatomic) IBOutlet UITextField *textFieldFlashInterval;

@property (strong, nonatomic) IBOutlet UISwitch *switchPreO2Alert;

@property (strong, nonatomic) IBOutlet UISwitch *switchRocAlert;

@property (strong, nonatomic) IBOutlet UISwitch *switch30SAlert;

@property (strong, nonatomic) IBOutlet UIButton *buttonIA;

@property (strong, nonatomic) IBOutlet UILabel *labelIA;

- (IBAction)buttonIA:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *buttonRelaxant;

- (IBAction)buttonRelaxant:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *labelRelaxant;

@property (strong, nonatomic) IBOutlet UIButton *buttonVasopressor;

@property (strong, nonatomic) IBOutlet UILabel *labelVasopressor;

- (IBAction)buttonVasopressor:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *buttonAntimuscarininic;

- (IBAction)buttonAntimuscarininic:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *labelAntimuscarininc;

@property (strong, nonatomic) IBOutlet UIButton *buttonOngoingSed;

- (IBAction)buttonOngoingSedation:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *labelOnogingSedation;

@property (strong, nonatomic) IBOutlet UIView *viewDrugChoice;
@end
