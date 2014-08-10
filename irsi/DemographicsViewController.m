//
//  DemographicsViewController.m
//  irsi
//
//  Created by Ben Taylor on 16/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "DemographicsViewController.h"

@interface DemographicsViewController ()

@end

@implementation DemographicsViewController

// Declaring local variables
NSArray *_agePickerArray;
NSArray *_ageWeightArray;
NSArray *_yearsAgeArray;
NSInteger weightTypeSelected = 0;
NSInteger heightTypeSelected = 0;
bool heightKnown = NO;

NSString * kg;
NSString * st;
NSString * lbs;
NSString * cm;
NSString * ftIn;
NSString * male;
NSString * female;
NSString * bmi;
NSString * stones;
NSString * pounds;
NSString * enterWeight;
NSString * enterHeight;
NSString * feet;
NSString * inches;
NSString * adult16;
NSString * year15;
NSString * year14;
NSString * year13;
NSString * year12;
NSString * year11;
NSString * year10;
NSString * year9;
NSString * year8;
NSString * year7;
NSString * year6;
NSString * year5;
NSString * year4;
NSString * year3;
NSString * year2;
NSString * year1;
NSString * month11;
NSString * month10;
NSString * month9;
NSString * month8;
NSString * month7;
NSString * month6;
NSString * month5;
NSString * month4;
NSString * month3;
NSString * month2;
NSString * month1;
NSString * neonate;
NSString * closeButton;

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

    // Loads user defaults for preferred weight/ height
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [self loadStrings];
    
    [defaults synchronize];
    
    if ([defaults objectForKey:@"heightTypeDefaultSelected"] != nil){
        self.segmentedHeight.selectedSegmentIndex = [defaults integerForKey:@"heightTypeDefaultSelected"];
        heightTypeSelected = [defaults integerForKey:@"heightTypeDefaultSelected"];}
    
    if ([defaults objectForKey:@"weightTypeDefaultSelected"] != nil){
        self.segmentedWeight.selectedSegmentIndex = [defaults integerForKey:@"weightTypeDefaultSelected"];
        weightTypeSelected = [defaults integerForKey:@"weightTypeDefaultSelected"];}
    
    // Creates the weight corresponding with each age group
    _ageWeightArray = @[@"70",@"52",@"49",@"46",@"43",@"40",@"37",@"34",@"31",@"28",@"25",@"18",@"16",@"14",@"12",@"10",@"9.5",@"9.0",@"8.5",@"8.0",@"7.5",@"7.0",@"6.5",@"6.0",@"5.5",@"5.0",@"4.5",@"3.5"];
    
    // Creates the age in years corresponding with each age group
    _yearsAgeArray = @[@"16",@"15",@"14",@"13",@"12",@"11",@"10",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"0"];
    
    // Connect data to UIPicker
    self.pickerAge.dataSource = self;
    self.pickerAge.delegate = self;
    
    // Loads the singleton data to the existing dials
    Patient *sharedIsFemale = [Patient sharedIsFemale];
    self.segmentedGender.selectedSegmentIndex = [[sharedIsFemale isFemale] boolValue];
    Patient *sharedAgeArrayIndex = [Patient sharedAgeArrayIndex];
    [self.pickerAge selectRow:[[sharedAgeArrayIndex ageArrayIndex]intValue] inComponent:(NSInteger) 0 animated:YES];
    [self displayWeight];
    [self createKeyboardReturnButton];
}

