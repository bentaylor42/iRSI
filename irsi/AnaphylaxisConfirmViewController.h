//
//  AnaphylaxisConfirmViewController.h
//  irsi
//
//  Created by Ben Taylor on 21/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnaphylaxisConfirmViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (strong, nonatomic) IBOutlet UIButton *buttonBack;

@property (strong, nonatomic) IBOutlet UILabel *labelRecognition;

@property (strong, nonatomic) IBOutlet UILabel *labelDifferentialDiagnosis;

@property (strong, nonatomic) IBOutlet UILabel *labelLookFor;

@property (strong, nonatomic) IBOutlet UIButton *buttonCollapse;
- (IBAction)buttonCollapse:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *buttonBronchospasm;
- (IBAction)buttonBronchospasm:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *buttonRash;
- (IBAction)buttonRash:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *buttonAirway;
- (IBAction)buttonAirway:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *buttonMoveOn;
- (IBAction)buttonMoveOn:(id)sender;

@end

