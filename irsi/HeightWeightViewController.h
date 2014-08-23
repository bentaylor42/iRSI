//
//  HeightWeightViewController.h
//  irsi
//
//  Created by Ben Taylor on 21/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "Nationalities.h"

@interface HeightWeightViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *buttonBack;

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (strong, nonatomic) IBOutlet UITextField *weightDisplayTextBox;

@property (strong, nonatomic) IBOutlet UISegmentedControl *selectorWeight;

@property (strong, nonatomic) IBOutlet UITextField *textfieldLabelLbs;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLabelStones;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLabelPounds;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLabelCM;

@property (strong, nonatomic) IBOutlet UITextField *textfieldLabelFeet;

@property (strong, nonatomic) IBOutlet UITextField *textfieldLabelInches;

- (IBAction)selectorWeight:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *selectorHeight;

- (IBAction)selectorHeight:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *labelKgDisplay;

@property (strong, nonatomic) IBOutlet UILabel *labelStoneDisplay;

@property (strong, nonatomic) IBOutlet UILabel *labelPoundDisplay;

- (IBAction)buttonSaveWeight:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *buttonSaveWeight;

@property (strong, nonatomic) IBOutlet UILabel *labelCmDisplay;

@property (strong, nonatomic) IBOutlet UILabel *labelFeetDisplay;

@property (strong, nonatomic) IBOutlet UIButton *buttonSaveHeight;

- (IBAction)buttonSaveHeight:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *labelBMI;

@end
