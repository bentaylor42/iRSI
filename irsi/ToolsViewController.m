//
//  ToolsViewController.m
//  irsi
//
//  Created by Ben Taylor on 15/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "ToolsViewController.h"

@interface ToolsViewController ()

@end

@implementation ToolsViewController

NSString *back;
NSString *titleLabel;
NSString *rocClock;
NSString *paedsCalc;
NSString *heightWeight;
NSString *ventCalc;
NSString *toolsLocation;

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


- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    back = [NSString stringWithFormat:@"< %@",[dict objectForKey:@"Back"]];
    titleLabel = [dict objectForKey:@"UsefulTools"];
    rocClock = [dict objectForKey:@"RocClockButton"];
    paedsCalc = [dict objectForKey:@"PaedsCalc"];
    heightWeight = [dict objectForKey:@"HeightWeightCalc"];
    ventCalc = [dict objectForKey:@"VentCalc"];
    toolsLocation = [dict objectForKey:@"GPSPosition"];
    
    [self buttonBack].titleLabel.text = back;
    [self labelTitle].text = titleLabel;
    [self buttonRocClock].titleLabel.text = rocClock;
    [self buttonPaedsCalc].titleLabel.text = paedsCalc;
    [self buttonHeightWeight].titleLabel.text = heightWeight;
    [self buttonVentCalc].titleLabel.text = ventCalc;
    [self buttonGPS].titleLabel.text = toolsLocation;
}

 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([segue.identifier isEqualToString:@"segueMenuRoc"]){
         Interactions *sharedTransitionToRoc = [Interactions sharedTransitionToRoc];
         [sharedTransitionToRoc setTransitionToRoc:[NSNumber numberWithInt:0]];
     }
     if ([segue.identifier isEqualToString:@"segueToolsGPS"]){
         Interactions *sharedTransitionToGPS = [Interactions sharedTransitionToGPS];
         [sharedTransitionToGPS setTransitionToGPS:[NSNumber numberWithInt:0]];
     }
 }

@end
