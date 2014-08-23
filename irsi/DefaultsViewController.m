//
//  DefaultsViewController.m
//  irsi
//
//  Created by Ben Taylor on 21/07/2014.
//  Copyright (c) 2014 Ben Taylor. All rights reserved.
//

#import "DefaultsViewController.h"

@interface DefaultsViewController ()

@end

@implementation DefaultsViewController

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
    
    [self loadDefaults];
    [self createKeyboardReturnButton];
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
    _textFieldBeepInterval.inputAccessoryView = toolbar;
    _textFieldFlashInterval.inputAccessoryView = toolbar;
    _textFieldPreO2Max.inputAccessoryView = toolbar;
    _textFieldPreO2Min.inputAccessoryView = toolbar;
    _textFieldRocMax.inputAccessoryView = toolbar;
    _textFieldRocMin.inputAccessoryView = toolbar;
    _textFieldVibrateInterval.inputAccessoryView = toolbar;
    
    return;
}

-(void) dismissKeyboard:(id) sender
{
    if ([_textFieldBeepInterval isFirstResponder]){
        [_textFieldBeepInterval resignFirstResponder];
    }
    if ([_textFieldFlashInterval isFirstResponder]){
        [_textFieldFlashInterval resignFirstResponder];
    }
    if ([_textFieldPreO2Max isFirstResponder]){
        [_textFieldPreO2Max resignFirstResponder];
    }
    if ([_textFieldPreO2Min isFirstResponder]){
        [_textFieldPreO2Min resignFirstResponder];
    }
    if ([_textFieldRocMax isFirstResponder]){
        [_textFieldRocMax resignFirstResponder];
    }
    if ([_textFieldRocMin isFirstResponder]){
        [_textFieldRocMin resignFirstResponder];
    }
    if ([_textFieldVibrateInterval isFirstResponder]){
        [_textFieldVibrateInterval resignFirstResponder];
    }

    return;
}

// minimises keyboard on tapping elsewhere on screen
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([_textFieldBeepInterval isFirstResponder] && [touch view] != _textFieldBeepInterval) {
        [_textFieldBeepInterval resignFirstResponder];
    }
    if ([_textFieldFlashInterval isFirstResponder] && [touch view] != _textFieldFlashInterval) {
        [_textFieldFlashInterval resignFirstResponder];
    }
    if ([_textFieldPreO2Max isFirstResponder] && [touch view] != _textFieldPreO2Max) {
        [_textFieldPreO2Max resignFirstResponder];
    }
    if ([_textFieldPreO2Min isFirstResponder] && [touch view] != _textFieldPreO2Min) {
        [_textFieldPreO2Min resignFirstResponder];
    }
    if ([_textFieldRocMax isFirstResponder] && [touch view] != _textFieldRocMax) {
        [_textFieldRocMax resignFirstResponder];
    }
    if ([_textFieldRocMin isFirstResponder] && [touch view] != _textFieldRocMin) {
        [_textFieldRocMin resignFirstResponder];
    }
    if ([_textFieldVibrateInterval isFirstResponder] && [touch view] != _textFieldVibrateInterval) {
        [_textFieldVibrateInterval resignFirstResponder];
    }
    
    return;
}

