//
//  AnaphylaxisInitialViewController.m
//  irsi
//
//  Created by Ben Taylor on 21/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "AnaphylaxisInitialViewController.h"

@interface AnaphylaxisInitialViewController ()

@end

@implementation AnaphylaxisInitialViewController


// Declares variables
NSArray *_agePickerArray;
NSArray *_ageWeightArray;
NSArray *_yearsAgeArray;
bool adult = YES;
float anaWeight = 70;
float anaPoundWeight;
bool anaweightKnown = NO;
NSInteger anaWeightTypeSelected = 0;
NSInteger agePickerArrayChosen;
NSInteger age;

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
    
    // Loads values that have already been entered
    Patient *sharedWeightKnown = [Patient sharedWeightKnown];
    Patient *sharedWeight = [Patient sharedWeight];
    Patient *sharedAgeArrayIndex = [Patient sharedAgeArrayIndex];
    Patient *sharedIsAdult = [Patient sharedIsAdult];
    Patient *sharedAge = [Patient sharedAge];
    
    // Loads settings from NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if ([defaults objectForKey:@"weightTypeDefaultSelected"] != nil){
        anaWeightTypeSelected = (int)[defaults integerForKey:@"weightTypeDefaultSelected"];}
    
    // Sets already loaded values to class variables
    anaWeight = [[sharedWeight weight]floatValue];
    anaPoundWeight = anaWeight * 2.204;
    anaweightKnown = [[sharedWeightKnown weightKnown] boolValue];
    agePickerArrayChosen = [[sharedAgeArrayIndex ageArrayIndex] intValue];
    adult = [[sharedIsAdult isAdult] boolValue];
    self.selectorWeight.selectedSegmentIndex = anaWeightTypeSelected;
    age = [[sharedAge age] intValue];
    
    // Sets the initial loading conditions
    [self calculateAdrenaline];
    [self displayAgeLabel];
    
    
    // Creates the array for the agePicker
    _agePickerArray = @[@"Adult (16+)", @"15 Years", @"14 Years", @"13 Years", @"12 Years", @"11 Years", @"10 Years", @"9 Years", @"8 Years", @"7 Years", @"6 Years", @"5 Years", @"4 Years", @"3 Years", @"2 Years", @"1 Year/ 12 Months", @"11 Months", @"10 Months", @"9 Months", @"8 Months", @"7 Months", @"6 Months", @"5 Months", @"4 Months", @"3 Months", @"2 Months", @"1 Months", @"Neonate"];
    
    // Creates the weight corresponding with each age group
    _ageWeightArray = @[@"70",@"52",@"49",@"46",@"43",@"40",@"37",@"34",@"31",@"28",@"25",@"18",@"16",@"14",@"12",@"10",@"9.5",@"9.0",@"8.5",@"8.0",@"7.5",@"7.0",@"6.5",@"6.0",@"5.5",@"5.0",@"4.5",@"3.5"];
    
    // Creates the age in years corresponding with each age group
    _yearsAgeArray = @[@"16",@"15",@"14",@"13",@"12",@"11",@"10",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"0"];
    
    // Connect data to UIPicker
    self.agePicker.dataSource = self;
    self.agePicker.delegate = self;
    
    [self createKeyboardReturnButton];
}

// Sets the picker to default to an already selected value
- (void) setPickerLoadValue
{
    [self.agePicker selectRow:agePickerArrayChosen inComponent:(NSInteger) 0 animated:YES];
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
    NSString *agePickerOutput = [_ageWeightArray objectAtIndex:row];
    self.weightDisplayTextBox.text = agePickerOutput;
    float agePickerOutputAsFloat = [agePickerOutput floatValue];
    NSString *ageOutput = [_agePickerArray objectAtIndex:row];
    NSString *yearsOld = [_yearsAgeArray objectAtIndex:row];
    
    age = [yearsOld intValue];
    
    // Stores the output in a singleton
    Patient *sharedAge = [Patient sharedAge];
    Patient *sharedAgeArrayIndex = [Patient sharedAgeArrayIndex];
    [sharedAge setAge:[NSNumber numberWithInteger:age]];
    [sharedAgeArrayIndex setAgeArrayIndex:[NSNumber numberWithInteger:row]];
    
    // Detects if the patient is an adult or not (for certain drug calculations)
    if ([ageOutput isEqualToString: @"Adult (16+)"])
    {
        Patient *sharedIsAdult = [Patient sharedIsAdult];
        [sharedIsAdult setIsAdult:[NSNumber numberWithBool:YES]];
        adult = YES;
    }
    else
    {
        Patient *sharedIsAdult = [Patient sharedIsAdult];
        [sharedIsAdult setIsAdult:[NSNumber numberWithBool:NO]];
        adult = NO;
    }
    
    anaPoundWeight = agePickerOutputAsFloat *2.204;
    anaWeight = agePickerOutputAsFloat;
    [self displayWeight];
    [self displayAgeLabel];
    [self calculateAdrenaline];
    
    return;
}

