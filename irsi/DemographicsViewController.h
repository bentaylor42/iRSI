//
//  DemographicsViewController.h
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "Nationalities.h"

@interface DemographicsViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerAge;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedWeight;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedHeight;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedGender;

@property (strong, nonatomic) IBOutlet UITextField *textFieldKg;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLbs;

@property (strong, nonatomic) IBOutlet UITextField *textFieldStones;

@property (strong, nonatomic) IBOutlet UITextField *textFieldPounds;

@property (strong, nonatomic) IBOutlet UITextField *textFieldCm;

@property (strong, nonatomic) IBOutlet UITextField *textFieldFeet;

@property (strong, nonatomic) IBOutlet UITextField *textFieldInches;

@property (strong, nonatomic) IBOutlet UILabel *labelBMI;

@end
