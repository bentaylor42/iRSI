//
//  RSINowViewController.m
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "RSINowViewController.h"

@interface RSINowViewController ()
{
    NSArray *pageListingRSI;
}

@end

@implementation RSINowViewController

// Declaring local variables
bool demographicsDown = NO;
NSInteger pageNumberRSI = 1;
NSTimer *tabUpdate;
NSTimer * updateVT;
NSTimer *alertTimer;

// Declares the strings used on this page
NSString * back;
NSString * forward;
NSString * indications;
NSString * drugs;
NSString * equipment;
NSString * team;
NSString * final;
NSString * startRSI;
NSString * moveOn;
NSString * weightDisplayStatement;
NSString * male;
NSString * female;
NSString * adult;
NSString * child;
NSString * displayVT;
NSString * sourceVTestimate;
NSString * sourceVTentered;
NSString * sourceVTIBW;
NSString * tubeSizeTitle;
NSString * enter;
NSString * cuffed;
NSString * unCuffed;

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
    
    [self updateNavigation];
    
    self.scrollview.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewIndications.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewDrugs.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewEquipment.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewTeam.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewFinal.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewScroll.translatesAutoresizingMaskIntoConstraints = NO;
    
    tabUpdate = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkTabColour) userInfo:nil repeats:YES];
    
    [self checkUpdates];
    
    updateVT = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkUpdates) userInfo:nil repeats:YES];
    
    [self loadVT];
    
    alertTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(preO2Alerts) userInfo:nil repeats:YES];
    
    [self loadTubeSize];
    
    Patient *sharedIsCuffedTube = [Patient sharedIsCuffedTube];
    if ([[sharedIsCuffedTube isCuffedTube] boolValue] == YES){self.segmentedCuffed.selectedSegmentIndex = 0;}
    else {self.segmentedCuffed.selectedSegmentIndex = 1;}
    
    self.labelTubeSmaller.hidden = YES;
    self.labelTubeLarger.hidden = YES;
    
    [self createKeyboardReturnButton];
}

-(void) createKeyboardReturnButton
{
    //Creates a custom keypad with a return button
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 35.0f)];
    toolbar.barStyle=UIBarStyleDefault;
    
    // Create a flexible space to align buttons to the right
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //Create a cancel button to dismiss the keyboard
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
    
    // Add buttons to the toolbar
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, barButtonItem, nil]];
    
    // Set the toolbar as accessory view of an UITextField object
    _textFieldTubeSize.inputAccessoryView = toolbar;

    return;
}

-(void) dismissKeyboard:(id) sender
{
    if ([_textFieldTubeSize isFirstResponder]){
        [_textFieldTubeSize resignFirstResponder];
    }
    
    return;
}

// minimises keyboard on tapping elsewhere on screen
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([_textFieldTubeSize isFirstResponder] && [touch view]!= _textFieldTubeSize) {
        [_textFieldTubeSize resignFirstResponder];
    }
    
    return;
}

- (void) loadTubeSize{
    Patient *sharedIsAdult = [Patient sharedIsAdult];
    Patient *sharedAge = [Patient sharedAge];
    Patient *sharedIsCuffedTube = [Patient sharedIsCuffedTube];
    Patient *sharedTubeSize = [Patient sharedTubeSize];
    
    if ([[sharedIsAdult isAdult]boolValue] == NO){
        self.labelTubeLarger.hidden = NO;
        self.labelTubeSmaller.hidden = NO;
        [self.segmentedCuffed setEnabled:YES forSegmentAtIndex:1];
        float rawTubeSize = (([[sharedAge age]floatValue]/4) + 4);
        if ([[sharedIsCuffedTube isCuffedTube]boolValue] == YES){rawTubeSize = (rawTubeSize - 1);}
        if ((rawTubeSize - (int) rawTubeSize) == 0.25){rawTubeSize = (int) rawTubeSize;}
        if ((rawTubeSize - (int) rawTubeSize) == 0.75){rawTubeSize = ((int) rawTubeSize) +0.5;}
        self.textFieldTubeSize.placeholder = [NSString stringWithFormat:@"%.1f", rawTubeSize];
        if ([[sharedTubeSize tubeSize]floatValue] >0){
            rawTubeSize = [[sharedTubeSize tubeSize] floatValue];
            self.textFieldTubeSize.text = [NSString stringWithFormat:@"%.1f", rawTubeSize];
        }
        self.labelTubeSmaller.text = [NSString stringWithFormat:@"%.1f", (rawTubeSize - 0.5)];
        self.labelTubeLarger.text = [NSString stringWithFormat:@"%.1f", (rawTubeSize + 0.5)];
    }
    else{
        self.labelTubeSmaller.hidden = YES;
        self.labelTubeLarger.hidden = YES;
        self.segmentedCuffed.selectedSegmentIndex = 0;
        [sharedIsCuffedTube setIsCuffedTube:[NSNumber numberWithBool:YES]];
        [self.segmentedCuffed setEnabled:NO forSegmentAtIndex:1];
        if ([[sharedTubeSize tubeSize]floatValue] >0){
            self.textFieldTubeSize.text = [NSString stringWithFormat:@"%.1f", [[sharedTubeSize tubeSize] floatValue]];
        }
        else {self.textFieldTubeSize.placeholder = enter;}
    }
}

