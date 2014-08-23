//
//  ConfirmationViewController.m
//  irsi
//
//  Created by Ben Taylor on 15/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "ConfirmationViewController.h"
#import "AppDelegate.h"

@interface ConfirmationViewController (){
    NSMutableArray *fullArray;
    NSMutableArray *confirmationArray;
    NSMutableArray *indexValue;
    
    NSString * back;
    NSString * titleLabel;
    NSString * oralLabel;
    NSString * nasalLabel;
    NSString * generateReport;
    NSString * finished;
    NSString * oralPaeds;
    NSString * nasalPaeds;
    NSString * getGPS;
    NSString * tubeLength;
    NSString * reportTitle;
    NSString * reportMessage;
    NSString * reportCancelTitle;
    NSString * reportReportTitle;
    NSString * clGrade;
}

@end

@implementation ConfirmationViewController


float oralLength;
float nasalLength;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)ButtonBack:(id)sender {
    Interactions *sharedTransitionToConfirm = [Interactions sharedTransitionToConfirm];
    if ([[sharedTransitionToConfirm transitionToConfirm]integerValue] == 0){
        [self performSegueWithIdentifier:@"segueConfirmRoc" sender:self];
    }
}

- (IBAction)segmentedCLGrade:(id)sender {
    EventLog *sharedCLGrade = [EventLog sharedCLGrade];
    switch (self.segmentedCLGrade.selectedSegmentIndex) {
        case 0:
            [sharedCLGrade setClGrade:@"1"];
            break;
            
        case 1:
            [sharedCLGrade setClGrade:@"2A"];
            break;
            
        case 2:
            [sharedCLGrade setClGrade:@"2B"];
            break;
            
        case 3:
            [sharedCLGrade setClGrade:@"3"];
            break;
            
        case 4:
            [sharedCLGrade setClGrade:@"4"];
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadStrings];
    [self populateTable];
    [self loadPaeds];
    [self createKeyboardReturnButton];
    
    return;
}

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    back = [NSString stringWithFormat:@"< %@",[dict objectForKey:@"Back"]];
    titleLabel = [dict objectForKey:@"ConfirmTitle"];
    generateReport = [dict objectForKey:@"GenerateReport"];
    finished = [dict objectForKey:@"Finished"];
    oralLabel = [dict objectForKey:@"OralConfirm"];
    nasalLabel = [dict objectForKey:@"NasalConfirm"];
    getGPS = [dict objectForKey:@"GPSPosition"];
    oralPaeds = [dict objectForKey:@"OralPaeds"];
    nasalPaeds = [dict objectForKey:@"NasalPaeds"];
    tubeLength = [dict objectForKey:@"TubeLength"];
    reportTitle = [dict objectForKey:@"ConfirmReportTitle"];
    reportReportTitle = [dict objectForKey:@"ConfirmReportReportTitle"];
    reportMessage = [dict objectForKey:@"ConfirmReportMessage"];
    reportCancelTitle = [dict objectForKey:@"ConfirmReportCancelTitle"];
    clGrade = [dict objectForKey:@"CLGrade"];
    
    self.buttonBack.titleLabel.text = back;
    self.labelTitleLabel.text = titleLabel;
    self.buttonGenerateReport.titleLabel.text = generateReport;
    self.buttonFinished.titleLabel.text = finished;
    self.textFieldOral.placeholder = oralLabel;
    self.nasalLength.placeholder = nasalLabel;
    self.buttonGPS.titleLabel.text = getGPS;
    self.labelTubeLength.text = tubeLength;
    self.labelCLGrade.text = clGrade;
    
    EventLog *sharedCLGrade = [EventLog sharedCLGrade];
    if ([[sharedCLGrade clGrade]length] == 0){
        self.segmentedCLGrade.selectedSegmentIndex = UISegmentedControlNoSegment;
    }
    else{
        if ([[sharedCLGrade clGrade] isEqualToString:@"1"]){
            self.segmentedCLGrade.selectedSegmentIndex = 0;
        }
        if ([[sharedCLGrade clGrade] isEqualToString:@"2A"]){
            self.segmentedCLGrade.selectedSegmentIndex = 1;
        }
        if ([[sharedCLGrade clGrade] isEqualToString:@"2B"]){
            self.segmentedCLGrade.selectedSegmentIndex = 2;
        }
        if ([[sharedCLGrade clGrade] isEqualToString:@"3"]){
            self.segmentedCLGrade.selectedSegmentIndex = 3;
        }
        if ([[sharedCLGrade clGrade] isEqualToString:@"4"]){
            self.segmentedCLGrade.selectedSegmentIndex = 4;
        }
    }
}

