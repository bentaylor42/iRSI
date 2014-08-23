//
//  VentCalcViewController.m
//  irsi
//
//  Created by Ben Taylor on 21/08/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "VentCalcViewController.h"

@interface VentCalcViewController (){
    NSString * kg;
    NSString * st;
    NSString * lbs;
    NSString * cm;
    NSString * ftIn;
    NSString * male;
    NSString * female;
    NSString * stones;
    NSString * pounds;
    NSString * enterWeight;
    NSString * enterHeight;
    NSString * feet;
    NSString * inches;
    NSString * ards4Kg;
    NSString * ards6Kg;
    NSString * ards8Kg;
    NSString * enterHeightOrWeight;
    NSString * alsoConsider;
    NSString * permissiveHypercapnoea;
    NSString * limitPlateau;
    NSString * openLung;
    NSString * restrictiveFluids;
    NSString * notIBW;
    NSString * fromIBW;
}

@end

@implementation VentCalcViewController

// Declares local variables
float ardsWeight;
float ardsHeight;
float ardsPoundWeight;
float ardsInchheight;
NSInteger ardsWeightTypeSelected;
NSInteger ardsHeightTypeSelected;
float ardsIdealBW;
bool ardsFemaleGender = NO;
bool ardsManualEntry = NO;
bool ardsWeightisKnown = NO;
bool ardsIbwIsKnown = NO;

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
    
    // Loads external data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults synchronize];
    
    [self loadStrings];
    
    Patient *sharedIdealBodyWeight = [Patient sharedIdealBodyWeight];
    Patient *sharedIbwKnown = [Patient sharedIbwKnown];
    Patient *sharedWeightKnown = [Patient sharedWeightKnown];
    Patient *sharedWeight = [Patient sharedWeight];
    Patient *sharedHeight = [Patient sharedHeight];
    Patient *sharedIsFemale = [Patient sharedIsFemale];
    
    ardsIdealBW = [[sharedIdealBodyWeight idealBodyWeight]floatValue];
    ardsIbwIsKnown = [[sharedIbwKnown ibwKnown] boolValue];
    ardsWeightisKnown = [[sharedWeightKnown weightKnown] boolValue];
    ardsWeight = [[sharedWeight weight] floatValue];
    ardsPoundWeight = ardsWeight * 2.204;
    ardsHeight = [[sharedHeight height] floatValue];
    ardsInchheight = 0.393700787 * ardsHeight;
    ardsFemaleGender = [[sharedIsFemale isFemale]boolValue];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"heightTypeDefaultSelected"] != nil){
        ardsHeightTypeSelected = (int)[defaults integerForKey:@"heightTypeDefaultSelected"];}
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"weightTypeDefaultSelected"] != nil){
        ardsWeightTypeSelected = (int)[defaults integerForKey:@"weightTypeDefaultSelected"];}
    
    self.selectorHeight.selectedSegmentIndex = ardsHeightTypeSelected;
    self.selectorWeight.selectedSegmentIndex = ardsWeightTypeSelected;
    self.genderSelector.selectedSegmentIndex = ardsFemaleGender;
    
    [self displayHeight];
    [self displayWeight];
    [self displayIBW];
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
    kg = [dict objectForKey:@"Kg"];
    st = [dict objectForKey:@"St"];
    lbs = [dict objectForKey:@"Lbs"];
    cm = [dict objectForKey:@"Cm"];
    ftIn = [dict objectForKey:@"FtIn"];
    male = [dict objectForKey:@"Male"];
    female = [dict objectForKey:@"Female"];
    stones = [dict objectForKey:@"Stones"];
    pounds = [dict objectForKey:@"Pounds"];
    enterWeight = [dict objectForKey:@"EnterWeight"];
    enterHeight = [dict objectForKey:@"EnterHeight"];
    feet = [dict objectForKey:@"Feet"];
    inches = [dict objectForKey:@"Inches"];
    ards4Kg = [dict objectForKey:@"ards4Kg"];
    ards6Kg = [dict objectForKey:@"ards6Kg"];
    ards8Kg = [dict objectForKey:@"ards8Kg"];
    enterHeightOrWeight = [dict objectForKey:@"enterHeightOrWeight"];
    alsoConsider = [dict objectForKey:@"alsoConsider"];
    permissiveHypercapnoea = [dict objectForKey:@"permissiveHypercapnoea"];
    limitPlateau = [dict objectForKey:@"limitPlateau"];
    openLung = [dict objectForKey:@"openLung"];
    restrictiveFluids = [dict objectForKey:@"restrictiveFluids"];
    notIBW = [dict objectForKey:@"notIBW"];
    fromIBW = [dict objectForKey:@"fromIBW"];
    
    
    self.textFieldLabelCM.placeholder = enterHeight;
    self.textfieldLabelFeet.placeholder = feet;
    self.textfieldLabelInches.placeholder = inches;
    self.weightDisplayTextBox.placeholder = enterWeight;
    self.textfieldLabelLbs.placeholder = pounds;
    self.textFieldLabelPounds.placeholder = pounds;
    self.textFieldLabelStones.placeholder = stones;
    [self.genderSelector setTitle:male forSegmentAtIndex:0];
    [self.genderSelector setTitle:female forSegmentAtIndex:1];
    [self.selectorHeight setTitle:cm forSegmentAtIndex:0];
    [self.selectorHeight setTitle:ftIn forSegmentAtIndex:1];
    [self.selectorWeight setTitle:kg forSegmentAtIndex:0];
    [self.selectorWeight setTitle:st forSegmentAtIndex:1];
    [self.selectorWeight setTitle:lbs forSegmentAtIndex:2];
    self.label4kg.text = [NSString stringWithFormat:@"%@:",ards4Kg];
    self.label6Kg.text = [NSString stringWithFormat:@"%@:",ards6Kg];
    self.label8kg.text = [NSString stringWithFormat:@"%@:",ards8Kg];
    self.labelWeightType.text = enterHeightOrWeight;
    self.labelAlsoConsier.text = alsoConsider;
    self.labelARDSNetAdvice.text = [NSString stringWithFormat:@"\u2022 %@\n\u2022 %@\u2082O\n\u2022 %@\n\u2022 %@",permissiveHypercapnoea, limitPlateau, openLung, restrictiveFluids];
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
    _textfieldLabelMetres.inputAccessoryView = toolbar;
    _textFieldIBWLbs.inputAccessoryView = toolbar;
    _textFieldIBWPounds.inputAccessoryView = toolbar;
    _textFieldIBWStones.inputAccessoryView = toolbar;
    _textField4Kg.inputAccessoryView = toolbar;
    _textField6Kg.inputAccessoryView = toolbar;
    _textField8Kg.inputAccessoryView = toolbar;
    
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
    if ([_textfieldLabelMetres isFirstResponder]){
        [_textfieldLabelMetres resignFirstResponder];
    }
    if ([_textFieldIBWLbs isFirstResponder]){
        [_textFieldIBWLbs resignFirstResponder];
    }
    if ([_textFieldIBWStones isFirstResponder]){
        [_textFieldIBWStones resignFirstResponder];
    }
    if ([_textFieldIBWPounds isFirstResponder]){
        [_textFieldIBWPounds resignFirstResponder];
    }
    if ([_textField4Kg isFirstResponder]){
        [_textField4Kg resignFirstResponder];
    }
    if ([_textField6Kg isFirstResponder]){
        [_textField6Kg resignFirstResponder];
    }
    if ([_textField8Kg isFirstResponder]){
        [_textField8Kg resignFirstResponder];
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
    if ([_textFieldIBWLbs isFirstResponder] && [touch view] != _textFieldIBWLbs) {
        [_textFieldIBWLbs resignFirstResponder];
    }
    if ([_textfieldLabelMetres isFirstResponder] && [touch view] != _textfieldLabelMetres) {
        [_textfieldLabelMetres resignFirstResponder];
    }
    if ([_textFieldIBWPounds isFirstResponder] && [touch view] != _textFieldIBWPounds) {
        [_textFieldIBWPounds resignFirstResponder];
    }
    if ([_textFieldIBWStones isFirstResponder] && [touch view] != _textFieldIBWStones) {
        [_textFieldIBWStones resignFirstResponder];
    }
    if ([_textField4Kg isFirstResponder] && [touch view] != _textField4Kg) {
        [_textField4Kg resignFirstResponder];
    }
    if ([_textField6Kg isFirstResponder] && [touch view] != _textField6Kg) {
        [_textField6Kg resignFirstResponder];
    }
    if ([_textField8Kg isFirstResponder] && [touch view] != _textField8Kg) {
        [_textField8Kg resignFirstResponder];
    }
    return;
}

