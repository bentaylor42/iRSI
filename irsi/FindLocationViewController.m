//
//  FindLocationViewController.m
//  irsi
//
//  Created by Ben Taylor on 16/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "FindLocationViewController.h"

@interface FindLocationViewController (){
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
    NSString * back;
    NSString * back2;
    NSString * latitude;
    NSString * longitude;
    NSString * address;
    NSString * pressButton;
    NSString * titleLabel;
    NSString * calcPosn;
    NSString * noSignal;
    NSString * poorSignal;
    NSString * locationSaved;
    NSString * signalError;
    
    bool locationSelected;
}

@end

@implementation FindLocationViewController

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
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    [self loadStrings];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
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
    back2 = [dict objectForKey:@"Back"];
    latitude = [dict objectForKey:@"Back"];
    longitude = [dict objectForKey:@"Back"];
    address = [dict objectForKey:@"Back"];
    pressButton = [dict objectForKey:@"Back"];
    titleLabel = [dict objectForKey:@"GPSPosition"];
    calcPosn = [dict objectForKey:@"calcPosn"];
    noSignal = [dict objectForKey:@"GPSUnavailable"];
    poorSignal = [dict objectForKey:@"GPSPoorSignal"];
    locationSaved = [dict objectForKey:@"locationSaved"];
    signalError = [dict objectForKey:@"signalError"];
    
    
    [self.buttonBackTop setTitle:back forState:UIControlStateNormal];
    [self.buttonBack setTitle:back2 forState:UIControlStateNormal];
    [self.buttonCalculate setTitle:calcPosn forState:UIControlStateNormal];
    self.labelTopTitle.text = titleLabel;
    
    [self.buttonCalculate.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.buttonCalculate.selected = NO;
}

- (IBAction)buttonCalculate:(id)sender {
    if ((locationSelected == YES) || (errorCalc == YES)){
        locationSelected = NO;
        errorCalc = NO;
        [locationManager startUpdatingLocation];
    }
    else{
        [locationManager stopUpdatingLocation];
        locationSelected = YES;
        [self.buttonCalculate setTitle:locationSaved forState:UIControlStateNormal];
    }
    [self.buttonCalculate.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.buttonCalculate.selected = NO;
}

bool errorCalc = NO;

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError: %@", error);
    //UIAlertView *errorAlert = [[UIAlertView alloc]
                               //initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[errorAlert show];
    errorCalc = YES;
    
    [self.buttonCalculate setTitle:signalError forState:UIControlStateNormal];
    [self.buttonCalculate setBackgroundImage:[UIImage imageNamed:@"RedBackgroundBorderedBlack.png"] forState:UIControlStateNormal];
    [self.buttonCalculate.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.buttonCalculate.selected = NO;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation == nil){
        [self.buttonCalculate setTitle:noSignal forState:UIControlStateNormal];
        [self.buttonCalculate setBackgroundImage:[UIImage imageNamed:@"RedBackgroundBorderedBlack.png"] forState:UIControlStateNormal];
        [self.buttonCalculate.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.buttonCalculate.selected = NO;
    }
    if (currentLocation.horizontalAccuracy > 163){
        [self.buttonCalculate setTitle:poorSignal forState:UIControlStateNormal];
        [self.buttonCalculate setBackgroundImage:[UIImage imageNamed:@"OrangeBackgroundBorderedBlack.png"] forState:UIControlStateNormal];
        [self.buttonCalculate.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.buttonCalculate.selected = NO;
    }
    else{
        [self.buttonCalculate setTitle:calcPosn forState:UIControlStateNormal];
        [self.buttonCalculate setBackgroundImage:[UIImage imageNamed:@"GreenBackgroundBorderedBlack.png"] forState:UIControlStateNormal];
        [self.buttonCalculate.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.buttonCalculate.selected = NO;
    }
    
    
    if (currentLocation != nil) {
        self.labelLongitude.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.labelLatitude.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
    EventLog *sharedLatRSI = [EventLog sharedLatRSI];
    EventLog *sharedLongRSI = [EventLog sharedLongRSI];
    EventLog *sharedJobAddress = [EventLog sharedJobAddress];
    EventLog *sharedGPSFix = [EventLog sharedGPSFix];
    
    [sharedLatRSI setLatRSI:[NSNumber numberWithDouble:currentLocation.coordinate.latitude]];
    [sharedLongRSI setLongRSI:[NSNumber numberWithDouble:currentLocation.coordinate.longitude]];
    [sharedGPSFix setGpsFix:[NSNumber numberWithBool:YES]];
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            NSString * jobAddress = [NSString stringWithFormat:@"\t%@\n\t%@\n\t%@\n\t%@\n\t%@",
                                 placemark.thoroughfare,
                                 placemark.locality,
                                 placemark.postalCode,
                                 placemark.administrativeArea,
                                 placemark.country];
            self.labelAddress.text = jobAddress;
            [sharedJobAddress setJobAddress:jobAddress];
        }
        
        else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}

- (IBAction)buttonBack:(id)sender {
    Interactions *sharedTransitionToGPS = [Interactions sharedTransitionToGPS];
    
    if ([[sharedTransitionToGPS transitionToGPS]integerValue] == 0){
        [self performSegueWithIdentifier:@"segueGPStoTools" sender:self];
    }
    if ([[sharedTransitionToGPS transitionToGPS]integerValue] == 1){
        [self performSegueWithIdentifier:@"segueGPStoConfirm" sender:self];
    }
}

@end