- (void) loadStrings{
    Nationalities *sharedNationality = [Nationalities sharedNationality];
    Nationalities *sharedNationalityStringArray = [Nationalities sharedNationalityStringArray];
    NSInteger nationality = [[sharedNationality nationality] integerValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:[[sharedNationalityStringArray nationalityStringArray]objectAtIndex: nationality] ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // places the national values to strings
    kg = [dict objectForKey:@"Kg"];
    st = [dict objectForKey:@"St"];
    lbs = [dict objectForKey:@"Lbs"];
    cm = [dict objectForKey:@"Cm"];
    ftIn = [dict objectForKey:@"FtIn"];
    male = [dict objectForKey:@"Male"];
    female = [dict objectForKey:@"Female"];
    bmi = [dict objectForKey:@"BMI"];
    stones = [dict objectForKey:@"Stones"];
    pounds = [dict objectForKey:@"Pounds"];
    enterWeight = [dict objectForKey:@"EnterWeight"];
    enterHeight = [dict objectForKey:@"EnterHeight"];
    feet = [dict objectForKey:@"Feet"];
    inches = [dict objectForKey:@"Inches"];
    adult16 = [dict objectForKey:@"Adult16"];
    year15 = [dict objectForKey:@"15Year"];
    year14 = [dict objectForKey:@"14Year"];
    year13 = [dict objectForKey:@"13Year"];
    year12 = [dict objectForKey:@"12Year"];
    year11 = [dict objectForKey:@"11Year"];
    year10 = [dict objectForKey:@"10Year"];
    year9 = [dict objectForKey:@"9Year"];
    year8 = [dict objectForKey:@"8Year"];
    year7 = [dict objectForKey:@"7Year"];
    year6 = [dict objectForKey:@"6Year"];
    year5 = [dict objectForKey:@"5Year"];
    year4 = [dict objectForKey:@"4Year"];
    year3 = [dict objectForKey:@"3Year"];
    year2 = [dict objectForKey:@"2Year"];
    year1 = [dict objectForKey:@"1Year12Months"];
    month11 = [dict objectForKey:@"11Months"];
    month10 = [dict objectForKey:@"10Months"];
    month9 = [dict objectForKey:@"9Months"];
    month8 = [dict objectForKey:@"8Months"];
    month7 = [dict objectForKey:@"7Months"];
    month6 = [dict objectForKey:@"6Months"];
    month5 = [dict objectForKey:@"5Months"];
    month4 = [dict objectForKey:@"4Months"];
    month3 = [dict objectForKey:@"3Months"];
    month2 = [dict objectForKey:@"2Months"];
    month1 = [dict objectForKey:@"1Month"];
    neonate = [dict objectForKey:@"Neonate"];
    closeButton = [dict objectForKey:@"Close"];
    
    // Creates the array for the agePicker
    _agePickerArray = @[adult16, year15, year14, year13, year12, year11, year10, year9, year8, year7, year6, year5, year4, year3, year2, year1, month11, month10, month9, month8, month7, month6, month5, month4, month3, month2, month1, neonate];
    
    self.textFieldCm.placeholder = enterHeight;
    self.textFieldFeet.placeholder = feet;
    self.textFieldInches.placeholder = inches;
    self.textFieldKg.placeholder = enterWeight;
    self.textFieldLbs.placeholder = pounds;
    self.textFieldPounds.placeholder = pounds;
    self.textFieldStones.placeholder = stones;
    [self.segmentedGender setTitle:male forSegmentAtIndex:0];
    [self.segmentedGender setTitle:female forSegmentAtIndex:1];
    [self.segmentedHeight setTitle:cm forSegmentAtIndex:0];
    [self.segmentedHeight setTitle:ftIn forSegmentAtIndex:1];
    [self.segmentedWeight setTitle:kg forSegmentAtIndex:0];
    [self.segmentedWeight setTitle:st forSegmentAtIndex:1];
    [self.segmentedWeight setTitle:lbs forSegmentAtIndex:2];
    self.labelBMI.text = bmi;
}

// The number of columns of data
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The Number of rows of data
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _agePickerArray.count;
}

// The data to return for the row and component that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _agePickerArray[row];
}