- (void) displayAgeLabel
{
    NSString *one = [NSString stringWithFormat:@"Doses calculated for %i Kg ",(int) anaWeight];
    NSString *two = [[NSString alloc]init];
    if (adult == YES){two = @"Adult";}
    if (adult == NO){two = @"Child";}
    NSString *three = @". Tap to Change";
    NSString *output = [one stringByAppendingString:[two stringByAppendingString:three]];
    self.buttonPopOverDemographics.titleLabel.text = output;
}

// Creates a popup window with a return button for the number pad
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
    _weightDisplayTextBox.inputAccessoryView = toolbar;
    _textfieldLabelLbs.inputAccessoryView = toolbar;
    _textFieldLabelStones.inputAccessoryView = toolbar;
    _textFieldLabelPounds.inputAccessoryView = toolbar;
    
    return;
}

-(void) dismissKeyboard:(id) sender
{
    if ([_weightDisplayTextBox isFirstResponder]){
        [_weightDisplayTextBox resignFirstResponder];
    }
    if ([_textfieldLabelLbs isFirstResponder]){
        [_textfieldLabelLbs resignFirstResponder];
    }
    if ([_textFieldLabelPounds isFirstResponder]){
        [_textFieldLabelPounds resignFirstResponder];
    }
    if ([_textFieldLabelStones isFirstResponder]){
        [_textFieldLabelStones resignFirstResponder];
    }
    
    return;
}

// minimises keyboard on tapping elsewhere on screen
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([_weightDisplayTextBox isFirstResponder] && [touch view] != _weightDisplayTextBox) {
        [_weightDisplayTextBox resignFirstResponder];
    }
    if ([_textFieldLabelStones isFirstResponder] && [touch view] != _textFieldLabelStones) {
        [_textFieldLabelStones resignFirstResponder];
    }
    if ([_textFieldLabelPounds isFirstResponder] && [touch view] != _textFieldLabelPounds) {
        [_textFieldLabelPounds resignFirstResponder];
    }
    if ([_textfieldLabelLbs isFirstResponder] && [touch view] != _textfieldLabelLbs) {
        [_textfieldLabelLbs resignFirstResponder];
    }
    
    return;
}

- (void) displayWeight
{
    // interrogates the text fields and proceeds to update the others if there is an entry
    if(([[_weightDisplayTextBox text] length] != 0) || ([[_textFieldLabelPounds text] length] != 0) ||([[_textFieldLabelStones text] length] != 0) ||([[_textfieldLabelLbs text] length] != 0) || (anaweightKnown == YES))
    {
        // enables boxes to allow the display to be updated
        _weightDisplayTextBox.enabled = YES;
        _textFieldLabelStones.enabled = YES;
        _textFieldLabelPounds.enabled = YES;
        _textfieldLabelLbs.enabled = YES;
        
        _textfieldLabelLbs.text = [NSString stringWithFormat:@"%.1f", anaPoundWeight];
        _weightDisplayTextBox.text = [NSString stringWithFormat:@"%.1f", anaWeight];
        int stoneWeight = (int) (anaPoundWeight / 14);
        float lbsWeight = anaPoundWeight - (stoneWeight * 14);
        _textFieldLabelStones.text = [NSString stringWithFormat:@"%i", stoneWeight];
        _textFieldLabelPounds.text = [NSString stringWithFormat:@"%.1f", lbsWeight];
        anaweightKnown = YES;
        Patient *sharedWeightKnown = [Patient sharedWeightKnown];
        [sharedWeightKnown setWeightKnown:[NSNumber numberWithBool:YES]];
    }
    
    [self hideAllWeights];
    
    if (anaWeightTypeSelected == 0)
    {
        _weightDisplayTextBox.hidden = NO;
        _weightDisplayTextBox.enabled = YES;
    }
    if (anaWeightTypeSelected == 1)
    {
        _textFieldLabelStones.hidden = NO;
        _textFieldLabelPounds.hidden = NO;
        
        _textFieldLabelStones.enabled = YES;
        _textFieldLabelPounds.enabled = YES;
    }
    if (anaWeightTypeSelected == 2)
    {
        _textfieldLabelLbs.hidden = NO;
        _textfieldLabelLbs.enabled = YES;
    }
    
    [self calculateAdrenaline];
    return;
}