- (void) preO2Alerts{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    bool beepOn = YES;
    bool flashOn = YES;
    bool vibrateOn = YES;
    bool preO2Alert = YES;
    
    NSInteger preO2Min = 180;
    NSInteger preO2Max = 300;
    
    if ([defaults objectForKey:@"preO2Min"] != nil){preO2Min = [defaults integerForKey:@"preO2Min"];}
    if ([defaults objectForKey:@"preO2Max"] != nil){preO2Max = [defaults integerForKey:@"preO2Max"];}
    if ([defaults objectForKey:@"beepOn"] != nil){beepOn = [defaults boolForKey:@"beepOn"];}
    if ([defaults objectForKey:@"vibrateOn"] != nil){vibrateOn = [defaults boolForKey:@"vibrateOn"];}
    if ([defaults objectForKey:@"flashOn"] != nil){flashOn = [defaults boolForKey:@"flashOn"];}
    if ([defaults objectForKey:@"preO2Alert"] != nil){preO2Alert = [defaults boolForKey:@"preO2Alert"];}
    
    Alerts *sharedPreO2AlertOn = [Alerts sharedPreO2AlertOn];
    Alerts *sharedPreO2Alert1 = [Alerts sharedPreO2Alert1];
    Alerts *sharedPreO2Alert2 = [Alerts sharedPreO2Alert2];
    EventLog *sharedPreO2Start = [EventLog sharedPreO2Start];
    EventLog *sharedPreO2Running = [EventLog sharedPreO2Running];
    
   if (([[sharedPreO2AlertOn preO2AlertOn]boolValue] == YES) && ([[sharedPreO2Running preO2Running]boolValue] == YES) && (preO2Alert == YES)){
        // Calculates elapsed time
        double timeElapsed = CACurrentMediaTime() - [[sharedPreO2Start preO2Start] doubleValue];
        bool ping = NO;
        if ((timeElapsed >= preO2Min) && ([[sharedPreO2Alert1 preO2Alert1]boolValue] == NO)){
            ping = YES;
            [sharedPreO2Alert1 setPreO2Alert1:[NSNumber numberWithBool:YES]];
        }
        if ((timeElapsed >= preO2Max) && ([[sharedPreO2Alert2 preO2Alert2]boolValue] == NO)){
            ping = YES;
            [sharedPreO2Alert2 setPreO2Alert2:[NSNumber numberWithBool:YES]];
        }
        if (ping == YES){
            if (beepOn == YES){AudioServicesPlaySystemSound(1005);}
            if (vibrateOn == YES){AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);}
            if (flashOn == YES){
                // makes the screen flash briefly yellow
                UIView *flashview = [[UIView alloc] initWithFrame:self.view.bounds];
                flashview.backgroundColor = [UIColor yellowColor];
                [self.view addSubview:flashview];
                [UIView animateWithDuration:0.7 delay:0.1 options:0 animations:^{flashview.alpha = 0.0f;}completion:^(BOOL finished) {
                    [flashview removeFromSuperview];}];
                
                // Flashes the torch after checking it is available on the used device
                AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
                if ([device hasTorch] == YES)
                {
                    [device lockForConfiguration:nil];
                    [device setTorchMode:AVCaptureTorchModeOn];
                    [NSThread sleepForTimeInterval:1.0f];
                    [device setTorchMode:AVCaptureTorchModeOff];
                    [device unlockForConfiguration];
                }
            }
            ping = NO;
        }
    }
    else{return;}
}

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    back = [dict objectForKey:@"Back"];
    forward = [dict objectForKey:@"Forward"];
    indications = [dict objectForKey:@"Indications"];
    drugs = [dict objectForKey:@"Drugs"];
    equipment = [dict objectForKey:@"Equipment"];
    team = [dict objectForKey:@"Team"];
    final = [dict objectForKey:@"Final"];
    moveOn = [dict objectForKey:@"MoveOn"];
    weightDisplayStatement = [dict objectForKey:@"WeightDisplayStatement"];
    male = [dict objectForKey:@"Male"];
    female = [dict objectForKey:@"Female"];
    child = [dict objectForKey:@"Child"];
    startRSI = [dict objectForKey:@"StartRSI"];
    displayVT = [dict objectForKey:@"VTDisplay"];
    sourceVTestimate = [dict objectForKey:@"VTSourceEstWt"];
    sourceVTentered = [dict objectForKey:@"VTSourceTotalWt"];
    sourceVTIBW = [dict objectForKey:@"VTSourceIBW"];
    tubeSizeTitle = [dict objectForKey:@"tubeSizeTitle"];
    enter = [dict objectForKey:@"enter"];
    cuffed = [dict objectForKey:@"CuffedTube"];
    unCuffed = [dict objectForKey:@"UncuffedTube"];
    
    pageListingRSI = @[back, indications, drugs, equipment, team, final, startRSI];
    
    self.labelMoveOn.text = moveOn;
    self.labelTubeSizeTitle.text = tubeSizeTitle;
    self.textFieldTubeSize.placeholder = enter;
    [self.segmentedCuffed setTitle:cuffed forSegmentAtIndex:0];
    [self.segmentedCuffed setTitle:unCuffed forSegmentAtIndex:1];
}