- (void) displayWeight
{
    // interrogates the text fields and proceeds to update the others if there is an entry
    if(([[_weightDisplayTextBox text] length] != 0) || ([[_textFieldLabelPounds text] length] != 0) ||([[_textFieldLabelStones text] length] != 0) ||([[_textfieldLabelLbs text] length] != 0) || (ardsWeightisKnown == YES))
    {
        // enables boxes to allow the display to be updated
        _weightDisplayTextBox.enabled = YES;
        _textFieldLabelStones.enabled = YES;
        _textFieldLabelPounds.enabled = YES;
        _textfieldLabelLbs.enabled = YES;
        
        _textfieldLabelLbs.text = [NSString stringWithFormat:@"%.1f", ardsPoundWeight];
        _weightDisplayTextBox.text = [NSString stringWithFormat:@"%.1f", ardsWeight];
        int stoneWeight = (int) (ardsPoundWeight / 14);
        float lbsWeight = ardsPoundWeight - (stoneWeight * 14);
        _textFieldLabelStones.text = [NSString stringWithFormat:@"%i", stoneWeight];
        _textFieldLabelPounds.text = [NSString stringWithFormat:@"%.1f", lbsWeight];
        ardsWeightisKnown = YES;
    }
    
    [self hideAllWeights];
    
    if (ardsWeightTypeSelected == 0)
    {
        _weightDisplayTextBox.hidden = NO;
        _weightDisplayTextBox.enabled = YES;
    }
    if (ardsWeightTypeSelected == 1)
    {
        _textFieldLabelStones.hidden = NO;
        _textFieldLabelPounds.hidden = NO;
        
        _textFieldLabelStones.enabled = YES;
        _textFieldLabelPounds.enabled = YES;
    }
    if (ardsWeightTypeSelected == 2)
    {
        _textfieldLabelLbs.hidden = NO;
        _textfieldLabelLbs.enabled = YES;
    }
    
    [self displayIBW];
    return;
}