- (void) loadPaeds{
    Patient *sharedIsAdult = [Patient sharedIsAdult];
    Patient *sharedAge = [Patient sharedAge];
    
    if ([[sharedIsAdult isAdult] boolValue] == NO){
        float oralPaedsLength = ([[sharedAge age] integerValue]/2) + 12;
        float nasalPaedsLength = ([[sharedAge age] integerValue]/2) + 15;
        
        self.textFieldOral.placeholder = [NSString stringWithFormat:oralPaeds, oralPaedsLength];
        self.nasalLength.placeholder = [NSString stringWithFormat:nasalPaeds, nasalPaedsLength];
    }
    
    return;
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
    _textFieldOral.inputAccessoryView = toolbar;
    _nasalLength.inputAccessoryView = toolbar;
    
    return;
}

-(void) dismissKeyboard:(id) sender
{
    if ([_textFieldOral isFirstResponder]){
        [_textFieldOral resignFirstResponder];
    }
    if ([_nasalLength isFirstResponder]){
        [_nasalLength resignFirstResponder];
    }

    return;
}

// minimises keyboard on tapping elsewhere on screen
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([_textFieldOral isFirstResponder] && [touch view]!= _textFieldOral) {
        [_textFieldOral resignFirstResponder];
    }
    if ([_nasalLength isFirstResponder] && [touch view] != _nasalLength) {
        [_nasalLength resignFirstResponder];
    }

    return;
}

- (void) populateTable{
    EventLog *sharedConfirmationChecklist = [EventLog sharedConfirmationChecklist];
    EventLog *sharedConfirmationPHEM = [EventLog sharedConfirmationPHEM];
    EventLog *sharedConfirmationTicked = [EventLog sharedConfirmationTicked];
    
    // Loads the arrays from the plist files and adds them to NSArrays to allow display in sections
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ConfirmationChecklist" ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    [sharedConfirmationChecklist setConfirmationChecklist:[dict objectForKey:@"Items"]];
    [sharedConfirmationPHEM setConfirmationPHEM:[dict objectForKey:@"PHEM"]];
    
    confirmationArray = [[NSMutableArray alloc] init];
    fullArray = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i < [[sharedConfirmationChecklist confirmationChecklist] count]; i ++){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        [array addObject:[NSNumber numberWithInteger:i]];
        [array addObject:[[sharedConfirmationChecklist confirmationChecklist]objectAtIndex:i]];
        [array addObject:[[sharedConfirmationPHEM confirmationPHEM]objectAtIndex:i]];
        [array addObject:[[sharedConfirmationTicked confirmationTicked]objectAtIndex:i]];
        
        [fullArray addObject:array];
    }
    
    for (NSInteger p = 0; p < [fullArray count]; p ++){
        EventLog *sharedPreHospital = [EventLog sharedPreHospital];
        bool phem = [[sharedPreHospital preHospital]boolValue];
        
        NSArray * phemArray = [[NSArray alloc] initWithArray:[fullArray objectAtIndex:p]];
        
        if (phem == YES){
            if ([[phemArray objectAtIndex:2]integerValue] <2){
                [confirmationArray addObject:phemArray];
            }
        }
        
        if (phem == NO){
            if ([[phemArray objectAtIndex:2]integerValue] != 1){
                [confirmationArray addObject:phemArray];
            }
        }
    }
    return;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [confirmationArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = [confirmationArray objectAtIndex:indexPath.row];
    
    NSString *cellID = @"ChecklistBasic";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = [array objectAtIndex:1];
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventLog *sharedIndicationTicked = [EventLog sharedIndicationTicked];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableArray *array = [confirmationArray objectAtIndex:indexPath.row];
    NSInteger index = [[array objectAtIndex:0]integerValue];
    NSInteger newValue;
    
    switch ([[array objectAtIndex:3] integerValue]) {
        case 0:
            // Selected State
            [[sharedIndicationTicked indicationTicked] replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:1]];
            newValue = 1;
            cell.imageView.image = [UIImage imageNamed:@"completeTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0];
            break;
            
        case 1:
            // Failed/ Unsuccessful State
            [[sharedIndicationTicked indicationTicked] replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:2]];
            newValue = 2;
            cell.imageView.image = [UIImage imageNamed:@"FailedTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0];
            break;
            
        case 2:
            // Skipped State
            [[sharedIndicationTicked indicationTicked] replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:3]];
            newValue = 3;
            cell.imageView.image = [UIImage imageNamed:@"SkipTickBox.png"];
            cell.backgroundColor = [UIColor colorWithRed:166/255.0f green:196/255.0f blue:244/255.0f alpha:0.4];
            break;
            
        case 3:
            // Default State
            [[sharedIndicationTicked indicationTicked] replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:0]];
            cell.imageView.image = [UIImage imageNamed:@"blankTickBox.png"];
            cell.backgroundColor = [UIColor clearColor];
            newValue = 0;
            break;
            
        default:
            break;
    }
    
    NSMutableArray *update = [[NSMutableArray alloc] initWithArray:array];
    [update replaceObjectAtIndex:3 withObject:[NSNumber numberWithInteger:newValue]];
    [confirmationArray replaceObjectAtIndex:indexPath.row withObject:update];
    
    [self updateButtonColour];
    
    return;
}

