//
//  DASFailedMaskViewController.h
//  iRSILastWorkingVersion
//
//  Created by Ben Taylor on 23/06/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@interface DASFailedMaskViewController : UIViewController

- (IBAction)selectorWeight:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *selectorWeight;

@property (strong, nonatomic) IBOutlet UITextField *weightDisplayTextBox;

@property (strong, nonatomic) IBOutlet UITextField *textfieldLabelLbs;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLabelStones;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLabelPounds;

@property (strong, nonatomic) IBOutlet UITextField *sugammadexConc;

- (IBAction)sugammadexConc:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *labelSugammadexVol;

@property (strong, nonatomic) IBOutlet UILabel *labelSugammadexVials;

@end