// Capture the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
     // Gets the weight and stores it in a singleton
     NSString *agePickerOutput = [_ageWeightArray objectAtIndex:row];
     Patient *sharedWeight = [Patient sharedWeight];
     [sharedWeight setWeight:[NSNumber numberWithFloat:[agePickerOutput floatValue]]];
    Patient *sharedWeightKnown = [Patient sharedWeightKnown];
    [sharedWeightKnown setWeightKnown:[NSNumber numberWithBool:YES]];
     
     // Gets the age ands stores it in a singleton
     NSString *ageOutput = [_agePickerArray objectAtIndex:row];
     NSString *yearsOld = [_yearsAgeArray objectAtIndex:row];
     
     int age = [yearsOld intValue];
     
     // Stores the output in a singleton
     Patient *sharedAge = [Patient sharedAge];
     Patient *sharedAgeArrayIndex = [Patient sharedAgeArrayIndex];
     [sharedAge setAge:[NSNumber numberWithInt:age]];
     [sharedAgeArrayIndex setAgeArrayIndex:[NSNumber numberWithInteger:row]];
     
     // Detects if the patient is an adult or not (for certain drug calculations)
     if ([ageOutput isEqualToString: @"Adult (16+)"])
     {
     Patient *sharedIsAdult = [Patient sharedIsAdult];
     [sharedIsAdult setIsAdult:[NSNumber numberWithBool:YES]];
     }
     else
     {
     Patient *sharedIsAdult = [Patient sharedIsAdult];
     [sharedIsAdult setIsAdult:[NSNumber numberWithBool:NO]];
     }
    
    [self displayWeight];
    
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _textFieldCm.inputAccessoryView = toolbar;
    _textFieldFeet.inputAccessoryView = toolbar;
    _textFieldInches.inputAccessoryView = toolbar;
    _textFieldKg.inputAccessoryView = toolbar;
    _textFieldLbs.inputAccessoryView = toolbar;
    _textFieldPounds.inputAccessoryView = toolbar;
    _textFieldStones.inputAccessoryView = toolbar;
    
    return;
}

-(void) dismissKeyboard:(id) sender
{
    if ([_textFieldCm isFirstResponder]){
        [_textFieldCm resignFirstResponder];
    }
    if ([_textFieldFeet isFirstResponder]){
        [_textFieldFeet resignFirstResponder];
    }
    if ([_textFieldInches isFirstResponder]){
        [_textFieldInches resignFirstResponder];
    }
    if ([_textFieldKg isFirstResponder]){
        [_textFieldKg resignFirstResponder];
    }
    if ([_textFieldLbs isFirstResponder]){
        [_textFieldLbs resignFirstResponder];
    }
    if ([_textFieldPounds isFirstResponder]){
        [_textFieldPounds resignFirstResponder];
    }
    if ([_textFieldStones isFirstResponder]){
        [_textFieldStones resignFirstResponder];
    }
    return;
}

// minimises keyboard on tapping elsewhere on screen
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([_textFieldCm isFirstResponder] && [touch view]!= _textFieldCm) {
        [_textFieldCm resignFirstResponder];
    }
    if ([_textFieldFeet isFirstResponder] && [touch view] != _textFieldFeet) {
        [_textFieldFeet resignFirstResponder];
    }
    if ([_textFieldInches isFirstResponder] && [touch view] != _textFieldInches) {
        [_textFieldInches resignFirstResponder];
    }
    if ([_textFieldKg isFirstResponder] && [touch view] != _textFieldKg) {
        [_textFieldKg resignFirstResponder];
    }
    if ([_textFieldLbs isFirstResponder] && [touch view] != _textFieldLbs) {
        [_textFieldLbs resignFirstResponder];
    }
    if ([_textFieldPounds isFirstResponder] && [touch view] != _textFieldPounds) {
        [_textFieldPounds resignFirstResponder];
    }
    if ([_textFieldStones isFirstResponder] && [touch view] != _textFieldStones) {
        [_textFieldStones resignFirstResponder];
    }
    return;
}