- (void) hideAllWeights
{
    _weightDisplayTextBox.hidden = YES;
    _textFieldLabelPounds.hidden = YES;
    _textFieldLabelStones.hidden = YES;
    _textfieldLabelLbs.hidden = YES;
    
    _weightDisplayTextBox.enabled = NO;
    _textfieldLabelLbs.enabled = NO;
    _textFieldLabelPounds.enabled = NO;
    _textFieldLabelStones.enabled = NO;
    return;
}

- (IBAction)weightEnterTextBox:(id)sender
{
    if([[_weightDisplayTextBox text] length] != 0)
    {
        anaWeight = [self.weightDisplayTextBox.text floatValue];
        anaPoundWeight = 2.204 * anaWeight;
        [self displayWeight];
    }
    return;
}
- (IBAction)lbsEnterTextBox:(id)sender
{
    if ([[_textfieldLabelLbs text] length] != 0)
    {
        anaPoundWeight = [_textfieldLabelLbs.text floatValue];
        anaWeight = 0.453 * anaPoundWeight;
        [self displayWeight];
    }
    return;
}
- (IBAction)poundsEnterTextBox:(id)sender
{
    float subPoundWeight;
    float stoneWeight;
    if ([[_textFieldLabelPounds text] length] != 0)
    {
        subPoundWeight = [_textFieldLabelPounds.text floatValue];
    }
    if ([[_textFieldLabelStones text] length] != 0)
    {
        stoneWeight = [_textFieldLabelStones.text floatValue];
    }
    anaPoundWeight = (14 * stoneWeight) + subPoundWeight;
    anaWeight = 0.453 * anaPoundWeight;
    [self displayWeight];
    return;
}
- (IBAction)stonesEnterTextBox:(id)sender
{
    float subPoundWeight;
    float stoneWeight;
    if ([[_textFieldLabelPounds text] length] != 0)
    {
        subPoundWeight = [_textFieldLabelPounds.text floatValue];
    }
    if ([[_textFieldLabelStones text] length] != 0)
    {
        stoneWeight = [_textFieldLabelStones.text floatValue];
    }
    anaPoundWeight = (14 * stoneWeight) + subPoundWeight;
    anaWeight = 0.453 * anaPoundWeight;
    [self displayWeight];
    return;
}


- (IBAction)selectorWeight:(id)sender{
    switch (self.selectorWeight.selectedSegmentIndex)
    {
        case 0:
            anaWeightTypeSelected = 0;
            break;
            
        case 1:
            anaWeightTypeSelected = 1;
            break;
            
        case 2:
            anaWeightTypeSelected = 2;
            
        default:
            break;
            
    }
    [self displayWeight];
    return;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Popup Buttons
UIView *enactBackground;

// Creates an opaque mask to shade out the entire background
- (void) enactBackground
{
    enactBackground = [[UIView alloc] initWithFrame:self.view.bounds];
    enactBackground.backgroundColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:0.6];
    [self.view addSubview:enactBackground];
    [self.view sendSubviewToBack:enactBackground];
    return;
}

-(void) removeBackground
{
    [enactBackground removeFromSuperview];
    return;
}

- (IBAction)buttonCloseDemographics:(id)sender {
    [self.view sendSubviewToBack:_popOverDemographics];
    _popOverDemographics.hidden = YES;
    _popOverDemographics.alpha = 0;
    [self removeBackground];
    [self displayWeight];
    [self calculateAdrenaline];
    [self setPickerLoadValue];
}

