//
//  AnaphylaxisInitialViewController.h
//  irsi
//
//  Created by Ben Taylor on 21/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@interface AnaphylaxisInitialViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *button72;
@property (strong, nonatomic) IBOutlet UIButton *button73;
@property (strong, nonatomic) IBOutlet UIButton *button74;
@property (strong, nonatomic) IBOutlet UIButton *button75;
@property (strong, nonatomic) IBOutlet UIButton *button76;
@property (strong, nonatomic) IBOutlet UIButton *button77;

@property (strong, nonatomic) IBOutlet UILabel *labelIMDose;
@property (strong, nonatomic) IBOutlet UILabel *labelIVDose;

@property (strong, nonatomic) IBOutlet UIButton *buttonPopOverDemographics;

@property (strong, nonatomic) IBOutlet UIView *popOverDemographics;

@property (strong, nonatomic) IBOutlet UITextField *weightDisplayTextBox;

@property (strong, nonatomic) IBOutlet UITextField *textfieldLabelLbs;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLabelStones;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLabelPounds;

@property (strong, nonatomic) IBOutlet UISegmentedControl *selectorWeight;

- (IBAction)selectorWeight:(id)sender;

@property (strong, nonatomic) IBOutlet UIPickerView *agePicker;
@end