- (void) displayHeight
{
    // interrogates the text fields and proceeds to update the others if there is an entry
    if (([[_textFieldLabelCM text] length] != 0) || ([[_textFieldIBWLbs text] length] != 0) ||([[_textFieldIBWPounds text] length] != 0) ||([[_textfieldLabelFeet text] length] != 0) ||([[_textfieldLabelInches text] length] != 0) ||([[_textfieldLabelMetres text] length] != 0) || (ardsIbwIsKnown == YES))
    {
        _textFieldIBWLbs.enabled = YES;
        _textFieldIBWPounds.enabled = YES;
        _textFieldIBWStones.enabled = YES;
        _textFieldLabelCM.enabled = YES;
        _textfieldLabelFeet.enabled = YES;
        _textfieldLabelInches.enabled = YES;
        _textfieldLabelMetres.enabled = YES;
        
        _textFieldLabelCM.text = [NSString stringWithFormat:@"%.1f", ardsHeight];
        _textfieldLabelMetres.text = [NSString stringWithFormat:@"%.1f", ardsIdealBW];
        int feetHeight = (int) (ardsInchheight / 12);
        float inches = ardsInchheight - (feetHeight * 12);
        _textfieldLabelFeet.text = [NSString stringWithFormat:@"%i", feetHeight];
        _textfieldLabelInches.text = [NSString stringWithFormat:@"%.1f", inches];
        float lbsIBW = 2.204 * ardsIdealBW;
        _textFieldIBWLbs.text = [NSString stringWithFormat:@"%.1f", lbsIBW];
        int ibwStones = (int) (lbsIBW / 14);
        float ibwPounds = lbsIBW - (ibwStones*14);
        _textFieldIBWStones.text = [NSString stringWithFormat:@"%i", ibwStones];
        _textFieldIBWPounds.text = [NSString stringWithFormat:@"%.1f", ibwPounds];
        
        Patient *sharedHeight = [Patient sharedHeight];
        [sharedHeight setHeight:[NSNumber numberWithFloat:ardsHeight]];
        
        ardsIbwIsKnown = YES;
    }
    
    [self hideAllHeights];
    
    if (ardsHeightTypeSelected == 0)
    {
        _textFieldLabelCM.hidden = NO;
        _textFieldLabelCM.enabled = YES;
    }
    if (ardsHeightTypeSelected == 1)
    {
        _textfieldLabelFeet.hidden = NO;
        _textfieldLabelInches.hidden = NO;
        
        _textfieldLabelInches.enabled = YES;
        _textfieldLabelFeet.enabled = YES;
    }
    if (ardsHeightTypeSelected == 2)
    {
        if (ardsWeightTypeSelected == 0)
        {
            _textfieldLabelMetres.hidden = NO;
            _textfieldLabelMetres.enabled = YES;
        }
        if (ardsWeightTypeSelected == 1)
        {
            _textFieldIBWStones.hidden = NO;
            _textFieldIBWPounds.hidden = NO;
            
            _textFieldIBWStones.enabled = YES;
            _textFieldIBWPounds.enabled = YES;
        }
        if (ardsWeightTypeSelected == 2)
        {
            _textFieldIBWLbs.hidden = NO;
            _textFieldIBWLbs.enabled = YES;
        }
    }
    [self displayIBW];
    return;
}

