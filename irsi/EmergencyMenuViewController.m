//
//  EmergencyMenuViewController.m
//  irsi
//
//  Created by Ben Taylor on 15/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "EmergencyMenuViewController.h"

@interface EmergencyMenuViewController (){
    NSString * back;
    NSString * emergencyGuidelines;
    NSString * failedIntubation;
    NSString * als;
    NSString * apls;
    NSString * anaphylaxis;
}

@end

@implementation EmergencyMenuViewController

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
    [self loadStrings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

}
*/

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    back = [NSString stringWithFormat:@"< %@",[dict objectForKey:@"Back"]];
    emergencyGuidelines = [dict objectForKey:@"EmergencyGuidelines"];
    failedIntubation = [dict objectForKey:@"failedIntubation"];
    als = [dict objectForKey:@"als"];
    apls = [dict objectForKey:@"apls"];
    anaphylaxis = [dict objectForKey:@"anaphylaxis"];
    
    [self buttonBack].titleLabel.text = back;
    [self labelTitle].text = emergencyGuidelines;
    [self buttonALS].titleLabel.text = als;
    [self buttonAnaphylaxis].titleLabel.text = anaphylaxis;
    [self buttonAPLS].titleLabel.text = apls;
    [self buttonFailedIntubation].titleLabel.text = failedIntubation;
}

- (IBAction)buttonBack:(id)sender {
    Interactions *sharedTransitionToEmergency = [Interactions sharedTransitionToEmergency];
    if ([[sharedTransitionToEmergency transitionToEmergency]integerValue] == 0){[self performSegueWithIdentifier:@"segueEmergencyHome" sender:self];}
    if ([[sharedTransitionToEmergency transitionToEmergency]integerValue] == 1){[self performSegueWithIdentifier:@"segueEmergencyRoc" sender:self];}
}
@end