- (void) checkUpdates{
    Interactions *sharedDemographicsOpen = [Interactions sharedDemographicsOpen];
    if ([[sharedDemographicsOpen demographicsOpen]boolValue] == YES){
        [self loadVT];
    }
    return;
}

- (void) loadVT{
    Patient *sharedIbwKnown = [Patient sharedIbwKnown];
    Patient *sharedIdealBodyWeight = [Patient sharedIdealBodyWeight];
    Patient *sharedWeightKnown = [Patient sharedWeightKnown];
    Patient *sharedWeight = [Patient sharedWeight];
    
    float weight;
    NSInteger vT6Kg;
    NSInteger vT8Kg;
    
    if ([[sharedIbwKnown ibwKnown]boolValue] == YES){
        self.labelWeightSource.text = sourceVTIBW;
        weight = [[sharedIdealBodyWeight idealBodyWeight] floatValue];
        self.labelDisplayVT.backgroundColor = [UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0];
        self.labelWeightSource.backgroundColor = [UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0];
    }
    
    else if ([[sharedWeightKnown weightKnown] boolValue] == YES){
        self.labelWeightSource.text = sourceVTentered;
        weight = [[sharedWeight weight] floatValue];
        self.labelDisplayVT.backgroundColor = [UIColor colorWithRed:255/255.0f green:204/255.0f blue:0/255.0f alpha:1.0f];
        self.labelWeightSource.backgroundColor = [UIColor colorWithRed:255/255.0f green:204/255.0f blue:0/255.0f alpha:1.0f];
    }
    
    else if ([[sharedWeightKnown weightKnown] boolValue] == NO){
        self.labelWeightSource.text = sourceVTestimate;
        weight = [[sharedWeight weight]floatValue];
        self.labelDisplayVT.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0];
        self.labelWeightSource.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0];
    }
    
    vT6Kg = (weight * 6);
    vT8Kg = (weight * 8);
    
    self.labelDisplayVT.text = [NSString stringWithFormat:displayVT,vT6Kg, vT8Kg];
    
    return;
}