- (void) updateButtonColour{
    NSInteger sum = 0;
    
    for (NSInteger i=0; i<[confirmationArray count]; i++) {
        NSArray *array = [confirmationArray objectAtIndex:i];
        if ([[array objectAtIndex:3]integerValue] > 0){sum ++;}
    }
    if (sum == 0){[self.buttonFinished setBackgroundImage:[UIImage imageNamed:@"RedBackgroundBorderedBlack.png"] forState:UIControlStateNormal];}
    if ((sum > 0) && (sum < [confirmationArray count])){[self.buttonFinished setBackgroundImage:[UIImage imageNamed:@"OrangeBackgroundBorderedBlack.png"] forState:UIControlStateNormal];}
    if (sum == [confirmationArray count]){[self.buttonFinished setBackgroundImage:[UIImage imageNamed:@"GreenBackgroundBorderedBlack.png"] forState:UIControlStateNormal];;}
}

float nasalTubeLength;
float oralTubeLength;

- (IBAction)textFieldOral:(id)sender {
    if ([[_textFieldOral text] length] != 0)
    {
        oralTubeLength = [_textFieldOral.text floatValue];
        self.nasalLength.text = @"";
        self.textFieldOral.text = [NSString stringWithFormat:@"%.1f", oralTubeLength];
        Patient *sharedTubeLength = [Patient sharedTubeLength];
        Patient *sharedIsNasalTube = [Patient sharedIsNasalTube];
        [sharedIsNasalTube setIsNasalTube:[NSNumber numberWithBool:NO]];
        [sharedTubeLength setTubeLength:[NSNumber numberWithFloat:oralTubeLength]];
    }
    return;
}

- (IBAction)textFieldNasal:(id)sender {
    if ([[_nasalLength text] length] != 0)
    {
        nasalTubeLength = [_nasalLength.text floatValue];
        self.textFieldOral.text = @"";
        self.nasalLength.text = [NSString stringWithFormat:@"%.1f", nasalTubeLength];
        Patient *sharedTubeLength = [Patient sharedTubeLength];
        Patient *sharedIsNasalTube = [Patient sharedIsNasalTube];
        [sharedIsNasalTube setIsNasalTube:[NSNumber numberWithBool:YES]];
        [sharedTubeLength setTubeLength:[NSNumber numberWithFloat:nasalTubeLength]];
    }
    return;
}

- (IBAction)buttonGPS:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonGenerateReport:(id)sender {
    [self generateReport];
}

- (void) generateReport{
    Interactions * sharedTriggerReport = [Interactions sharedTriggerReport];
    [sharedTriggerReport setTriggerReport:[NSNumber numberWithBool:YES]];
}


- (IBAction)buttonFinished:(id)sender {
    Interactions *sharedTriggerReport = [Interactions sharedTriggerReport];
    if ([[sharedTriggerReport triggerReport]boolValue] == YES){}
    else{
        UIAlertView *report = [[UIAlertView alloc] initWithTitle:reportTitle
                                                        message:reportMessage
                                                        delegate:self
                                                        cancelButtonTitle:reportCancelTitle
                                                        otherButtonTitles:reportReportTitle, nil];
        [report show];
    }
}

- (void) finished{
    Interactions *sharedResetAll = [Interactions sharedResetAll];
    [sharedResetAll setResetAll:[NSNumber numberWithBool:YES]];
    Interactions * sharedTriggerReport = [Interactions sharedTriggerReport];
    [sharedTriggerReport setTriggerReport:[NSNumber numberWithBool:NO]];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:reportCancelTitle]){
        [self finished];
    }
    if ([title isEqualToString:reportReportTitle]){
        [self generateReport];
        [self performSegueWithIdentifier:@"segueConfirmReport" sender:self];
    }
    
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueConfirmGPS"]){
        Interactions *sharedTransitionToGPS = [Interactions sharedTransitionToGPS];
        [sharedTransitionToGPS setTransitionToGPS:[NSNumber numberWithInt:1]];
    }
}

@end