- (void) displayWeight
{
    _textFieldCm.enabled = YES;
    _textFieldFeet.enabled = YES;
    _textFieldInches.enabled = YES;
    _textFieldKg.enabled = YES;
    _textFieldLbs.enabled = YES;
    _textFieldPounds.enabled = YES;
    _textFieldStones.enabled = YES;
    
    _textFieldCm.hidden = YES;
    _textFieldFeet.hidden = YES;
    _textFieldInches.hidden = YES;
    _textFieldKg.hidden = YES;
    _textFieldLbs.hidden = YES;
    _textFieldPounds.hidden = YES;
    _textFieldStones.hidden = YES;
    
    switch (self.segmentedHeight.selectedSegmentIndex)
    {
        case 0:
            _textFieldCm.hidden = NO;
            break;
            
        case 1:
            _textFieldFeet.hidden = NO;
            _textFieldInches.hidden = NO;
            break;
            
        default:
            break;
            
    }
    
    switch (self.segmentedWeight.selectedSegmentIndex)
    {
        case 0:
            _textFieldKg.hidden = NO;
            break;
            
        case 1:
            _textFieldStones.hidden = NO;
            _textFieldPounds.hidden = NO;
            break;
            
        case 2:
            _textFieldLbs.hidden = NO;
            
        default:
            break;
    }
    
    Patient *sharedWeight = [Patient sharedWeight];
    Patient *sharedHeight = [Patient sharedHeight];
    Patient *sharedWeightKnown = [Patient sharedWeightKnown];
    float weight = [[sharedWeight weight] floatValue];
    float height = [[sharedHeight height] floatValue];
    float poundWeight = weight * 2.20462;
    float inchHeight = height * 0.393701;
    int stones = (int) (poundWeight/14);
    int feet = (int) (inchHeight/12);
    float pounds = poundWeight - (stones * 14);
    float inches = inchHeight - (feet *12);
    
    _textFieldCm.text = [NSString stringWithFormat:@"%.1f",height];
    _textFieldFeet.text = [NSString stringWithFormat:@"%i",feet];
    _textFieldInches.text = [NSString stringWithFormat:@"%.1f",inches];
    _textFieldKg.text = [NSString stringWithFormat:@"%.1f",weight];
    _textFieldLbs.text = [NSString stringWithFormat:@"%.1f",poundWeight];
    _textFieldPounds.text = [NSString stringWithFormat:@"%.1f",pounds];
    _textFieldStones.text = [NSString stringWithFormat:@"%i", stones];
    
    if (heightKnown == YES)
    {
        if (heightTypeSelected == 0)
        {
            _textFieldCm.hidden = NO;
        
            _textFieldFeet.hidden = YES;
            _textFieldInches.hidden = YES;
            _textFieldFeet.enabled = NO;
            _textFieldInches.enabled = NO;
        }
        if (heightTypeSelected == 1)
        {
            _textFieldFeet.hidden = NO;
            _textFieldInches.hidden = NO;
        
            _textFieldCm.hidden = YES;
            _textFieldCm.enabled = NO;
        }
        if ([[sharedWeightKnown weightKnown]boolValue] == YES)
        {
            _labelBMI.text = [NSString stringWithFormat:@"%@: %.1f %@/m\u00B2",bmi,(weight/powf((height/100), 2)),kg];
        }
    }
    else if (heightKnown == NO)
    {
        _textFieldCm.text = [NSString stringWithFormat:@""];
        _textFieldFeet.text = [NSString stringWithFormat:@""];
        _textFieldInches.text = [NSString stringWithFormat:@""];
    }
    if ([[sharedWeightKnown weightKnown]boolValue] == YES)
    {
        if (weightTypeSelected == 0)
        {
            _textFieldKg.hidden = NO;
            
            _textFieldLbs.hidden = YES;
            _textFieldPounds.hidden = YES;
            _textFieldStones.hidden = YES;
            _textFieldLbs.enabled = NO;
            _textFieldPounds.enabled = NO;
            _textFieldStones.enabled = NO;
        }
        if (weightTypeSelected == 1)
        {
            _textFieldStones.hidden = NO;
            _textFieldPounds.hidden = NO;
            
            _textFieldKg.hidden = YES;
            _textFieldLbs.hidden = YES;
            _textFieldKg.enabled = NO;
            _textFieldLbs.enabled = NO;
        }
        if (weightTypeSelected == 2)
        {
            _textFieldLbs.hidden = NO;
            
            _textFieldKg.hidden = YES;
            _textFieldPounds.hidden = YES;
            _textFieldStones.hidden = YES;
            _textFieldKg.enabled = NO;
            _textFieldPounds.enabled = NO;
            _textFieldStones.enabled = NO;
        }
    }
    else if ([[sharedWeightKnown weightKnown]boolValue] == NO)
    {
        _textFieldKg.text = [NSString stringWithFormat:@""];
        _textFieldLbs.text = [NSString stringWithFormat:@""];
        _textFieldPounds.text = [NSString stringWithFormat:@""];
        _textFieldStones.text = [NSString stringWithFormat:@""];
    }
    
    return;
}