- (IBAction)buttonClose:(id)sender{
    Patient *sharedIsAdult = [Patient sharedIsAdult];
    Patient *sharedWeight = [Patient sharedWeight];
    Patient *sharedIsFemale = [Patient sharedIsFemale];
    NSString *gender;
    if ([[sharedIsFemale isFemale] boolValue] == YES){gender = female;}
    if ([[sharedIsFemale isFemale] boolValue] == NO){gender = male;}
    NSString *adultAge;
    if ([[sharedIsAdult isAdult] boolValue] == YES){adultAge = adult;}
    if ([[sharedIsAdult isAdult] boolValue] == NO){adultAge = child;}
    
    _labelDisplayWeight.text = [NSString stringWithFormat:weightDisplayStatement, [[sharedWeight weight] intValue], gender, adultAge];
    
    CGRect newFrame = _demographicsDropDown.frame;
    newFrame.origin.y -= 500;
    
    [UIView animateWithDuration:1.0 animations:^{_demographicsDropDown.frame = newFrame;}];
    
    demographicsDown = NO;
    
    Interactions *sharedDemographicsOpen = [Interactions sharedDemographicsOpen];
    [sharedDemographicsOpen setDemographicsOpen:[NSNumber numberWithBool:NO]];
    [self loadTubeSize];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonDropDemographics:(id)sender
{
    CGRect newFrame = _demographicsDropDown.frame;
    newFrame.origin.y += 500;
    
    [UIView animateWithDuration:1.0 animations:^{_demographicsDropDown.frame = newFrame;}];
    demographicsDown = YES;
    
    [self.view bringSubviewToFront:_demographicsDropDown];
    
    Interactions *sharedDemographicsOpen = [Interactions sharedDemographicsOpen];
    [sharedDemographicsOpen setDemographicsOpen:[NSNumber numberWithBool:YES]];
}

- (IBAction)swipeUp:(id)sender {
    if (demographicsDown == YES)
    {
        Patient *sharedIsAdult = [Patient sharedIsAdult];
        Patient *sharedWeight = [Patient sharedWeight];
        Patient *sharedIsFemale = [Patient sharedIsFemale];
        NSString *gender;
        if ([[sharedIsFemale isFemale] boolValue] == YES){gender = female;}
        if ([[sharedIsFemale isFemale] boolValue] == NO){gender = male;}
        NSString *adultAge;
        if ([[sharedIsAdult isAdult] boolValue] == YES){adultAge = adult;}
        if ([[sharedIsAdult isAdult] boolValue] == NO){adultAge = child;}
        
        _labelDisplayWeight.text = [NSString stringWithFormat:weightDisplayStatement, [[sharedWeight weight] intValue], gender, adultAge];
        
        CGRect newFrame = _demographicsDropDown.frame;
        newFrame.origin.y -= 500;
        
        [UIView animateWithDuration:1.0 animations:^{_demographicsDropDown.frame = newFrame;}];
        
        demographicsDown = NO;
        
        Interactions *sharedDemographicsOpen = [Interactions sharedDemographicsOpen];
        [sharedDemographicsOpen setDemographicsOpen:[NSNumber numberWithBool:NO]];
        [self loadTubeSize];
    }
    return;
}

- (IBAction)panDemographics:(id)sender {
    if (demographicsDown == NO)
    {
        CGRect newFrame = _demographicsDropDown.frame;
        newFrame.origin.y += 500;
        
        [UIView animateWithDuration:1.0 animations:^{_demographicsDropDown.frame = newFrame;}];
        demographicsDown = YES;
        
        [self.view bringSubviewToFront:_demographicsDropDown];
        
        Interactions *sharedDemographicsOpen = [Interactions sharedDemographicsOpen];
        [sharedDemographicsOpen setDemographicsOpen:[NSNumber numberWithBool:YES]];
    }
    return;
}

- (void) updateNavigation
{
    NSInteger backNumber = pageNumberRSI -1;
    NSInteger forwardNumber = pageNumberRSI +1;
    NSString *backLabel = [pageListingRSI objectAtIndex:backNumber];
    NSString *forwardLabel = [pageListingRSI objectAtIndex:forwardNumber];
    NSString *now = [pageListingRSI objectAtIndex:pageNumberRSI];
    _labelBack.text = [NSString stringWithFormat:@"< %@", backLabel];
    _labelForward.text = [NSString stringWithFormat:@"%@ >", forwardLabel];
    _labelPageTitle.text = now;
    
    [self updatePage];
    [self updateTabs];
    
    if (pageNumberRSI <5){self.labelMoveOn.text = moveOn;}
    if (pageNumberRSI == 5){self.labelMoveOn.text = startRSI;}
    
    return;
}

- (IBAction)buttonBack:(id)sender {
   
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    
    if (([[sharedNODESATWindowOpen nodesatWindowOpen] boolValue] == NO) && ([[sharedAirwayWindowOpen airwayWindowOpen] boolValue] == NO))
    {
        if (pageNumberRSI == 1){[self performSegueWithIdentifier:@"segueRSItoHome" sender:self];}
        if (pageNumberRSI >1)
        {
            pageNumberRSI --;
            [self updateNavigation];
        }
        if (pageNumberRSI <1){pageNumberRSI = 1; [self updateNavigation];}
    }
    
    if ([[sharedAirwayWindowOpen airwayWindowOpen] boolValue] == YES)
    {
        [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    }
    
    if ([[sharedNODESATWindowOpen nodesatWindowOpen] boolValue] == YES)
    {
        [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    }
    
    return;
}

- (IBAction)buttonForward:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    if (pageNumberRSI == 5){[self performSegueWithIdentifier:@"segueRSItoRoc" sender:self];}
    if (pageNumberRSI <5)
    {
        pageNumberRSI ++;
        [self updateNavigation];
    }
    if (pageNumberRSI >5){pageNumberRSI = 5; [self updateNavigation];}
    
    return;
}
- (IBAction)swipeRight:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    if (pageNumberRSI == 1){[self performSegueWithIdentifier:@"segueRSItoHome" sender:self];}
    if (pageNumberRSI >1)
    {
        pageNumberRSI --;
        [self updateNavigation];
    }
    if (pageNumberRSI <1){pageNumberRSI = 1; [self updateNavigation];}
    
    return;
}

- (IBAction)swipeLeft:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    if (pageNumberRSI == 5){[self performSegueWithIdentifier:@"segueRSItoRoc" sender:self];}
    if (pageNumberRSI <5)
    {
        pageNumberRSI ++;
        [self updateNavigation];
    }
    if (pageNumberRSI >5){pageNumberRSI = 5; [self updateNavigation];}
    
    return;
}

