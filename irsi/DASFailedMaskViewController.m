//
//  DASFailedMaskViewController.m
//  iRSILastWorkingVersion
//
//  Created by Ben Taylor on 23/06/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "DASFailedMaskViewController.h"

@interface DASFailedMaskViewController ()

@end

@implementation DASFailedMaskViewController

// Declaring local variables
float dasWeight = 70.0;
float dasPoundWeight;
int weightModeSelected = 0;
bool weightIsKnown = NO;
int sugammadexDrugConc = 100;

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
    
    // Getting singleton shared variables
    Patient *sharedWeightKnown = [Patient sharedWeightKnown];
    Patient *sharedWeight = [Patient sharedWeight];
    
    // synchronising known shared variables with local variables
    weightIsKnown = [[sharedWeightKnown weightKnown] boolValue];
    dasWeight = [[sharedWeight weight] floatValue];
    
    // Gets default preferred weight settings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults synchronize];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"weightTypeDefaultSelected"] != nil){
        weightModeSelected = (int)[defaults integerForKey:@"weightTypeDefaultSelected"];}
    
    // sets the segmented control to the preferred weight type, if expressed by the user
    self.selectorWeight.selectedSegmentIndex = weightModeSelected;
    
    // Displays the initial weight, if a known value has been transferred from another scene
    [self displayWeight];
    
    // Creates a return button for the number pad
    [self createKeyboardReturnButton];
    
    // Calls the method to calculate the drug doses
    [self drugDoses];
    return;
}

- (void) displayWeight
{
    // interrogates the text fields and proceeds to update the others if there is an entry
    if(([[_weightDisplayTextBox text] length] != 0) || ([[_textFieldLabelPounds text] length] != 0) ||([[_textFieldLabelStones text] length] != 0) ||([[_textfieldLabelLbs text] length] != 0) || (weightIsKnown == YES))
    {
        // enables boxes to allow the display to be updated
        _weightDisplayTextBox.enabled = YES;
        _textFieldLabelStones.enabled = YES;
        _textFieldLabelPounds.enabled = YES;
        _textfieldLabelLbs.enabled = YES;
        
        _textfieldLabelLbs.text = [NSString stringWithFormat:@"%.1f", dasPoundWeight];
        _weightDisplayTextBox.text = [NSString stringWithFormat:@"%.1f", dasWeight];
        int stoneWeight = (int) (dasPoundWeight / 14);
        float lbsWeight = dasPoundWeight - (stoneWeight * 14);
        _textFieldLabelStones.text = [NSString stringWithFormat:@"%i", stoneWeight];
        _textFieldLabelPounds.text = [NSString stringWithFormat:@"%.1f", lbsWeight];
        weightIsKnown = YES;
        Patient *sharedWeight = [Patient sharedWeight];
        [sharedWeight setWeight:[NSNumber numberWithFloat:dasWeight]];
        [self drugDoses];
    }
    
    // Hides all four weight textfields, then activates the selected one only
    [self hideAllWeights];
    
    if (weightModeSelected == 0)
    {
        _weightDisplayTextBox.hidden = NO;
        _weightDisplayTextBox.enabled = YES;
    }
    if (weightModeSelected == 1)
    {
        _textFieldLabelStones.hidden = NO;
        _textFieldLabelPounds.hidden = NO;
        
        _textFieldLabelStones.enabled = YES;
        _textFieldLabelPounds.enabled = YES;
    }
    if (weightModeSelected == 2)
    {
        _textfieldLabelLbs.hidden = NO;
        _textfieldLabelLbs.enabled = YES;
    }
    
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
        dasWeight = [self.weightDisplayTextBox.text floatValue];
        dasPoundWeight = 2.204 * dasWeight;
        [self displayWeight];
    }
    return;
}
- (IBAction)lbsEnterTextBox:(id)sender
{
    if ([[_textfieldLabelLbs text] length] != 0)
    {
        dasPoundWeight = [_textfieldLabelLbs.text floatValue];
        dasWeight = 0.453 * dasPoundWeight;
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
    dasPoundWeight = (14 * stoneWeight) + subPoundWeight;
    dasWeight = 0.453 * dasPoundWeight;
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
    dasPoundWeight = (14 * stoneWeight) + subPoundWeight;
    dasWeight = 0.453 * dasPoundWeight;
    [self displayWeight];
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Actions for the checklist buttons
- (IBAction)button64:(id)sender {
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

- (IBAction)button65:(id)sender {
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

- (IBAction)button66:(id)sender {
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

- (IBAction)button67:(id)sender {
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
    _sugammadexConc.inputAccessoryView = toolbar;
    
    return;
}

// Code to minimise keyboard on pressing return button
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
    if ([_sugammadexConc isFirstResponder]){
        [_sugammadexConc resignFirstResponder];
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
    if ([_sugammadexConc isFirstResponder] && [touch view] != _sugammadexConc) {
        [_sugammadexConc resignFirstResponder];
    }
    return;
}

// Code for the weight UIsegmentedcontrol
- (IBAction)selectorWeight:(id)sender
{
    switch (self.selectorWeight.selectedSegmentIndex)
    {
        case 0:
            weightModeSelected = 0;
            break;
            
        case 1:
            weightModeSelected = 1;
            break;
            
        case 2:
            weightModeSelected = 2;
            
        default:
            break;
            
    }
    [self displayWeight];
    return;
}

- (void) drugDoses
{
    // Gets and stores the weight/ isAdult status
    Patient *sharedWeight = [Patient sharedWeight];
    dasWeight = [[sharedWeight weight]floatValue];
    
    // Calculates the drug doses by pointing to the relevant drug
    [self sugammadex];
    
    return;
}

- (void) sugammadex
{
    [self sugammadexConc].text = [NSString stringWithFormat:@"%i",sugammadexDrugConc];
    NSString *doseDisplay;
    
    float volMin = ((16* dasWeight)/sugammadexDrugConc);
    
    if (volMin >5)
    {
        //int intVolMax = volMax;
        int intVolMin = volMin;
        doseDisplay = [NSString stringWithFormat:@"%i", intVolMin];
    }
    else
    {
        doseDisplay = [NSString stringWithFormat:@"%.1f", volMin];
    }
    [self labelSugammadexVol].text = doseDisplay;
    [self labelSugammadexVials].text = [NSString stringWithFormat:@"%.1f", (volMin/5)];
    
    return;
}

- (IBAction)sugammadexConc:(id)sender
{
    if ([self sugammadexConc].text != 0)
    {
        sugammadexDrugConc = [[self sugammadexConc].text intValue];
        [self sugammadex];
    }
    return;
}
@end