- (IBAction)segmentedWeight:(id)sender {
    switch (self.segmentedWeight.selectedSegmentIndex)
    {
        case 0:
            weightTypeSelected = 0;
            break;
            
        case 1:
            weightTypeSelected = 1;
            break;
            
        case 2:
            weightTypeSelected = 2;
            
        default:
            break;
            
    }
    [self displayWeight];
    
    return;
}

- (IBAction)segmentedHeight:(id)sender {
    switch (self.segmentedHeight.selectedSegmentIndex)
    {
        case 0:
            heightTypeSelected = 0;
            break;
            
        case 1:
            heightTypeSelected = 1;
            break;
            
        default:
            break;
            
    }
    [self displayWeight];
    [self calcIBW];
    
    return;
}

- (IBAction)segmentedGender:(id)sender {
    Patient *sharedIsFemale = [Patient sharedIsFemale];
    switch (self.segmentedGender.selectedSegmentIndex)
    {
        case 0:
            [sharedIsFemale setIsFemale:[NSNumber numberWithBool:NO]];
            break;
            
        case 1:
            [sharedIsFemale setIsFemale:[NSNumber numberWithBool:YES]];
            break;
            
        default:
            break;
            
    }
    [self displayWeight];
    [self calcIBW];
    
    return;
}

- (IBAction)textFieldEntryKg:(id)sender {
    if ([[_textFieldKg text] length] != 0)
    {
        Patient *sharedWeight = [Patient sharedWeight];
        Patient *sharedWeightKnown = [Patient sharedWeightKnown];
        [sharedWeightKnown setWeightKnown:[NSNumber numberWithBool:YES]];
        
        [sharedWeight setWeight:[NSNumber numberWithFloat:[_textFieldKg.text floatValue]]];
        [self displayWeight];
    }
    return;
}

- (IBAction)textFieldEntryLbs:(id)sender {
    if ([[_textFieldLbs text] length] != 0)
    {
        Patient *sharedWeight = [Patient sharedWeight];
        Patient *sharedWeightKnown = [Patient sharedWeightKnown];
        [sharedWeightKnown setWeightKnown:[NSNumber numberWithBool:YES]];
        
        [sharedWeight setWeight:[NSNumber numberWithFloat:(0.453592 * [_textFieldLbs.text floatValue])]];
        [self displayWeight];
    }
    return;
}

