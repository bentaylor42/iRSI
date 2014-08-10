//
//  DefaultsViewController.m
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "DefaultsViewController.h"

@interface DefaultsViewController ()

@end

@implementation DefaultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadDefaults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadDefaults
{
    // Synchronises locally saved defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    // Defines variables with default values
    bool phem = NO;
    NSInteger heightTypeSelected = 0;
    NSInteger weightTypeSelected = 0;
    NSInteger drugDisplayTypeSelected = 0;
    
    // Loads pre-saved data from NSUserDefaults
    if ([defaults objectForKey:@"PHEM"] != nil){phem = [defaults boolForKey:@"PHEM"];}
    if ([defaults objectForKey:@"heightTypeDefaultSelected"] != nil){heightTypeSelected = [defaults integerForKey:@"heightTypeDefaultSelected"];}
    if ([defaults objectForKey:@"weightTypeDefaultSelected"] != nil){weightTypeSelected = [defaults integerForKey:@"weightTypeDefaultSelected"];}
    if ([defaults objectForKey:@"drugDisplayTypeSelected"] != nil){drugDisplayTypeSelected = [defaults integerForKey:@"drugDisplayTypeSelected"];}
    
    // Defines the variables to singletons - if there is a pre-saved default, then saves it.  Else uses the pre-defined defaults
    EventLog *sharedPreHospital = [EventLog sharedPreHospital];
    
    [sharedPreHospital setPreHospital:[NSNumber numberWithBool:phem]];
    
    // Sets the controls in the desired setting
    self.switchPHEM.on = phem;
    self.segmentedHeight.selectedSegmentIndex = heightTypeSelected;
    self.segmentedWeight.selectedSegmentIndex = weightTypeSelected;
    self.segmentedDrugDoseDisplayType.selectedSegmentIndex = drugDisplayTypeSelected;
}

- (IBAction)segmentedPHEM:(id)sender
{
    
}

- (IBAction)segmentedHeightTypeSelected:(id)sender
{
    
}

- (IBAction)segmentedWeightTypeSelected:(id)sender
{
    
}

- (IBAction)segmentedDrugDoseDisplayType:(id)sender
{
    
}


@end
