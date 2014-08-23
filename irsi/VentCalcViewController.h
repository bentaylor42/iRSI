//
//  VentCalcViewController.h
//  irsi
//
//  Created by Ben Taylor on 21/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "Nationalities.h"

@interface VentCalcViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (strong, nonatomic) IBOutlet UIButton *buttonBack;

@property (strong, nonatomic) IBOutlet UITextField *textField4Kg;

- (IBAction)textField4Kg:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *textField6Kg;

- (IBAction)textField6Kg:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *textField8Kg;

- (IBAction)textField8Kg:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *labelWeightType;

@property (strong, nonatomic) IBOutlet UITextField *weightDisplayTextBox;

@property (strong, nonatomic) IBOutlet UITextField *textfieldLabelLbs;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLabelStones;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLabelPounds;

@property (strong, nonatomic) IBOutlet UITextField *textfieldLabelMetres;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLabelCM;

@property (strong, nonatomic) IBOutlet UITextField *textfieldLabelFeet;

@property (strong, nonatomic) IBOutlet UITextField *textfieldLabelInches;

@property (strong, nonatomic) IBOutlet UISegmentedControl *selectorWeight;

@property (strong, nonatomic) IBOutlet UITextField *textFieldIBWLbs;

@property (strong, nonatomic) IBOutlet UITextField *textFieldIBWStones;

@property (strong, nonatomic) IBOutlet UITextField *textFieldIBWPounds;

- (IBAction)selectorWeight:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *selectorHeight;

- (IBAction)selectorHeight:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *genderSelector;

- (IBAction)genderSelector:(UISegmentedControl *) sender;

@property (strong, nonatomic) IBOutlet UILabel *label4kg;

@property (strong, nonatomic) IBOutlet UILabel *label6Kg;

@property (strong, nonatomic) IBOutlet UILabel *label8kg;

@property (strong, nonatomic) IBOutlet UILabel *labelAlsoConsier;

@property (strong, nonatomic) IBOutlet UILabel *labelARDSNetAdvice;

@end