- (void) loadDefaults
{
    // Synchronises locally saved defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    // Defines variables with default values
    bool phem = NO;
    bool cricoidUsed = YES;
    bool beepOn = YES;
    bool vibrateOn = YES;
    bool flashOn = YES;
    bool preO2Alert = YES;
    bool rocAlert = YES;
    bool periodicAlert = YES;
    NSInteger heightTypeSelected = 0;
    NSInteger weightTypeSelected = 0;
    NSInteger preO2Min = 180;
    NSInteger preO2Max = 300;
    NSInteger rocMin = 60;
    NSInteger rocMax = 120;
    NSInteger drugDisplayTypeSelected = 2;
    NSInteger beepInterval = 30;
    NSInteger vibrateInterval = 30;
    NSInteger flashInterval = 30;
    
    // Loads pre-saved data from NSUserDefaults
    if ([defaults objectForKey:@"PHEM"] != nil){phem = [defaults boolForKey:@"PHEM"];}
    if ([defaults objectForKey:@"heightTypeDefaultSelected"] != nil){heightTypeSelected = [defaults integerForKey:@"heightTypeDefaultSelected"];}
    if ([defaults objectForKey:@"weightTypeDefaultSelected"] != nil){weightTypeSelected = [defaults integerForKey:@"weightTypeDefaultSelected"];}
    if ([defaults objectForKey:@"drugDisplayTypeSelected"] != nil){drugDisplayTypeSelected = [defaults integerForKey:@"drugDisplayTypeSelected"];}
    if ([defaults objectForKey:@"cricoidUsed"] != nil){cricoidUsed = [defaults boolForKey:@"cricoidUsed"];}
    if ([defaults objectForKey:@"preO2Min"] != nil){preO2Min = [defaults integerForKey:@"preO2Min"];}
    if ([defaults objectForKey:@"preO2Max"] != nil){preO2Max = [defaults integerForKey:@"preO2Max"];}
    if ([defaults objectForKey:@"rocMin"] != nil){rocMin = [defaults integerForKey:@"rocMin"];}
    if ([defaults objectForKey:@"rocMax"] != nil){rocMax = [defaults integerForKey:@"rocMax"];}
    
    if ([defaults objectForKey:@"beepOn"] != nil){beepOn = [defaults boolForKey:@"beepOn"];}
    if ([defaults objectForKey:@"vibrateOn"] != nil){vibrateOn = [defaults boolForKey:@"vibrateOn"];}
    if ([defaults objectForKey:@"flashOn"] != nil){flashOn = [defaults boolForKey:@"flashOn"];}
    if ([defaults objectForKey:@"preO2Alert"] != nil){preO2Alert = [defaults boolForKey:@"preO2Alert"];}
    if ([defaults objectForKey:@"rocAlert"] != nil){rocAlert = [defaults boolForKey:@"rocAlert"];}
    if ([defaults objectForKey:@"periodicAlert"] != nil){periodicAlert = [defaults boolForKey:@"periodicAlert"];}
    
    if ([defaults objectForKey:@"beepInterval"] != nil){beepInterval = [defaults integerForKey:@"beepInterval"];}
    if ([defaults objectForKey:@"vibrateInterval"] != nil){vibrateInterval = [defaults integerForKey:@"vibrateInterval"];}
    if ([defaults objectForKey:@"flashInterval"] != nil){flashInterval = [defaults integerForKey:@"flashInterval"];}
    
    // Defines the variables to singletons - if there is a pre-saved default, then saves it.  Else uses the pre-defined defaults
    EventLog *sharedPreHospital = [EventLog sharedPreHospital];
    
    [sharedPreHospital setPreHospital:[NSNumber numberWithBool:phem]];
    
    // Sets the controls in the desired setting
    self.switchPHEM.on = phem;
    self.switchCricoid.on = cricoidUsed;
    self.segmentedHeight.selectedSegmentIndex = heightTypeSelected;
    self.segmentedWeight.selectedSegmentIndex = weightTypeSelected;
    self.segmentedDrugDoseDisplayType.selectedSegmentIndex = drugDisplayTypeSelected;
    self.textFieldPreO2Min.placeholder = [NSString stringWithFormat:@"%li", ((long)preO2Min/60)];
    self.textFieldPreO2Max.placeholder = [NSString stringWithFormat:@"%li", ((long)preO2Max/60)];
    self.textFieldRocMin.placeholder = [NSString stringWithFormat:@"%li", (long)rocMin];
    self.textFieldRocMax.placeholder = [NSString stringWithFormat:@"%li", (long)rocMax];
    self.switchBeepOn.on = beepOn;
    self.switchFlashOn.on = flashOn;
    self.switchVibrateOn.on = vibrateOn;
    self.switchPreO2Alert.on = preO2Alert;
    self.switchRocAlert.on = rocAlert;
    self.switch30SAlert.on = periodicAlert;
    self.textFieldBeepInterval.placeholder = [NSString stringWithFormat:@"%li", (long)beepInterval];
    self.textFieldFlashInterval.placeholder = [NSString stringWithFormat:@"%li", (long)flashInterval];
    self.textFieldVibrateInterval.placeholder = [NSString stringWithFormat:@"%li", (long)vibrateInterval];
}

- (IBAction)switchPHEM:(id)sender
{
    bool switchSetting = self.switchPHEM.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"PHEM"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

- (IBAction)segmentedHeightTypeSelected:(id)sender
{
    NSInteger selectedSegment = self.segmentedHeight.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: selectedSegment forKey:@"heightTypeDefaultSelected"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

- (IBAction)segmentedWeightTypeSelected:(id)sender
{
    NSInteger selectedSegment = self.segmentedWeight.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: selectedSegment forKey:@"weightTypeDefaultSelected"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

- (IBAction)segmentedDrugDoseDisplayType:(id)sender
{
    NSInteger selectedSegment = self.segmentedDrugDoseDisplayType.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger: selectedSegment forKey:@"drugDisplayTypeSelected"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

- (IBAction)switchCricoid:(id)sender{
    bool switchSetting = self.switchCricoid.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"cricoidUsed"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)textFieldPreO2Min:(id)sender{
    {
        float textfield = ([[self textFieldPreO2Min].text floatValue]*60);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"preO2Min"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

-(IBAction)textFieldPreO2Max:(id)sender{
    {
        float textfield = ([[self textFieldPreO2Max].text floatValue]*60);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"preO2Max"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

-(IBAction)textFieldRocMin:(id)sender{
    {
        float textfield = [[self textFieldRocMin].text floatValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"rocMin"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

-(IBAction)textFieldRocMax:(id)sender{
    {
        float textfield = [[self textFieldRocMax].text floatValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"rocMax"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

-(IBAction)switchBeepOn :(id)sender{
    bool switchSetting = self.switchBeepOn.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"beepOn"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)switchVibrateOn:(id)sender{
    bool switchSetting = self.switchVibrateOn.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"vibrateOn"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)switchFlashOn:(id)sender{
    bool switchSetting = self.switchFlashOn.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"flashOn"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)switchPreO2Alert:(id)sender{
    bool switchSetting = self.switchPreO2Alert.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"preO2Alert"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)switchRocAlert:(id)sender{
    bool switchSetting = self.switchRocAlert.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"rocAlert"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)switch30sAlert:(id)sender{
    bool switchSetting = self.switch30SAlert.on;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchSetting forKey:@"periodicAlert"];
    [defaults synchronize];
    [self loadDefaults];
    return;
}

-(IBAction)textFieldBeepInterval:(id)sender{
    {
        float textfield = [[self textFieldBeepInterval].text floatValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"beepInterval"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

-(IBAction)textFieldFlashInterval:(id)sender{
    {
        float textfield = [[self textFieldFlashInterval].text floatValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"flashInterval"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}

-(IBAction)textFieldVibrateInterval:(id)sender{
    {
        float textfield = [[self textFieldVibrateInterval].text floatValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setFloat:textfield forKey:@"vibrateInterval"];
        [defaults synchronize];
    }
    [self loadDefaults];
    return;
}


@end