- (void) updatePage
{
    self.viewIndications.hidden = YES;
    self.viewDrugs.hidden = YES;
    self.viewEquipment.hidden = YES;
    self.viewTeam.hidden = YES;
    self.viewFinal.hidden = YES;
    self.viewScroll.hidden = YES;
    
    switch (pageNumberRSI) {
        case 1:
            self.viewIndications.hidden = NO;
            self.viewScroll.hidden = NO;
            [self.view bringSubviewToFront:_viewIndications];
            break;
            
        case 2:
            self.viewDrugs.hidden = NO;
            [self.view bringSubviewToFront:_viewDrugs];
            break;
            
        case 3:
            self.viewEquipment.hidden = NO;
            [self.view bringSubviewToFront:_viewEquipment];
            break;
            
        case 4:
            self.viewTeam.hidden = NO;
            [self.view bringSubviewToFront:_viewTeam];
            break;
            
        case 5:
            self.viewFinal.hidden = NO;
            [self.view bringSubviewToFront:_viewFinal];
            break;
            
        default:
            break;
    }
    
    return;
}
- (IBAction)buttonMoveOn:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    
    if ([[sharedAirwayWindowOpen airwayWindowOpen] boolValue] == YES)
    {
        [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
        [self.scrollview setContentOffset:CGPointZero animated:YES];
    }
    
    if ([[sharedNODESATWindowOpen nodesatWindowOpen] boolValue] == YES)
    {
        [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
        [self.scrollview setContentOffset:CGPointZero animated:YES];
    }
    
    else{
        if (pageNumberRSI == 5){[self performSegueWithIdentifier:@"segueRSItoRoc" sender:self];}
        if (pageNumberRSI <5)
        {
            pageNumberRSI ++;
            [self updateNavigation];
        }
        if (pageNumberRSI >5){pageNumberRSI = 5; [self updateNavigation];}
    }
    
    return;
}

- (IBAction)buttonTabIndications:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    pageNumberRSI = 1;
    
    [self updateNavigation];
    
    return;
}