- (IBAction)buttonOpenDemographics:(id)sender {
    [self enactBackground];
    _popOverDemographics.hidden = NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_popOverDemographics cache:YES];
    _popOverDemographics.alpha = 1;
    [UIView commitAnimations];
    [self.view bringSubviewToFront:_popOverDemographics];
    return;
}

- (void) calculateAdrenaline
{
    NSLog (@"%li", (long)age);
    NSLog(@"%d", adult);
    if (adult == YES)
    {
        _labelIMDose.text = [NSString stringWithFormat:@"500 mcg (0.5ml 1:1000) IM"];
        _labelIVDose.text = [NSString stringWithFormat:@"50 mcg (0.5ml 1:10,000 - Ten)"];
    }
    if (adult == NO)
    {
        if (age > 12)
        {_labelIMDose.text = [NSString stringWithFormat:@"500 mcg (0.5ml 1:1000) IM"];}
        else if ((age >= 6) && (age <= 12))
        {_labelIMDose.text = [NSString stringWithFormat:@"300 mcg (0.3ml 1:1000) IM"];}
        else if (age < 6)
        {_labelIMDose.text = [NSString stringWithFormat:@"150 mcg (0.15ml 1:1000) IM"];}
        
        if (anaWeight >= 50){_labelIVDose.text = [NSString stringWithFormat:@"50 mcg (0.5ml 1:10,000 - Ten)"];}
        else if (anaWeight < 50)
        {
            _labelIVDose.text = [NSString stringWithFormat:@"%i mcg (%.1fml 1:100,000 - Hundred)",(int) anaWeight, (anaWeight/10)];
        }
    }
}

- (IBAction)button72:(id)sender {
    if ([sender isSelected])
    {
        [sender setSelected:NO];
        [sender setBackgroundImage:[UIImage imageNamed:@"WhiteBackgroundBorderedBlack.png"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setSelected:YES];
        [sender setBackgroundImage:[UIImage imageNamed:@"GreenBackgroundBorderedBlack.png"] forState:UIControlStateSelected];
    }
    return;
}
- (IBAction)button73:(id)sender {
    if ([sender isSelected])
    {
        [sender setSelected:NO];
        [sender setBackgroundImage:[UIImage imageNamed:@"WhiteBackgroundBorderedBlack.png"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setSelected:YES];
        [sender setBackgroundImage:[UIImage imageNamed:@"GreenBackgroundBorderedBlack.png"] forState:UIControlStateSelected];
    }
    return;
}
- (IBAction)button74:(id)sender {
    if ([sender isSelected])
    {
        [sender setSelected:NO];
        [sender setBackgroundImage:[UIImage imageNamed:@"WhiteBackgroundBorderedBlack.png"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setSelected:YES];
        [sender setBackgroundImage:[UIImage imageNamed:@"GreenBackgroundBorderedBlack.png"] forState:UIControlStateSelected];
    }
    return;
}
- (IBAction)button75:(id)sender {
    if ([sender isSelected])
    {
        [sender setSelected:NO];
        [sender setBackgroundImage:[UIImage imageNamed:@"WhiteBackgroundBorderedBlack.png"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setSelected:YES];
        [sender setBackgroundImage:[UIImage imageNamed:@"GreenBackgroundBorderedBlack.png"] forState:UIControlStateSelected];
    }
    return;
}
- (IBAction)button76:(id)sender {
    if ([sender isSelected])
    {
        [sender setSelected:NO];
        [sender setBackgroundImage:[UIImage imageNamed:@"WhiteBackgroundBorderedBlack.png"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setSelected:YES];
        [sender setBackgroundImage:[UIImage imageNamed:@"GreenBackgroundBorderedBlack.png"] forState:UIControlStateSelected];
    }
    return;
}
- (IBAction)button77:(id)sender {
    if ([sender isSelected])
    {
        [sender setSelected:NO];
        [sender setBackgroundImage:[UIImage imageNamed:@"WhiteBackgroundBorderedBlack.png"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setSelected:YES];
        [sender setBackgroundImage:[UIImage imageNamed:@"GreenBackgroundBorderedBlack.png"] forState:UIControlStateSelected];
    }
    return;
}
@end
