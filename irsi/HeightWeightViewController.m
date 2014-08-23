//
//  HeightWeightViewController.m
//  irsi
//
//  Created by Ben Taylor on 21/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "HeightWeightViewController.h"

@interface HeightWeightViewController (){
    NSString * heightWeightTitle;
    NSString * kg;
    NSString * st;
    NSString * lbs;
    NSString * enterWeight;
    NSString * stones;
    NSString * pounds;
    NSString * back;
    NSString * cm;
    NSString * ftIn;
    NSString * feet;
    NSString * inches;
    NSString * enterHeight;
    NSString * bodyMass;
    NSString * saveWeight;
    NSString * weightSaved;
    NSString * saveHeight;
    NSString * heightSaved;
}

@end

@implementation HeightWeightViewController


// Declares local variables
float convWeight = 0;
float convHeight = 0;
float convPoundWeight;
float convInchHeight;
float convIBW;
NSInteger hwweightTypeSelected = 0;
NSInteger hwheightTypeSelected = 0;
bool bmiWeight = NO;
bool bmiHeight = NO;

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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults synchronize];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"heightTypeDefaultSelected"] != nil){
        hwheightTypeSelected = (int)[defaults integerForKey:@"heightTypeDefaultSelected"];}
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"weightTypeDefaultSelected"] != nil){
        hwweightTypeSelected = (int)[defaults integerForKey:@"weightTypeDefaultSelected"];}
    
    if (hwweightTypeSelected == 2){hwweightTypeSelected = 0;}
    
    self.selectorHeight.selectedSegmentIndex = hwheightTypeSelected;
    self.selectorWeight.selectedSegmentIndex = hwweightTypeSelected;
    
    [self displayHeight];
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
    stones = [dict objectForKey:@"Stones"];
    pounds = [dict objectForKey:@"Pounds"];
    feet = [dict objectForKey:@"Feet"];
    inches = [dict objectForKey:@"Inches"];
    enterWeight = [dict objectForKey:@"EnterWeight"];
    enterHeight = [dict objectForKey:@"EnterHeight"];
    bodyMass = [dict objectForKey:@"bodyMass"];
    saveWeight = [dict objectForKey:@"saveWeight"];
    weightSaved = [dict objectForKey:@"weightSaved"];
    saveHeight = [dict objectForKey:@"saveHeight"];
    heightSaved = [dict objectForKey:@"heightSaved"];
    
    [self.buttonSaveHeight setTitle:heightSaved forState:UIControlStateHighlighted];
    [self.buttonSaveHeight setTitle:saveHeight forState:UIControlStateNormal];
    [self.buttonSaveWeight setTitle:saveWeight forState:UIControlStateNormal];
    [self.buttonSaveWeight setTitle:weightSaved forState:UIControlStateHighlighted];
    self.textFieldLabelCM.placeholder = enterHeight;
    self.textfieldLabelFeet.placeholder = feet;
    self.textfieldLabelInches.placeholder = inches;
    self.weightDisplayTextBox.placeholder = enterWeight;
    self.textfieldLabelLbs.placeholder = pounds;
    self.textFieldLabelPounds.placeholder = pounds;
    self.textFieldLabelStones.placeholder = stones;
    self.labelBMI.text = bodyMass;
    [self.selectorHeight setTitle:cm forSegmentAtIndex:0];
    [self.selectorHeight setTitle:ftIn forSegmentAtIndex:1];
    [self.selectorWeight setTitle:kg forSegmentAtIndex:0];
    [self.selectorWeight setTitle:st forSegmentAtIndex:1];
    [self.selectorWeight setTitle:lbs forSegmentAtIndex:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _textFieldLabelCM.inputAccessoryView = toolbar;
    _textfieldLabelFeet.inputAccessoryView = toolbar;
    _textfieldLabelInches.inputAccessoryView = toolbar;
    
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
    if ([_textFieldLabelCM isFirstResponder]){
        [_textFieldLabelCM resignFirstResponder];
    }
    if ([_textfieldLabelFeet isFirstResponder]){
        [_textfieldLabelFeet resignFirstResponder];
    }
    if ([_textfieldLabelInches isFirstResponder]){
        [_textfieldLabelInches resignFirstResponder];
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
    if ([_textFieldLabelCM isFirstResponder] && [touch view] != _textFieldLabelCM) {
        [_textFieldLabelCM resignFirstResponder];
    }
    if ([_textfieldLabelFeet isFirstResponder] && [touch view] != _textfieldLabelFeet) {
        [_textfieldLabelFeet resignFirstResponder];
    }
    if ([_textfieldLabelInches isFirstResponder] && [touch view] != _textfieldLabelInches) {
        [_textfieldLabelInches resignFirstResponder];
    }
    return;
}

- (void) displayWeight
{
    // interrogates the text fields and proceeds to update the others if there is an entry
    if(([[_weightDisplayTextBox text] length] != 0) || ([[_textFieldLabelPounds text] length] != 0) ||([[_textFieldLabelStones text] length] != 0) ||([[_textfieldLabelLbs text] length] != 0))
    {
        // enables boxes to allow the display to be updated
        _weightDisplayTextBox.enabled = YES;
        _textFieldLabelStones.enabled = YES;
        _textFieldLabelPounds.enabled = YES;
        _textfieldLabelLbs.enabled = YES;
        
        _textfieldLabelLbs.text = [NSString stringWithFormat:@"%.1f", convPoundWeight];
        _weightDisplayTextBox.text = [NSString stringWithFormat:@"%.1f", convWeight];
        int stoneWeight = (int) (convPoundWeight / 14);
        float lbsWeight = convPoundWeight - (stoneWeight * 14);
        _textFieldLabelStones.text = [NSString stringWithFormat:@"%i", stoneWeight];
        _textFieldLabelPounds.text = [NSString stringWithFormat:@"%.1f", lbsWeight];
        
        _labelKgDisplay.text = [NSString stringWithFormat:@"= %.1f Kilograms",convWeight];
        _labelStoneDisplay.text = [NSString stringWithFormat:@"= %i Stones, %.1f Pounds", stoneWeight, lbsWeight];
        _labelPoundDisplay.text = [NSString stringWithFormat:@"= %.1f Pounds", convPoundWeight];
        bmiWeight = YES;
        [self bmi];
        return;
    }
    
    [self hideAllWeights];
    
    if (hwweightTypeSelected == 0)
    {
        _weightDisplayTextBox.hidden = NO;
        _weightDisplayTextBox.enabled = YES;
    }
    if (hwweightTypeSelected == 1)
    {
        _textFieldLabelStones.hidden = NO;
        _textFieldLabelPounds.hidden = NO;
        
        _textFieldLabelStones.enabled = YES;
        _textFieldLabelPounds.enabled = YES;
    }
    if (hwweightTypeSelected == 2)
    {
        _textfieldLabelLbs.hidden = NO;
        _textfieldLabelLbs.enabled = YES;
    }
    
    
    return;
}

- (void) displayHeight
{
    // interrogates the text fields and proceeds to update the others if there is an entry
    if (([[_textFieldLabelCM text] length] != 0)||([[_textfieldLabelFeet text] length] != 0) ||([[_textfieldLabelInches text] length] != 0))
    {
        _textFieldLabelCM.enabled = YES;
        _textfieldLabelFeet.enabled = YES;
        _textfieldLabelInches.enabled = YES;
        
        _textFieldLabelCM.text = [NSString stringWithFormat:@"%.1f", convHeight];
        int feetHeight = (int) (convInchHeight / 12);
        float inchbat = convInchHeight - (feetHeight * 12);
        _textfieldLabelFeet.text = [NSString stringWithFormat:@"%i", feetHeight];
        _textfieldLabelInches.text = [NSString stringWithFormat:@"%.1f", inchbat];
        
        _labelCmDisplay.text = [NSString stringWithFormat:@"= %.1f Cm (%.2f Metres)",convHeight, (convHeight/100)];
        _labelFeetDisplay.text = [NSString stringWithFormat:@"= %i Feet, %.1f Inches", feetHeight, inchbat];
        
        bmiHeight = YES;
        [self bmi];
        return;
    }
    
    [self hideAllHeights];
    
    if ((hwheightTypeSelected == 0) || (hwheightTypeSelected == 2))
    {
        _textFieldLabelCM.hidden = NO;
        _textFieldLabelCM.enabled = YES;
    }
    if (hwheightTypeSelected == 1)
    {
        _textfieldLabelFeet.hidden = NO;
        _textfieldLabelInches.hidden = NO;
        
        _textfieldLabelInches.enabled = YES;
        _textfieldLabelFeet.enabled = YES;
    }
    return;
    
}

- (void) bmi
{
    if ((bmiHeight == YES) && (bmiWeight == YES))
    {
        float metreHeight = convHeight/100;
        float heightSquare = metreHeight * metreHeight;
        float bmiValue = (convWeight/ heightSquare);
        _labelBMI.text = [NSString stringWithFormat:@"%@: %.1f Kg/m\u00B2",bodyMass, bmiValue];
    }
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

- (void) hideAllHeights
{
    _textFieldLabelCM.hidden = YES;
    _textfieldLabelFeet.hidden = YES;
    _textfieldLabelInches.hidden = YES;
    
    _textfieldLabelInches.enabled = NO;
    _textfieldLabelFeet.enabled = NO;
    _textFieldLabelCM.enabled = NO;
    
    return;
}

- (IBAction)weightEnterTextBox:(id)sender
{
    if([[_weightDisplayTextBox text] length] != 0)
    {
        convWeight = [self.weightDisplayTextBox.text floatValue];
        convPoundWeight = 2.204 * convWeight;
        [self displayWeight];
    }
    return;
}
- (IBAction)lbsEnterTextBox:(id)sender
{
    if ([[_textfieldLabelLbs text] length] != 0)
    {
        convPoundWeight = [_textfieldLabelLbs.text floatValue];
        convWeight = 0.453 * convPoundWeight;
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
    convPoundWeight = (14 * stoneWeight) + subPoundWeight;
    convWeight = 0.453 * convPoundWeight;
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
    convPoundWeight = (14 * stoneWeight) + subPoundWeight;
    convWeight = 0.453 * convPoundWeight;
    [self displayWeight];
    return;
}


- (IBAction)textFieldLabelCM:(id)sender
{
    if ([[_textFieldLabelCM text] length] != 0)
    {
        convHeight = [_textFieldLabelCM.text floatValue];
        convInchHeight = 0.393700787 * convHeight;
        [self displayHeight];
    }
    return;
}

- (IBAction)textFieldLabelFeet:(id)sender {
    float subInchHeight;
    float feetHeight;
    if ([[_textfieldLabelInches text] length] != 0)
    {
        subInchHeight = [_textfieldLabelInches.text floatValue];
    }
    if ([[_textfieldLabelFeet text] length] != 0)
    {
        feetHeight = [_textfieldLabelFeet.text floatValue];
    }
    convInchHeight = (12 * feetHeight) + subInchHeight;
    convHeight = 2.54 * convInchHeight;
    [self displayHeight];
    return;
}

- (IBAction)textFieldLabelInches:(id)sender {
    float subInchHeight;
    float feetHeight;
    if ([[_textfieldLabelInches text] length] != 0)
    {
        subInchHeight = [_textfieldLabelInches.text floatValue];
    }
    if ([[_textfieldLabelFeet text] length] != 0)
    {
        feetHeight = [_textfieldLabelFeet.text floatValue];
    }
    convInchHeight = (12 * feetHeight) + subInchHeight;
    convHeight = 2.54 * convInchHeight;
    [self displayHeight];
    return;
}

- (IBAction)selectorWeight:(id)sender
{
    switch (self.selectorWeight.selectedSegmentIndex)
    {
        case 0:
            hwweightTypeSelected = 0;
            break;
            
        case 1:
            hwweightTypeSelected = 1;
            break;
            
        case 2:
            hwweightTypeSelected = 2;
            
        default:
            break;
            
    }
    [self displayWeight];
    return;
}

- (IBAction)selectorHeight:(id)sender
{
    switch (self.selectorHeight.selectedSegmentIndex)
    {
        case 0:
            hwheightTypeSelected = 0;
            break;
            
        case 1:
            hwheightTypeSelected = 1;
            break;
            
        case 2:
            hwheightTypeSelected = 2;
            break;
            
        default:
            break;
            
    }
    [self displayHeight];
    return;
}

- (IBAction)buttonSaveWeight:(id)sender {
    if (convWeight != 0)
    {
        Patient *sharedWeight = [Patient sharedWeight];
        [sharedWeight setWeight:[NSNumber numberWithFloat:convWeight]];
    }
}
- (IBAction)buttonSaveHeight:(id)sender {
    if (convHeight != 0)
    {
        Patient *sharedHeight = [Patient sharedHeight];
        [sharedHeight setHeight:[NSNumber numberWithFloat:convHeight]];
    }
}

@end