- (IBAction)textFieldEntryStones:(id)sender {
    if ([[_textFieldStones text] length] != 0)
    {
        Patient *sharedWeight = [Patient sharedWeight];
        Patient *sharedWeightKnown = [Patient sharedWeightKnown];
        [sharedWeightKnown setWeightKnown:[NSNumber numberWithBool:YES]];
        float subPoundWeight;
        float stoneWeight;
        if ([[_textFieldPounds text] length] != 0)
        {
            subPoundWeight = [_textFieldPounds.text floatValue];
        }
        if ([[_textFieldStones text] length] != 0)
        {
            stoneWeight = [_textFieldStones.text floatValue];
        }
        float poundWeight = (14 * stoneWeight) + subPoundWeight;
        [sharedWeight setWeight:[NSNumber numberWithFloat:((0.453592 * poundWeight) + 0.01)]];
        [self displayWeight];
    }
    return;
}

- (IBAction)textFieldEntryPounds:(id)sender {
    if ([[_textFieldPounds text] length] != 0)
    {
        Patient *sharedWeight = [Patient sharedWeight];
        Patient *sharedWeightKnown = [Patient sharedWeightKnown];
        [sharedWeightKnown setWeightKnown:[NSNumber numberWithBool:YES]];
        float subPoundWeight;
        float stoneWeight;
        if ([[_textFieldPounds text] length] != 0)
        {
            subPoundWeight = [_textFieldPounds.text floatValue];
        }
        if ([[_textFieldStones text] length] != 0)
        {
            stoneWeight = [_textFieldStones.text floatValue];
        }
        float poundWeight = (14 * stoneWeight) + subPoundWeight;
        [sharedWeight setWeight:[NSNumber numberWithFloat:((0.453592 * poundWeight)+ 0.01)]];
        [self displayWeight];
    }
    
    return;
}

- (IBAction)textFieldEntryCm:(id)sender {
    if ([[_textFieldCm text] length] != 0)
    {
        Patient *sharedHeight = [Patient sharedHeight];
        heightKnown = YES;
        
        [sharedHeight setHeight:[NSNumber numberWithFloat:[_textFieldCm.text floatValue]]];
        [self displayWeight];
        [self calcIBW];
    }
    return;
}

- (IBAction)textFieldEntryFeet:(id)sender {
    if ([[_textFieldFeet text] length] != 0)
    {
        Patient *sharedHeight = [Patient sharedHeight];
        heightKnown = YES;
        
        float inch;
        inch = ([_textFieldInches.text floatValue] + (12*[_textFieldFeet.text floatValue]));
        [sharedHeight setHeight:[NSNumber numberWithFloat:(2.54 * inch)]];
        [self displayWeight];
        [self calcIBW];
        
        return;
    }
}

- (IBAction)textFieldEntryInches:(id)sender {
    if ([[_textFieldInches text] length] != 0)
    {
        Patient *sharedHeight = [Patient sharedHeight];
        heightKnown = YES;
        
        float inch;
        inch = ([_textFieldInches.text floatValue] + (12*[_textFieldFeet.text floatValue]));
        [sharedHeight setHeight:[NSNumber numberWithFloat:(2.54 * inch)]];
        [self displayWeight];
        [self calcIBW];
        
        return;
    }
}

- (void) calcIBW
{
    if (heightKnown == YES)
    {
        Patient *sharedIbwKnown = [Patient sharedIbwKnown];
        Patient *sharedIdealBodyWeight = [Patient sharedIdealBodyWeight];
        Patient *sharedHeight = [Patient sharedHeight];
        Patient *sharedIsFemale = [Patient sharedIsFemale];
        float idealBW = 0;
        
        float inchHeight = [[sharedHeight height] floatValue] * 0.393700787;
        
        if ([[sharedIsFemale isFemale] boolValue ]== NO)
        {
            idealBW = 50 + (2.3 * (inchHeight - 60));
        }
        if ([[sharedIsFemale isFemale] boolValue ]== YES)
        {
            idealBW = 45.5 + (2.3 * (inchHeight - 60));
        }
        
        if (idealBW > 0)
        {
            [sharedIbwKnown setIbwKnown:[NSNumber numberWithBool:YES]];
            [sharedIdealBodyWeight setIdealBodyWeight:[NSNumber numberWithFloat:idealBW]];
        }
        
    }
}

@end