- (IBAction)buttonTabDrugs:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    pageNumberRSI = 2;
    
    [self updateNavigation];
    
    return;
}

- (IBAction)buttonTabEquipment:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    pageNumberRSI = 3;
    
    [self updateNavigation];
    
    return;
}

- (IBAction)buttonTabTeam:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    pageNumberRSI = 4;
    
    [self updateNavigation];
    
    return;
}

- (IBAction)buttonTabFinal:(id)sender {
    Interactions *sharedAirwayWindowOpen = [Interactions sharedAirwayWindowOpen];
    Interactions *sharedNODESATWindowOpen = [Interactions sharedNODESATWindowOpen];
    [sharedAirwayWindowOpen setAirwayWindowOpen:[NSNumber numberWithBool:NO]];
    [sharedNODESATWindowOpen setNodesatWindowOpen:[NSNumber numberWithBool:NO]];
    
    pageNumberRSI = 5;
    
    [self updateNavigation];
    
    return;
}

- (void) updateTabs
{
    self.buttonTabDrugs.selected = NO;
    self.buttonTabEquipmet.selected = NO;
    self.buttonTabFinal.selected = NO;
    self.buttonTabIndications.selected = NO;
    self.buttonTabTeam.selected = NO;
    
    self.buttonTabDrugs.highlighted = NO;
    self.buttonTabEquipmet.highlighted = NO;
    self.buttonTabFinal.highlighted = NO;
    self.buttonTabIndications.highlighted = NO;
    self.buttonTabTeam.highlighted = NO;
    
    switch (pageNumberRSI) {
        case 1:
            self.buttonTabIndications.selected = YES;
            break;
            
        case 2:
            self.buttonTabDrugs.selected = YES;
            break;
            
        case 3:
            self.buttonTabEquipmet.selected = YES;
            break;
            
        case 4:
            self.buttonTabTeam.selected = YES;
            break;
            
        case 5:
            self.buttonTabFinal.selected = YES;
            break;
            
        default:
            break;
    }
    
    [self checkTabColour];
    
    return;
}

