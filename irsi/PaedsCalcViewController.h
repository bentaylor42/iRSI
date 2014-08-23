//
//  PaedsCalcViewController.h
//  irsi
//
//  Created by Ben Taylor on 20/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Nationalities.h"
#import "EventLog.h"
#import "Patient.h"
#import "DrugLog.h"
#import "InductionAgents.h"

@interface PaedsCalcViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *agePicker;

@property (strong, nonatomic) IBOutlet UIButton *buttonClose;

@property (strong, nonatomic) IBOutlet UILabel *labelSelectAge;

@property (strong, nonatomic) IBOutlet UIView *viewPopDown;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *viewScrolledView;

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (strong, nonatomic) IBOutlet UIButton *buttonBack;

@property (strong, nonatomic) IBOutlet UIButton *buttonDisplayAge;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedWeight;

@property (strong, nonatomic) IBOutlet UITextField *textFieldKg;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLbs;

@property (strong, nonatomic) IBOutlet UITextField *textFieldStones;

@property (strong, nonatomic) IBOutlet UITextField *textFieldPounds;

@property (strong, nonatomic) IBOutlet UILabel *labelDefibEnergy;

@property (strong, nonatomic) IBOutlet UILabel *labelETTSize;

@property (strong, nonatomic) IBOutlet UITextField *textFieldTubeSize;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedCuffed;

@property (strong, nonatomic) IBOutlet UILabel *labelTubeSmaller;

@property (strong, nonatomic) IBOutlet UILabel *labelTubeLarger;

@property (strong, nonatomic) IBOutlet UILabel *labelOralLength;

@property (strong, nonatomic) IBOutlet UILabel *labelNasalLength;

@property (strong, nonatomic) IBOutlet UITextField *textFieldOralLength;

@property (strong, nonatomic) IBOutlet UITextField *textFieldNasalLength;

@property (strong, nonatomic) IBOutlet UILabel *labelTraumaBolus;

@property (strong, nonatomic) IBOutlet UILabel *labelMedicalBolus;

@property (strong, nonatomic) IBOutlet UIImageView *imageLorazepam;

@property (strong, nonatomic) IBOutlet UILabel *titleLorazepam;

@property (strong, nonatomic) IBOutlet UILabel *doseLabelLorazepam;

@property (strong, nonatomic) IBOutlet UITextField *textFieldLorazepamConc;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedDoseDisplayType;

@property (strong, nonatomic) IBOutlet UIImageView *imageAdrenaline;

@property (strong, nonatomic) IBOutlet UILabel *titleAdrenaline;

@property (strong, nonatomic) IBOutlet UILabel *doseLabelAdrenaline;

@property (strong, nonatomic) IBOutlet UITextField *textFieldAdrenalineConc;

@property (strong, nonatomic) IBOutlet UITextField *textFieldAdrenalineMinijet;

@property (strong, nonatomic) IBOutlet UIImageView *imageGlucose;

@property (strong, nonatomic) IBOutlet UILabel *titleGlucose;

@property (strong, nonatomic) IBOutlet UILabel *doseLabelGlucose;

@property (strong, nonatomic) IBOutlet UITextField *textFieldGlucoseConc;


@property (strong, nonatomic) IBOutlet UIImageView *imageAtropine;

@property (strong, nonatomic) IBOutlet UILabel *titleAtropine;

@property (strong, nonatomic) IBOutlet UILabel *doseLabelAtropine;

@property (strong, nonatomic) IBOutlet UITextField *textFieldAtropineConc;

@property (strong, nonatomic) IBOutlet UIImageView *imageSux;

@property (strong, nonatomic) IBOutlet UILabel *titleSux;

@property (strong, nonatomic) IBOutlet UILabel *doseLabelSux;

@property (strong, nonatomic) IBOutlet UITextField *textFieldSuxConc;

@property (strong, nonatomic) IBOutlet UILabel *labelMgLorazepam;

@property (strong, nonatomic) IBOutlet UILabel *labelMgAtropine;

@property (strong, nonatomic) IBOutlet UILabel *labelMgSux;

@end
