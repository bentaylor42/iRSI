//
//  CustomisationViewController.m
//  irsi
//
//  Created by Ben Taylor on 29/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "CustomisationViewController.h"

@interface CustomisationViewController ()

@end

@implementation CustomisationViewController

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
    
    [self loadDrugLabels];
}


-(void) loadDrugLabels
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedDrugLabels = [Nationalities sharedDrugLabels];
    Nationalities *sharedNationalityArray = [Nationalities sharedNationalityArray];
    
    if ([defaults objectForKey:@"Nationality"] != nil){[sharedNationality setNationality:[NSNumber numberWithInteger:[defaults integerForKey:@"Nationalities"]]];}
    
    // Find out path of druglabels.plist file
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NationalDrugLabels" ofType:@"plist"];
    
    // Get the string for the country name of the chosen country
    NSString *country = [[sharedNationalityArray nationalityArray] objectAtIndex:[[sharedNationality nationality] integerValue]];
    
    // Load the file content and read the data into an array
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    [sharedDrugLabels setDrugLabels:[dict objectForKey:country]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
