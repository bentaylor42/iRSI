//
//  AnaphylaxisFinalViewController.m
//  irsi
//
//  Created by Ben Taylor on 21/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "AnaphylaxisFinalViewController.h"

@interface AnaphylaxisFinalViewController ()

@end

@implementation AnaphylaxisFinalViewController

NSInteger age;
bool adultFU;

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
    
    Patient *sharedIsAdult = [Patient sharedIsAdult];
    Patient *sharedAge = [Patient sharedAge];
    
    age = [[sharedAge age] integerValue];
    adultFU = [[sharedIsAdult isAdult] boolValue];
    
    [self doses];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) doses
{
    if ((adultFU == YES) || (age >12))
    {
        _labelPiraton.text = [NSString stringWithFormat:@"10 mg"];
        _labelHydrocort.text = [NSString stringWithFormat:@"200 mg"];
    }
    else
    {
        if (age >= 6)
        {
            _labelPiraton.text = [NSString stringWithFormat:@"5 mg"];
            _labelHydrocort.text = [NSString stringWithFormat:@"100 mg"];
        }
        if (age < 6)
        {
            _labelPiraton.text = [NSString stringWithFormat:@"2.5 mg"];
            _labelHydrocort.text = [NSString stringWithFormat:@"50 mg"];
        }
    }
}


- (IBAction)buttonFinished:(id)sender {
    Interactions *sharedTransitionToEmergency = [Interactions sharedTransitionToEmergency];
    if ([[sharedTransitionToEmergency transitionToEmergency]integerValue] == 0){[self performSegueWithIdentifier:@"segueAnaphylaxisHome" sender:self];}
    if ([[sharedTransitionToEmergency transitionToEmergency]integerValue] == 1){[self performSegueWithIdentifier:@"segueAnaphylaxisRoc" sender:self];}
}
@end