- (void) displayIBW
{
    if (ardsIbwIsKnown == NO){ardsIdealBW = ardsWeight;}
    
    if ((ardsIbwIsKnown) || (ardsWeightisKnown))
    {
        [self textField4Kg].text = [NSString stringWithFormat:@"%i mls",(4*(int)ardsIdealBW)];
        [self textField6Kg].text = [NSString stringWithFormat:@"%i mls",(6*(int)ardsIdealBW)];
        [self textField8Kg].text = [NSString stringWithFormat:@"%i mls",(8*(int)ardsIdealBW)];
        
        if (ardsIbwIsKnown == YES)
        {
            [self labelWeightType].text = fromIBW;
            [self labelWeightType].backgroundColor = [UIColor colorWithRed:182.0f/255.0f green:215.0f/255.0f blue:168.0f/255.0f alpha:1.0];
        }
        else if (ardsWeightisKnown == YES)
        {
            [self labelWeightType].text = notIBW;
            [self labelWeightType].backgroundColor = [UIColor colorWithRed:249.0f/255.0f green:203.0f/255.0f blue:156.0f/255.0f alpha:1.0];
        }
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

- (void) hideAllHeights
{
    _textFieldLabelCM.hidden = YES;
    _textfieldLabelFeet.hidden = YES;
    _textfieldLabelInches.hidden = YES;
    _textfieldLabelMetres.hidden = YES;
    _textFieldIBWLbs.hidden = YES;
    _textFieldIBWPounds.hidden = YES;
    _textFieldIBWStones.hidden = YES;
    
    _textfieldLabelMetres.enabled = NO;
    _textfieldLabelInches.enabled = NO;
    _textfieldLabelFeet.enabled = NO;
    _textFieldLabelCM.enabled = NO;
    _textFieldIBWLbs.enabled = NO;
    _textFieldIBWPounds.enabled = NO;
    _textFieldIBWStones.enabled = NO;
    return;
}

- (void) calculateIBW
{
    Patient *sharedIdealBodyWeight = [Patient sharedIdealBodyWeight];
    Patient *sharedIsFemale = [Patient sharedIsFemale];
    Patient *sharedIbwKnown = [Patient sharedIbwKnown];
    ardsFemaleGender = [[sharedIsFemale isFemale] boolValue];
    
    if (ardsFemaleGender == NO)
    {
        ardsIdealBW = 50 + (2.3 * (ardsInchheight - 60));
    }
    if (ardsFemaleGender == YES)
    {
        ardsIdealBW = 45.5 + (2.3 * (ardsInchheight - 60));
    }
    
    if (ardsIdealBW > 0)
    {
        [sharedIbwKnown setIbwKnown:[NSNumber numberWithBool:YES]];
        ardsIbwIsKnown = YES;
        [sharedIdealBodyWeight setIdealBodyWeight:[NSNumber numberWithFloat:ardsIdealBW]];
    }
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textField4Kg:(id)sender {
    float entry = [[self textField4Kg].text floatValue];
    float ibw = entry/4;
    int tidalVolume4 = ibw * 4;
    int tidalVolume6 = ibw * 6;
    int tidalVolume8 = ibw * 8;
    if (ardsManualEntry == NO)
    {
        [self textField4Kg].text = [NSString stringWithFormat:@"%i mls",tidalVolume4];
        [self textField6Kg].text = [NSString stringWithFormat:@"%i mls",tidalVolume6];
        [self textField8Kg].text = [NSString stringWithFormat:@"%i mls",tidalVolume8];
        ardsManualEntry = YES;
        [self labelWeightType].text = @"From Manual Entry";
        [self labelWeightType].backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0];
        [self labelWeightType].textColor = [UIColor redColor];
    }
    return;
}

- (IBAction)textField6Kg:(id)sender
{
    float entry = [[self textField6Kg].text floatValue];
    float ibw = entry/6;
    int tidalVolume4 = ibw * 4;
    int tidalVolume6 = ibw * 6;
    int tidalVolume8 = ibw * 8;
    if (ardsManualEntry == NO)
    {
        [self textField4Kg].text = [NSString stringWithFormat:@"%i mls",tidalVolume4];
        [self textField6Kg].text = [NSString stringWithFormat:@"%i mls",tidalVolume6];
        [self textField8Kg].text = [NSString stringWithFormat:@"%i mls",tidalVolume8];
        ardsManualEntry = YES;
        [self labelWeightType].text = @"From Manual Entry";
        [self labelWeightType].backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0];
        [self labelWeightType].textColor = [UIColor redColor];
    }
    return;
}
- (IBAction)textField8Kg:(id)sender
{
    float entry = [[self textField8Kg].text floatValue];
    float ibw = entry/8;
    int tidalVolume4 = ibw * 4;
    int tidalVolume6 = ibw * 6;
    int tidalVolume8 = ibw * 8;
    if (ardsManualEntry == NO)
    {
        [self textField4Kg].text = [NSString stringWithFormat:@"%i mls",tidalVolume4];
        [self textField6Kg].text = [NSString stringWithFormat:@"%i mls",tidalVolume6];
        [self textField8Kg].text = [NSString stringWithFormat:@"%i mls",tidalVolume8];
        ardsManualEntry = YES;
        [self labelWeightType].text = @"From Manual Entry";
        [self labelWeightType].backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1.0];
        [self labelWeightType].textColor = [UIColor redColor];
    }
    return;
}