- (void) checkTabColour
{
    EventLog *sharedIndicationComplete = [EventLog sharedIndicationComplete];
    EventLog *sharedDrugsComplete = [EventLog sharedDrugsComplete];
    EventLog *sharedEquipComplete = [EventLog sharedEquipComplete];
    EventLog *sharedTeamComplete = [EventLog sharedTeamComplete];
    EventLog *sharedFinalComplete = [EventLog sharedFinalComplete];
    
    switch ([[sharedIndicationComplete indicationComplete] integerValue]) {
        case 0:
            [self.buttonTabIndications setBackgroundImage:[UIImage imageNamed:@"redIndicationsTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabIndications setBackgroundImage:[UIImage imageNamed:@"redIndicationsTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        case 1:
            [self.buttonTabIndications setBackgroundImage:[UIImage imageNamed:@"amberIndicationsTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabIndications setBackgroundImage:[UIImage imageNamed:@"amberIndicationsTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        case 2:
            [self.buttonTabIndications setBackgroundImage:[UIImage imageNamed:@"greenIndicationsTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabIndications setBackgroundImage:[UIImage imageNamed:@"greenIndicationsTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        default:
            break;
    }
    
    switch ([[sharedDrugsComplete drugsComplete] integerValue]) {
        case 0:
            [self.buttonTabDrugs setBackgroundImage:[UIImage imageNamed:@"redDrugTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabDrugs setBackgroundImage:[UIImage imageNamed:@"redDrugTabSelected.png"] forState:UIControlStateSelected];

            break;
            
        case 1:
            [self.buttonTabDrugs setBackgroundImage:[UIImage imageNamed:@"amberDrugTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabDrugs setBackgroundImage:[UIImage imageNamed:@"amberDrugTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        case 2:
            [self.buttonTabDrugs setBackgroundImage:[UIImage imageNamed:@"greenDrugTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabDrugs setBackgroundImage:[UIImage imageNamed:@"greenDrugTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        default:
            break;
    }
    
    switch ([[sharedEquipComplete equipComplete] integerValue]) {
        case 0:
            [self.buttonTabEquipmet setBackgroundImage:[UIImage imageNamed:@"redEquipmentTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabEquipmet setBackgroundImage:[UIImage imageNamed:@"redEquipmentTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        case 1:
            [self.buttonTabEquipmet setBackgroundImage:[UIImage imageNamed:@"amberEquipmentTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabEquipmet setBackgroundImage:[UIImage imageNamed:@"amberEquipmentTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        case 2:
            [self.buttonTabEquipmet setBackgroundImage:[UIImage imageNamed:@"greenEquipmentTabDeselected.png"] forState:UIControlStateNormal];
            [self.buttonTabEquipmet setBackgroundImage:[UIImage imageNamed:@"greenEquipmentTabSelected.png"] forState:UIControlStateSelected];
            break;
            
        default:
            break;
    }
    
    switch ([[sharedTeamComplete teamComplete] integerValue]) {
        case 0:
            [self.buttonTabTeam setBackgroundImage:[UIImage imageNamed:@"redTeamTabDeselected"] forState:UIControlStateNormal];
            [self.buttonTabTeam setBackgroundImage:[UIImage imageNamed:@"redTeamTabSelected"] forState:UIControlStateSelected];
            break;
            
        case 1:
            [self.buttonTabTeam setBackgroundImage:[UIImage imageNamed:@"amberTeamTabDeselected"] forState:UIControlStateNormal];
            [self.buttonTabTeam setBackgroundImage:[UIImage imageNamed:@"amberTeamTabSelected"] forState:UIControlStateSelected];
            break;
            
        case 2:
            [self.buttonTabTeam setBackgroundImage:[UIImage imageNamed:@"greenTeamTabDeselected"] forState:UIControlStateNormal];
            [self.buttonTabTeam setBackgroundImage:[UIImage imageNamed:@"greenTeamTabSelected"] forState:UIControlStateSelected];
            break;
            
        default:
            break;
    }
    
    switch ([[sharedFinalComplete finalComplete] integerValue]) {
        case 0:
            [self.buttonTabFinal setBackgroundImage:[UIImage imageNamed:@"redFinalTabDeselected"] forState:UIControlStateNormal];
            [self.buttonTabFinal setBackgroundImage:[UIImage imageNamed:@"redFinalTabSelected"] forState:UIControlStateSelected];
            break;
            
        case 1:
            [self.buttonTabFinal setBackgroundImage:[UIImage imageNamed:@"amberFinalTabDeselected"] forState:UIControlStateNormal];
            [self.buttonTabFinal setBackgroundImage:[UIImage imageNamed:@"amberFinalTabSelected"] forState:UIControlStateSelected];
            break;
            
        case 2:
            [self.buttonTabFinal setBackgroundImage:[UIImage imageNamed:@"greenFinalTabDeselected"] forState:UIControlStateNormal];
            [self.buttonTabFinal setBackgroundImage:[UIImage imageNamed:@"greenFinalTabSelected"] forState:UIControlStateSelected];
            break;
        default:
            break;
    }
    return;
}

- (IBAction)textFieldTubeSize:(id)sender {
    Patient *sharedTubeSize = [Patient sharedTubeSize];
    [sharedTubeSize setTubeSize:[NSNumber numberWithFloat:[self.textFieldTubeSize.text floatValue]]];
    [self loadTubeSize];
}

- (IBAction)segmentedCuffed:(id)sender {
    Patient *sharedIsCuffedTube = [Patient sharedIsCuffedTube];
    switch (self.segmentedCuffed.selectedSegmentIndex) {
        case 0:
            [sharedIsCuffedTube setIsCuffedTube:[NSNumber numberWithBool:YES]];
            break;
            
        case 1:
            [sharedIsCuffedTube setIsCuffedTube:[NSNumber numberWithBool:NO]];
            break;
            
        default:
            break;
    }
    
    [self loadTubeSize];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueRSItoRoc"]){
        Interactions *sharedTransitionToRoc = [Interactions sharedTransitionToRoc];
        [sharedTransitionToRoc setTransitionToRoc:[NSNumber numberWithInt:1]];
    }
    pageNumberRSI = 1;
}

@end