- (IBAction)genderSelector:(UISegmentedControl *) sender
{
    Patient *sharedIsFemale = [Patient sharedIsFemale];
    
    switch (self.genderSelector.selectedSegmentIndex)
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
    [self calculateIBW];
    [self displayIBW];
    return;
}
- (IBAction)selectorWeight:(id)sender
{
    switch (self.selectorWeight.selectedSegmentIndex)
    {
        case 0:
            ardsWeightTypeSelected = 0;
            break;
            
        case 1:
            ardsWeightTypeSelected = 1;
            break;
            
        case 2:
            ardsWeightTypeSelected = 2;
            
        default:
            break;
            
    }
    [self displayWeight];
    [self displayHeight];
    return;
}
- (IBAction)selectorHeight:(id)sender
{
    switch (self.selectorHeight.selectedSegmentIndex)
    {
        case 0:
            ardsHeightTypeSelected = 0;
            break;
            
        case 1:
            ardsHeightTypeSelected = 1;
            break;
            
        case 2:
            ardsHeightTypeSelected = 2;
            break;
            
        default:
            break;
            
    }
    [self displayHeight];
    return;
}

- (IBAction)weightEnterTextBox:(id)sender
{
    if([[_weightDisplayTextBox text] length] != 0)
    {
        ardsWeight = [self.weightDisplayTextBox.text floatValue];
        ardsPoundWeight = 2.204 * ardsWeight;
        [self displayWeight];
    }
    return;
}
- (IBAction)lbsEnterTextBox:(id)sender
{
    if ([[_textfieldLabelLbs text] length] != 0)
    {
        ardsPoundWeight = [_textfieldLabelLbs.text floatValue];
        ardsWeight = 0.453 * ardsPoundWeight;
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
    ardsPoundWeight = (14 * stoneWeight) + subPoundWeight;
    ardsWeight = 0.453 * ardsPoundWeight;
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
    ardsPoundWeight = (14 * stoneWeight) + subPoundWeight;
    ardsWeight = 0.453 * ardsPoundWeight;
    [self displayWeight];
    return;
}

- (IBAction)textFieldLabelCM:(id)sender
{
    if ([[_textFieldLabelCM text] length] != 0)
    {
        ardsHeight = [_textFieldLabelCM.text floatValue];
        ardsInchheight = 0.393700787 * ardsHeight;
        [self calculateIBW];
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
    ardsInchheight = (12 * feetHeight) + subInchHeight;
    ardsHeight = 2.54 * ardsInchheight;
    [self calculateIBW];
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
    ardsInchheight = (12 * feetHeight) + subInchHeight;
    ardsHeight = 2.54 * ardsInchheight;
    [self calculateIBW];
    [self displayHeight];
    return;
}

- (IBAction)textFieldIBW:(id)sender
{
    Patient *sharedIdealBodyWeight = [Patient sharedIdealBodyWeight];
    Patient *sharedIsFemale = [Patient sharedIsFemale];
    Patient *sharedIbwKnown = [Patient sharedIbwKnown];
    ardsFemaleGender = [[sharedIsFemale isFemale] boolValue];
    
    if ([[_textfieldLabelMetres text] length] != 0)
    {
        ardsIdealBW = [_textfieldLabelMetres.text floatValue];
        [sharedIbwKnown setIbwKnown:[NSNumber numberWithBool:YES]];
        [sharedIdealBodyWeight setIdealBodyWeight:[NSNumber numberWithFloat:ardsIdealBW]];
        if (ardsFemaleGender == NO){ardsInchheight = 60 + ((ardsIdealBW - 50)/2.3);}
        if (ardsFemaleGender == YES){ardsInchheight = 60 + ((ardsIdealBW - 45.5)/2.3);}
        ardsHeight = 2.54 *ardsInchheight;
        [self displayHeight];
    }
    return;
}
- (IBAction)textFieldIBWLbs:(id)sender
{
    Patient *sharedIdealBodyWeight = [Patient sharedIdealBodyWeight];
    Patient *sharedIsFemale = [Patient sharedIsFemale];
    Patient *sharedIbwKnown = [Patient sharedIbwKnown];
    ardsFemaleGender = [[sharedIsFemale isFemale] boolValue];
    
    if ([[_textFieldIBWLbs text] length] != 0)
    {
        float lbsIBW = [_textFieldIBWLbs.text floatValue];
        ardsIdealBW = 0.453 * lbsIBW;
        [sharedIbwKnown setIbwKnown:[NSNumber numberWithBool:YES]];
        [sharedIdealBodyWeight setIdealBodyWeight:[NSNumber numberWithFloat:ardsIdealBW]];
        if (ardsFemaleGender == NO){ardsInchheight = 60 + ((ardsIdealBW - 50)/2.3);}
        if (ardsFemaleGender == YES){ardsInchheight = 60 + ((ardsIdealBW - 45.5)/2.3);}
        ardsHeight = 2.54 *ardsInchheight;
        [self displayHeight];
        return;
    }
}
- (IBAction)textFieldIBWPounds:(id)sender
{
    Patient *sharedIdealBodyWeight = [Patient sharedIdealBodyWeight];
    Patient *sharedIsFemale = [Patient sharedIsFemale];
    Patient *sharedIbwKnown = [Patient sharedIbwKnown];
    ardsFemaleGender = [[sharedIsFemale isFemale] boolValue];
    float stonesIBW;
    float poundsIBW;
    if ([[_textFieldIBWStones text] length] != 0)
    {
        stonesIBW = [_textFieldIBWStones.text floatValue];
    }
    if ([[_textFieldIBWPounds text] length]!= 0)
    {
        poundsIBW = [_textFieldIBWPounds.text floatValue];
    }
    float lbsIBW = (14* stonesIBW) + poundsIBW;
    ardsIdealBW = 0.453 * lbsIBW;
    [sharedIbwKnown setIbwKnown:[NSNumber numberWithBool:YES]];
    [sharedIdealBodyWeight setIdealBodyWeight:[NSNumber numberWithFloat:ardsIdealBW]];
    if (ardsFemaleGender == NO){ardsInchheight = 60 + ((ardsIdealBW - 50)/2.3);}
    if (ardsFemaleGender == YES){ardsInchheight = 60 + ((ardsIdealBW - 45.5)/2.3);}
    ardsHeight = 2.54 *ardsInchheight;
    [self displayHeight];
    return;
}
- (IBAction)textFieldIBWStones:(id)sender
{
    Patient *sharedIdealBodyWeight = [Patient sharedIdealBodyWeight];
    Patient *sharedIsFemale = [Patient sharedIsFemale];
    Patient *sharedIbwKnown = [Patient sharedIbwKnown];
    ardsFemaleGender = [[sharedIsFemale isFemale] boolValue];
    float stonesIBW;
    float poundsIBW;
    if ([[_textFieldIBWStones text] length] != 0)
    {
        stonesIBW = [_textFieldIBWStones.text floatValue];
    }
    if ([[_textFieldIBWPounds text] length]!= 0)
    {
        poundsIBW = [_textFieldIBWPounds.text floatValue];
    }
    float lbsIBW = (14* stonesIBW) + poundsIBW;
    ardsIdealBW = 0.453 * lbsIBW;
    [sharedIbwKnown setIbwKnown:[NSNumber numberWithBool:YES]];
    [sharedIdealBodyWeight setIdealBodyWeight:[NSNumber numberWithFloat:ardsIdealBW]];
    if (ardsFemaleGender == NO){ardsInchheight = 60 + ((ardsIdealBW - 50)/2.3);}
    if (ardsFemaleGender == YES){ardsInchheight = 60 + ((ardsIdealBW - 45.5)/2.3);}
    ardsHeight = 2.54 *ardsInchheight;
    [self displayHeight];
    return;
}

@end
